import { useEffect, useState } from 'react'
import { AlertCircle, Loader2, MessagesSquare } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import CommentForm from './CommentForm'
import CommentList from './CommentList'

const SELECT =
  'id, user_id, content, parent_id, rating, likes_count, created_at, updated_at, deleted_at'

// Mismo limite que el disparador de la base de datos. Aqui solo sirve para
// avisar antes de gastar el viaje; el que manda es el del servidor.
const MAX_PER_MINUTE = 5

// De lista plana a arbol. Cada comentario recibe un array "replies" con sus
// hijos ya ordenados, y arriba quedan solo los que no cuelgan de nadie.
function buildTree(rows) {
  const byId = new Map(rows.map((row) => [row.id, { ...row, replies: [] }]))
  const roots = []

  for (const row of byId.values()) {
    const parent = row.parent_id ? byId.get(row.parent_id) : null
    if (parent) {
      parent.replies.push(row)
    } else {
      roots.push(row)
    }
  }

  // Arriba lo mas reciente; dentro de un hilo, en orden de conversacion.
  const byNewest = (a, b) => new Date(b.created_at) - new Date(a.created_at)
  const byOldest = (a, b) => new Date(a.created_at) - new Date(b.created_at)

  for (const row of byId.values()) {
    row.replies.sort(byOldest)
  }
  roots.sort(byNewest)

  return roots
}

function CommentsSection() {
  const { t } = useI18n()

  const [userId, setUserId] = useState(null)
  const [rows, setRows] = useState([])
  const [likedIds, setLikedIds] = useState(() => new Set())
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')

  const [busyId, setBusyId] = useState(null)
  const [isPosting, setIsPosting] = useState(false)
  const [replyingTo, setReplyingTo] = useState(null)
  const [editingId, setEditingId] = useState(null)
  const [confirmingId, setConfirmingId] = useState(null)

  useEffect(() => {
    let active = true

    // Los comentarios son publicos, asi que se cargan haya sesion o no.
    const loadComments = async () => {
      const { data, error: loadError } = await supabase
        .from('comments')
        .select(`${SELECT}, profiles ( username )`)
        .order('created_at', { ascending: false })

      if (!active) {
        return
      }

      if (loadError) {
        setError(t('comments.error.load', { message: loadError.message }))
        setRows([])
      } else {
        setError('')
        setRows(
          (data ?? []).map((row) => ({ ...row, author: row.profiles?.username ?? null })),
        )
      }

      setIsLoading(false)
    }

    const loadLikes = async (id) => {
      const { data } = await supabase
        .from('comment_likes')
        .select('comment_id')
        .eq('user_id', id)

      if (active) {
        setLikedIds(new Set((data ?? []).map((like) => like.comment_id)))
      }
    }

    supabase.auth.getSession().then(({ data }) => {
      if (!active) {
        return
      }
      const id = data.session?.user?.id ?? null
      setUserId(id)
      if (id) {
        loadLikes(id)
      }
    })

    loadComments()

    return () => {
      active = false
    }
  }, [t])

  // Traduce los codigos que lanzan los disparadores de la base de datos.
  const describeError = (writeError) => {
    const message = writeError?.message ?? ''
    if (message.includes('comment_offensive')) {
      return t('comments.error.offensive')
    }
    if (message.includes('comment_rate_limit')) {
      return t('comments.error.rateLimit')
    }
    if (message.includes('comment_not_yours')) {
      return t('comments.error.notYours')
    }
    return t('comments.error.save', { message })
  }

  // Vuelve a leer solo la fila que acaba de cambiar, para no recargar la lista
  // entera y perder los hilos desplegados.
  const fetchRow = async (id) => {
    const { data } = await supabase
      .from('comments')
      .select(`${SELECT}, profiles ( username )`)
      .eq('id', id)
      .maybeSingle()

    return data ? { ...data, author: data.profiles?.username ?? null } : null
  }

  const closePanels = () => {
    setReplyingTo(null)
    setEditingId(null)
    setConfirmingId(null)
  }

  const postComment = async ({ content, rating }, parentId) => {
    if (!userId) {
      setError(t('comments.error.signedOut'))
      return false
    }

    const minuteAgo = Date.now() - 60_000
    const mineLately = rows.filter(
      (row) => row.user_id === userId && new Date(row.created_at).getTime() > minuteAgo,
    )
    if (mineLately.length >= MAX_PER_MINUTE) {
      setError(t('comments.error.rateLimit'))
      return false
    }

    if (parentId) {
      setBusyId(parentId)
    } else {
      setIsPosting(true)
    }

    const { data, error: insertError } = await supabase
      .from('comments')
      .insert({
        user_id: userId,
        content,
        rating: parentId ? null : rating,
        parent_id: parentId ?? null,
      })
      .select(`${SELECT}, profiles ( username )`)
      .maybeSingle()

    setBusyId(null)
    setIsPosting(false)

    if (insertError) {
      setError(describeError(insertError))
      return false
    }

    setError('')
    if (data) {
      setRows((current) => [
        { ...data, author: data.profiles?.username ?? null },
        ...current,
      ])
    }
    closePanels()
    return true
  }

  const handleEdit = async (comment, { content, rating }) => {
    setBusyId(comment.id)

    const { error: updateError } = await supabase
      .from('comments')
      .update({ content, rating: comment.parent_id ? null : rating })
      .eq('id', comment.id)

    if (updateError) {
      setBusyId(null)
      setError(describeError(updateError))
      return false
    }

    // updated_at lo pone un disparador, asi que hay que releer la fila para
    // que aparezca la marca de "editado".
    const fresh = await fetchRow(comment.id)
    setBusyId(null)
    setError('')

    if (fresh) {
      setRows((current) => current.map((row) => (row.id === fresh.id ? fresh : row)))
    }
    closePanels()
    return true
  }

  // El borrado lo decide el servidor: si el comentario tiene respuestas se
  // vacia y la fila se queda sosteniendo el hilo; si no, desaparece (y con el,
  // los padres ya vaciados que se queden sin ninguna respuesta).
  const handleDelete = async (comment) => {
    setBusyId(comment.id)

    const { data, error: deleteError } = await supabase.rpc('delete_comment', {
      target: comment.id,
    })

    setBusyId(null)

    if (deleteError) {
      setError(describeError(deleteError))
      return
    }

    if (data?.soft) {
      setRows((current) =>
        current.map((row) =>
          row.id === comment.id
            ? { ...row, content: '', rating: null, deleted_at: new Date().toISOString() }
            : row,
        ),
      )
    } else {
      const removed = new Set(data?.removed ?? [comment.id])
      setRows((current) => current.filter((row) => !removed.has(row.id)))
    }

    setError('')
    closePanels()
  }

  const handleToggleLike = async (comment) => {
    if (!userId) {
      setError(t('comments.error.signedOut'))
      return
    }

    const wasLiked = likedIds.has(comment.id)

    // Se pinta al momento y se deshace si el servidor dice que no.
    setLikedIds((current) => {
      const next = new Set(current)
      if (wasLiked) {
        next.delete(comment.id)
      } else {
        next.add(comment.id)
      }
      return next
    })
    setRows((current) =>
      current.map((row) =>
        row.id === comment.id
          ? { ...row, likes_count: Math.max(row.likes_count + (wasLiked ? -1 : 1), 0) }
          : row,
      ),
    )

    const query = wasLiked
      ? supabase
          .from('comment_likes')
          .delete()
          .eq('user_id', userId)
          .eq('comment_id', comment.id)
      : supabase.from('comment_likes').insert({ user_id: userId, comment_id: comment.id })

    const { error: likeError } = await query

    if (likeError) {
      setLikedIds((current) => {
        const next = new Set(current)
        if (wasLiked) {
          next.add(comment.id)
        } else {
          next.delete(comment.id)
        }
        return next
      })
      setRows((current) =>
        current.map((row) =>
          row.id === comment.id
            ? { ...row, likes_count: Math.max(row.likes_count + (wasLiked ? 1 : -1), 0) }
            : row,
        ),
      )
      setError(t('comments.error.like', { message: likeError.message }))
    }
  }

  const tree = buildTree(rows)

  return (
    <section className="mt-12 rounded-3xl border border-white/10 bg-white/[0.02] p-5 sm:p-8">
      <header className="mb-6">
        <h2 className="flex items-center gap-2.5 text-xl font-semibold tracking-tight text-white">
          <MessagesSquare className="h-5 w-5 text-[#7aa7ff]" />
          {t('comments.title')}
          {!isLoading && rows.length > 0 && (
            <span className="text-sm font-normal text-zinc-500">
              {t(rows.length === 1 ? 'comments.count' : 'comments.countPlural', {
                count: rows.length,
              })}
            </span>
          )}
        </h2>
        <p className="mt-1.5 text-sm text-zinc-500">{t('comments.subtitle')}</p>
      </header>

      {error && (
        <div className="mb-5 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
          <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
          <p>{error}</p>
        </div>
      )}

      {userId ? (
        <div className="mb-8">
          <CommentForm variant="root" isBusy={isPosting} onSubmit={(values) => postComment(values)} />
        </div>
      ) : (
        <p className="mb-8 rounded-xl border border-white/10 bg-white/[0.03] px-4 py-3 text-sm text-zinc-400">
          {t('comments.signedOut')}
        </p>
      )}

      {isLoading ? (
        <div className="flex items-center justify-center gap-2.5 py-12 text-zinc-500">
          <Loader2 className="h-5 w-5 animate-spin" />
          {t('common.loading')}
        </div>
      ) : (
        <CommentList
          comments={tree}
          currentUserId={userId}
          likedIds={likedIds}
          busyId={busyId}
          replyingTo={replyingTo}
          editingId={editingId}
          confirmingId={confirmingId}
          onStartReply={(id) => {
            closePanels()
            setReplyingTo(id)
          }}
          onStartEdit={(id) => {
            closePanels()
            setEditingId(id)
          }}
          onAskDelete={(id) => {
            closePanels()
            setConfirmingId(id)
          }}
          onCancel={closePanels}
          onReply={(comment, values) => postComment(values, comment.id)}
          onEdit={handleEdit}
          onDelete={handleDelete}
          onToggleLike={handleToggleLike}
        />
      )}
    </section>
  )
}

export default CommentsSection

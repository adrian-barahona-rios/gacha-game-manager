import { useState } from 'react'
import { Heart, Loader2, MessageSquare, Pencil, Star, Trash2 } from 'lucide-react'
import { useI18n } from '../i18n/useI18n'
import CommentForm from './CommentForm'

// Sangrado de los hilos. A partir del cuarto nivel se deja de sangrar: en un
// movil el texto se quedaria en una columna de dos palabras.
const MAX_INDENT_DEPTH = 4

function formatDate(value, language) {
  return new Date(value).toLocaleDateString(language === 'en' ? 'en-GB' : 'es-ES', {
    day: 'numeric',
    month: 'short',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  })
}

// Un comentario y, debajo, sus respuestas. Se llama a si mismo por cada nivel.
function CommentThread({
  comment,
  depth = 0,
  currentUserId,
  likedIds,
  busyId,
  replyingTo,
  editingId,
  confirmingId,
  onStartReply,
  onStartEdit,
  onAskDelete,
  onCancel,
  onReply,
  onEdit,
  onDelete,
  onToggleLike,
}) {
  const { t, activeLanguage } = useI18n()
  const [collapsed, setCollapsed] = useState(false)

  const isDeleted = Boolean(comment.deleted_at)
  const isMine = currentUserId === comment.user_id && !isDeleted
  const isLiked = likedIds.has(comment.id)
  const isBusy = busyId === comment.id
  const isEditing = editingId === comment.id
  const isReplying = replyingTo === comment.id
  const isConfirming = confirmingId === comment.id
  const replies = comment.replies ?? []
  const author = isDeleted
    ? t('comments.deletedAuthor')
    : (comment.author ?? t('comments.unknownUser'))
  const edited = !isDeleted && comment.updated_at && comment.updated_at !== comment.created_at

  return (
    <article
      className={
        depth === 0
          ? 'rounded-2xl border border-white/10 bg-white/[0.02] p-4 sm:p-5'
          : 'border-l-2 border-white/10 pl-4 sm:pl-5'
      }
    >
      <header className="mb-2.5 flex flex-wrap items-center gap-x-3 gap-y-1.5">
        <span
          className={`flex h-8 w-8 shrink-0 items-center justify-center rounded-full text-sm font-semibold uppercase ring-1 ${
            isDeleted
              ? 'bg-white/5 text-zinc-600 ring-white/10'
              : 'bg-[#0066ff]/20 text-[#7aa7ff] ring-[#0066ff]/30'
          }`}
        >
          {isDeleted ? '·' : author.slice(0, 1)}
        </span>

        <span className={`text-sm font-semibold ${isDeleted ? 'text-zinc-600' : 'text-white'}`}>
          {author}
        </span>

        {isMine && (
          <span className="rounded-full bg-white/10 px-2 py-0.5 text-[10px] font-semibold uppercase tracking-wide text-zinc-300">
            {t('comments.you')}
          </span>
        )}

        <span className="text-xs text-zinc-500">
          {formatDate(comment.created_at, activeLanguage)}
          {edited ? ` · ${t('comments.edited')}` : ''}
        </span>

        {!isDeleted && comment.rating !== null && comment.rating !== undefined && (
          <span
            className="flex items-center gap-0.5"
            aria-label={t('comments.ratingLabel', { value: comment.rating })}
          >
            {[1, 2, 3, 4, 5].map((value) => (
              <Star
                key={value}
                className={`h-3.5 w-3.5 ${
                  value <= comment.rating ? 'fill-amber-400 text-amber-400' : 'text-zinc-700'
                }`}
              />
            ))}
          </span>
        )}
      </header>

      {isEditing ? (
        <CommentForm
          variant="edit"
          initialContent={comment.content}
          initialRating={comment.rating ?? null}
          isBusy={isBusy}
          autoFocus
          onCancel={onCancel}
          onSubmit={(values) => onEdit(comment, values)}
        />
      ) : isDeleted ? (
        <p className="text-[15px] italic leading-relaxed text-zinc-600">
          {t('comments.deletedBody')}
        </p>
      ) : (
        <p className="whitespace-pre-wrap break-words text-[15px] leading-relaxed text-zinc-300">
          {comment.content}
        </p>
      )}

      {!isEditing && !isDeleted && (
        <div className="mt-3 flex flex-wrap items-center gap-1">
          <button
            type="button"
            onClick={() => onToggleLike(comment)}
            disabled={!currentUserId}
            title={currentUserId ? undefined : t('comments.likeSignedOut')}
            aria-pressed={isLiked}
            className={`flex items-center gap-1.5 rounded-lg px-2.5 py-1.5 text-sm transition-all duration-300 focus:outline-none focus:ring-2 focus:ring-rose-500/40 active:scale-95 disabled:cursor-not-allowed disabled:opacity-40 ${
              isLiked
                ? 'text-rose-400 hover:bg-rose-500/10'
                : 'text-zinc-500 hover:bg-white/5 hover:text-rose-300'
            }`}
          >
            <Heart className={`h-4 w-4 ${isLiked ? 'fill-rose-400' : ''}`} />
            {comment.likes_count > 0 && <span>{comment.likes_count}</span>}
          </button>

          <button
            type="button"
            onClick={() => onStartReply(comment.id)}
            disabled={!currentUserId}
            title={currentUserId ? undefined : t('comments.replySignedOut')}
            className="flex items-center gap-1.5 rounded-lg px-2.5 py-1.5 text-sm text-zinc-500 transition-all duration-300 hover:bg-white/5 hover:text-white focus:outline-none focus:ring-2 focus:ring-white/20 active:scale-95 disabled:cursor-not-allowed disabled:opacity-40"
          >
            <MessageSquare className="h-4 w-4" />
            {t('comments.reply')}
          </button>

          {replies.length > 0 && (
            <button
              type="button"
              onClick={() => setCollapsed((current) => !current)}
              className="rounded-lg px-2.5 py-1.5 text-sm text-zinc-500 transition-all duration-300 hover:bg-white/5 hover:text-white focus:outline-none focus:ring-2 focus:ring-white/20 active:scale-95"
            >
              {collapsed
                ? t(replies.length === 1 ? 'comments.showReply' : 'comments.showReplies', {
                    count: replies.length,
                  })
                : t('comments.hideReplies')}
            </button>
          )}

          {isMine && (
            <>
              <button
                type="button"
                onClick={() => onStartEdit(comment.id)}
                className="ml-auto flex items-center gap-1.5 rounded-lg px-2.5 py-1.5 text-sm text-zinc-500 transition-all duration-300 hover:bg-white/5 hover:text-white focus:outline-none focus:ring-2 focus:ring-white/20 active:scale-95"
              >
                <Pencil className="h-4 w-4" />
                {t('common.edit')}
              </button>

              <button
                type="button"
                onClick={() => onAskDelete(comment.id)}
                className="flex items-center gap-1.5 rounded-lg px-2.5 py-1.5 text-sm text-zinc-500 transition-all duration-300 hover:bg-red-500/10 hover:text-red-300 focus:outline-none focus:ring-2 focus:ring-red-500/40 active:scale-95"
              >
                <Trash2 className="h-4 w-4" />
                {t('common.delete')}
              </button>
            </>
          )}
        </div>
      )}

      {isDeleted && replies.length > 0 && (
        <div className="mt-3">
          <button
            type="button"
            onClick={() => setCollapsed((current) => !current)}
            className="rounded-lg px-2.5 py-1.5 text-sm text-zinc-600 transition-all duration-300 hover:bg-white/5 hover:text-zinc-300 focus:outline-none focus:ring-2 focus:ring-white/20 active:scale-95"
          >
            {collapsed
              ? t(replies.length === 1 ? 'comments.showReply' : 'comments.showReplies', {
                  count: replies.length,
                })
              : t('comments.hideReplies')}
          </button>
        </div>
      )}

      {isConfirming && (
        <div className="mt-3 rounded-xl border border-red-500/30 bg-red-500/[0.07] p-3.5">
          <p className="mb-3 text-sm text-red-100">
            {replies.length > 0
              ? t(
                  replies.length === 1
                    ? 'comments.delete.confirmWithReply'
                    : 'comments.delete.confirmWithReplies',
                  { count: replies.length },
                )
              : t('comments.delete.confirm')}
          </p>
          <div className="flex flex-wrap gap-2">
            <button
              type="button"
              onClick={() => onDelete(comment)}
              disabled={isBusy}
              className="flex items-center gap-2 rounded-lg bg-red-600 px-4 py-2 text-sm font-semibold text-white transition-all duration-300 hover:bg-red-500 hover:shadow-[0_0_20px_rgba(220,38,38,0.5)] focus:outline-none focus:ring-4 focus:ring-red-500/30 active:scale-95 disabled:opacity-50"
            >
              {isBusy ? <Loader2 className="h-4 w-4 animate-spin" /> : <Trash2 className="h-4 w-4" />}
              {t('comments.delete.yes')}
            </button>
            <button
              type="button"
              onClick={onCancel}
              className="rounded-lg border border-white/15 px-4 py-2 text-sm text-zinc-300 transition-all duration-300 hover:border-white/30 hover:text-white focus:outline-none focus:ring-4 focus:ring-white/10 active:scale-95"
            >
              {t('common.cancel')}
            </button>
          </div>
        </div>
      )}

      {isReplying && (
        <div className="mt-3 border-l-2 border-[#0066ff]/40 pl-4">
          <CommentForm
            variant="reply"
            isBusy={isBusy}
            autoFocus
            onCancel={onCancel}
            onSubmit={(values) => onReply(comment, values)}
          />
        </div>
      )}

      {replies.length > 0 && !collapsed && (
        <div className={`mt-4 space-y-4 ${depth < MAX_INDENT_DEPTH ? 'ml-2 sm:ml-4' : ''}`}>
          {replies.map((reply) => (
            <CommentThread
              key={reply.id}
              comment={reply}
              depth={depth + 1}
              currentUserId={currentUserId}
              likedIds={likedIds}
              busyId={busyId}
              replyingTo={replyingTo}
              editingId={editingId}
              confirmingId={confirmingId}
              onStartReply={onStartReply}
              onStartEdit={onStartEdit}
              onAskDelete={onAskDelete}
              onCancel={onCancel}
              onReply={onReply}
              onEdit={onEdit}
              onDelete={onDelete}
              onToggleLike={onToggleLike}
            />
          ))}
        </div>
      )}
    </article>
  )
}

export default CommentThread

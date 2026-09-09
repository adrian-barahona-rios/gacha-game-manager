import { useCallback, useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { AlertCircle, ArrowLeft, Check, Loader2, User, X } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import {
  acceptFriendRequest,
  loadFriendships,
  removeFriendship,
} from '../data/friends'
import AddFriendModal from './AddFriendModal'
import FriendsList from './FriendsList'
import ProfileButton from './ProfileButton'

function FriendsMenu() {
  const { t } = useI18n()
  const navigate = useNavigate()
  const [userId, setUserId] = useState(null)
  const [friends, setFriends] = useState([])
  const [incoming, setIncoming] = useState([])
  const [outgoing, setOutgoing] = useState([])
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')
  const [pendingId, setPendingId] = useState(null)
  const [isAdding, setIsAdding] = useState(false)

  useEffect(() => {
    let active = true

    supabase.auth.getSession().then(({ data }) => {
      if (!active) {
        return
      }
      if (!data.session) {
        navigate('/login', { replace: true })
        return
      }
      setUserId(data.session.user.id)
    })

    return () => {
      active = false
    }
  }, [navigate])

  const applyResult = useCallback((result) => {
    if (result.error) {
      setError(`No se pudieron cargar tus amigos: ${result.error.message}`)
    } else {
      setFriends(result.friends)
      setIncoming(result.incoming)
      setOutgoing(result.outgoing)
      setError('')
    }

    setIsLoading(false)
  }, [])

  const refresh = (currentUserId) =>
    loadFriendships(currentUserId).then(applyResult)

  useEffect(() => {
    if (!userId) {
      return
    }

    let active = true

    loadFriendships(userId).then((result) => {
      if (active) {
        applyResult(result)
      }
    })

    return () => {
      active = false
    }
  }, [userId, applyResult])

  const handleAccept = async (relationId) => {
    setPendingId(relationId)
    const { error: acceptError } = await acceptFriendRequest(relationId)
    setPendingId(null)

    if (acceptError) {
      setError(`No se pudo aceptar: ${acceptError.message}`)
      return
    }

    refresh(userId)
  }

  const handleRemove = async (relationId) => {
    setPendingId(relationId)
    const { error: removeError } = await removeFriendship(relationId)
    setPendingId(null)

    if (removeError) {
      setError(`No se pudo completar: ${removeError.message}`)
      return
    }

    refresh(userId)
  }

  const relations = [
    ...friends.map((item) => ({ ...item, direction: 'friend' })),
    ...incoming.map((item) => ({ ...item, direction: 'incoming' })),
    ...outgoing.map((item) => ({ ...item, direction: 'outgoing' })),
  ]

  return (
    <div className="relative min-h-screen scheme-dark overflow-hidden bg-black">
      <div className="pointer-events-none fixed inset-0" aria-hidden="true">
        <div className="absolute inset-0 bg-[linear-gradient(to_right,rgba(255,255,255,0.035)_1px,transparent_1px),linear-gradient(to_bottom,rgba(255,255,255,0.035)_1px,transparent_1px)] bg-[size:64px_64px] [mask-image:radial-gradient(ellipse_at_center,black_10%,transparent_70%)]" />
        <div className="absolute -top-40 left-[12%] h-[30rem] w-[30rem] animate-pulse rounded-full bg-blue-600/15 blur-[130px] [animation-duration:9s]" />
        <div className="absolute -bottom-48 right-[8%] h-[28rem] w-[28rem] animate-pulse rounded-full bg-purple-600/12 blur-[130px] [animation-duration:11s] [animation-delay:2s]" />
      </div>

      <header className="relative z-20 border-b-2 border-blue-600/70 bg-[#0a0a0a]/90 backdrop-blur-xl">
        <div className="mx-auto flex max-w-3xl items-center gap-3 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate('/profile')}
            aria-label={t('friends.backToProfile')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>
          <span className="text-lg font-semibold tracking-tight text-white">
            Amigos
          </span>
          <ProfileButton />
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-3xl space-y-6 px-4 py-10 sm:px-6 sm:py-14">
        {error && (
          <div className="flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
            <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{error}</p>
          </div>
        )}

        {isLoading ? (
          <div className="animate-pulse space-y-4 rounded-3xl border border-white/10 bg-[#111114]/80 p-8">
            <div className="h-6 w-40 rounded bg-white/5" />
            <div className="h-16 rounded-2xl bg-white/5" />
            <div className="h-16 rounded-2xl bg-white/5" />
          </div>
        ) : (
          <>
            {incoming.length > 0 && (
              <section className="rounded-3xl border border-blue-500/25 bg-[#0d1220]/80 p-6 backdrop-blur-xl sm:p-8">
                <h2 className="mb-1.5 text-lg font-semibold tracking-tight text-white">
                  {t('friends.incoming')}
                </h2>
                <p className="mb-6 text-sm text-zinc-500">
                  {t(
                    incoming.length === 1 ? 'friends.incomingCount' : 'friends.incomingCountPlural',
                    { count: incoming.length },
                  )}
                </p>

                <ul className="space-y-3">
                  {incoming.map((request) => (
                    <li
                      key={request.id}
                      className="flex items-center gap-4 rounded-2xl border border-white/10 bg-white/[0.03] p-4"
                    >
                      <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-full bg-gradient-to-b from-white/15 to-white/[0.03] ring-1 ring-white/10">
                        <User className="h-5 w-5 text-white" />
                      </span>

                      <span className="min-w-0 flex-1 truncate text-[15px] font-medium text-white">
                        {request.profile.username ?? 'Usuario'}
                      </span>

                      <button
                        type="button"
                        onClick={() => handleAccept(request.id)}
                        disabled={pendingId === request.id}
                        aria-label={t('friends.accept')}
                        title={t('friends.accept')}
                        className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-white text-black transition-all duration-300 hover:bg-emerald-500 hover:text-white hover:shadow-[0_0_25px_rgba(16,185,129,0.5)] focus:outline-none focus:ring-4 focus:ring-emerald-500/30 active:scale-95 disabled:opacity-50"
                      >
                        {pendingId === request.id ? (
                          <Loader2 className="h-4 w-4 animate-spin" />
                        ) : (
                          <Check className="h-4 w-4" />
                        )}
                      </button>

                      <button
                        type="button"
                        onClick={() => handleRemove(request.id)}
                        disabled={pendingId === request.id}
                        aria-label={t('friends.reject')}
                        title={t('friends.reject')}
                        className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg border border-white/10 bg-transparent text-zinc-400 transition-all duration-300 hover:border-red-500 hover:bg-red-500/15 hover:text-white focus:outline-none focus:ring-4 focus:ring-red-500/30 active:scale-95 disabled:opacity-50"
                      >
                        <X className="h-4 w-4" />
                      </button>
                    </li>
                  ))}
                </ul>
              </section>
            )}

            <FriendsList
              friends={friends}
              removingId={pendingId}
              onAdd={() => setIsAdding(true)}
              onRemove={handleRemove}
            />

            {outgoing.length > 0 && (
              <section className="rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
                <h2 className="mb-1.5 text-lg font-semibold tracking-tight text-white">
                  {t('friends.outgoing')}
                </h2>
                <p className="mb-6 text-sm text-zinc-500">
                  {t('friends.outgoingHint')}
                </p>

                <ul className="space-y-3">
                  {outgoing.map((request) => (
                    <li
                      key={request.id}
                      className="flex items-center gap-4 rounded-2xl border border-white/10 bg-white/[0.02] p-4"
                    >
                      <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-white/5 ring-1 ring-white/10">
                        <User className="h-4 w-4 text-zinc-400" />
                      </span>
                      <span className="min-w-0 flex-1 truncate text-sm text-zinc-400">
                        {request.profile.username ?? 'Usuario'}
                      </span>
                      <button
                        type="button"
                        onClick={() => handleRemove(request.id)}
                        disabled={pendingId === request.id}
                        className="shrink-0 rounded-lg border border-white/10 px-3 py-2 text-xs font-medium text-zinc-400 transition-all duration-300 hover:border-red-500 hover:text-white focus:outline-none focus:ring-4 focus:ring-red-500/30 active:scale-95 disabled:opacity-50"
                      >
                        Cancelar
                      </button>
                    </li>
                  ))}
                </ul>
              </section>
            )}
          </>
        )}
      </main>

      {isAdding && (
        <AddFriendModal
          userId={userId}
          relations={relations}
          onClose={() => setIsAdding(false)}
          onSent={() => refresh(userId)}
        />
      )}
    </div>
  )
}

export default FriendsMenu

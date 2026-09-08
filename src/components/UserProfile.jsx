import { useCallback, useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  AlertCircle,
  ArrowLeft,
  Check,
  Copy,
  KeyRound,
  Loader2,
  LogOut,
  Mail,
  Send,
  User,
  UserPlus,
  Users,
} from 'lucide-react'
import { supabase } from '../config/supabase'
import { LANGUAGES } from '../i18n/context'
import { useI18n } from '../i18n/useI18n'
import { loadFriendships } from '../data/friends'
import AddFriendModal from './AddFriendModal'

function UserProfile() {
  const navigate = useNavigate()
  const [user, setUser] = useState(null)
  const [username, setUsername] = useState('')
  const [savedUsername, setSavedUsername] = useState('')
  const [isSaving, setIsSaving] = useState(false)
  const [isSaved, setIsSaved] = useState(false)
  const { t, activeLanguage, setLanguage } = useI18n()
  const [error, setError] = useState('')
  const [isSendingReset, setIsSendingReset] = useState(false)
  const [resetSent, setResetSent] = useState(false)
  const [resetError, setResetError] = useState('')
  const [isCopied, setIsCopied] = useState(false)
  const [isAddingFriend, setIsAddingFriend] = useState(false)
  const [relations, setRelations] = useState([])
  const [friendCount, setFriendCount] = useState(0)
  const [pendingCount, setPendingCount] = useState(0)

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

      const current = data.session.user
      setUser(current)

      supabase
        .from('profiles')
        .select('username')
        .eq('id', current.id)
        .maybeSingle()
        .then(({ data: profile }) => {
          if (!active) {
            return
          }
          const name =
            profile?.username ?? current.user_metadata?.username ?? ''
          setUsername(name)
          setSavedUsername(name)
        })
    })

    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((_event, session) => {
      if (!session) {
        navigate('/login', { replace: true })
      }
    })

    return () => {
      active = false
      subscription.unsubscribe()
    }
  }, [navigate])

  const handleSaveUsername = async (event) => {
    event.preventDefault()
    setError('')
    setIsSaved(false)

    const trimmed = username.trim()

    if (trimmed.length < 3) {
      setError(t('register.error.username'))
      return
    }

    if (trimmed.toLowerCase() === savedUsername.toLowerCase()) {
      setError(t('profile.error.sameUsername'))
      return
    }

    setIsSaving(true)

    const { data: taken } = await supabase
      .from('profiles')
      .select('id')
      .ilike('username', trimmed)
      .maybeSingle()

    if (taken && taken.id !== user.id) {
      setIsSaving(false)
      setError(t('register.error.usernameTaken'))
      return
    }

    const { error: profileError } = await supabase
      .from('profiles')
      .update({ username: trimmed })
      .eq('id', user.id)

    if (profileError) {
      setIsSaving(false)
      setError(t('tierlist.error.save', { message: profileError.message }))
      return
    }

    // Se guarda tambien en el usuario de Auth para que el dashboard lo tenga
    // disponible sin consultar la tabla.
    await supabase.auth.updateUser({ data: { username: trimmed } })

    setIsSaving(false)
    setSavedUsername(trimmed)
    setIsSaved(true)
  }

  const applyFriends = useCallback((result) => {
    if (result.error) {
      return
    }

    setRelations([
      ...result.friends.map((item) => ({ ...item, direction: 'friend' })),
      ...result.incoming.map((item) => ({ ...item, direction: 'incoming' })),
      ...result.outgoing.map((item) => ({ ...item, direction: 'outgoing' })),
    ])
    setFriendCount(result.friends.length)
    setPendingCount(result.incoming.length)
  }, [])

  const refreshFriends = (currentUserId) =>
    loadFriendships(currentUserId).then(applyFriends)

  const currentUserId = user?.id

  useEffect(() => {
    if (!currentUserId) {
      return
    }

    let active = true

    loadFriendships(currentUserId).then((result) => {
      if (active) {
        applyFriends(result)
      }
    })

    return () => {
      active = false
    }
  }, [currentUserId, applyFriends])

  const handleCopyId = async () => {
    try {
      await navigator.clipboard.writeText(user.id)
      setIsCopied(true)
      setTimeout(() => setIsCopied(false), 2000)
    } catch {
      setError(t('profile.error.copy'))
    }
  }

  const handleSendReset = async () => {
    setResetError('')
    setResetSent(false)
    setIsSendingReset(true)

    const { error: sendError } = await supabase.auth.resetPasswordForEmail(
      user.email,
      { redirectTo: `${window.location.origin}/reset-password` },
    )

    setIsSendingReset(false)

    if (sendError) {
      setResetError(sendError.message)
      return
    }

    setResetSent(true)
  }

  const handleLogout = async () => {
    await supabase.auth.signOut()
    navigate('/login', { replace: true })
  }

  return (
    <div className="relative min-h-screen scheme-dark overflow-hidden bg-black">
      <div className="pointer-events-none fixed inset-0" aria-hidden="true">
        <div className="absolute inset-0 bg-[linear-gradient(to_right,rgba(255,255,255,0.035)_1px,transparent_1px),linear-gradient(to_bottom,rgba(255,255,255,0.035)_1px,transparent_1px)] bg-[size:64px_64px] [mask-image:radial-gradient(ellipse_at_center,black_10%,transparent_70%)]" />
        <div className="absolute -top-40 left-[12%] h-[30rem] w-[30rem] animate-pulse rounded-full bg-blue-600/15 blur-[130px] [animation-duration:9s]" />
        <div className="absolute -bottom-48 right-[8%] h-[28rem] w-[28rem] animate-pulse rounded-full bg-purple-600/12 blur-[130px] [animation-duration:11s] [animation-delay:2s]" />
      </div>

      <header className="relative z-20 border-b-2 border-blue-600/70 bg-[#0a0a0a]/90 backdrop-blur-xl">
        <div className="mx-auto flex max-w-3xl items-center justify-between gap-4 px-4 py-4 sm:px-6">
          <div className="flex items-center gap-3">
            <button
              type="button"
              onClick={() => navigate('/dashboard')}
              aria-label={t('game.backToDashboard')}
              className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
            >
              <ArrowLeft className="h-4 w-4" />
            </button>
            <span className="text-lg font-semibold tracking-tight text-white">
              {t('profile.title')}
            </span>
          </div>

          <button
            type="button"
            onClick={handleLogout}
            className="flex items-center gap-2 rounded-lg bg-white px-3 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:bg-red-600 hover:text-white hover:shadow-[0_0_25px_rgba(220,38,38,0.6)] focus:outline-none focus:ring-4 focus:ring-red-500/30 active:scale-95 sm:px-4"
          >
            <LogOut className="h-4 w-4" />
            <span className="hidden sm:inline">{t('profile.signOut')}</span>
          </button>
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-3xl px-4 py-10 sm:px-6 sm:py-14">
        <section className="mb-6 flex flex-col items-center gap-5 rounded-3xl border border-white/10 bg-[#111114]/80 p-8 text-center backdrop-blur-xl sm:flex-row sm:text-left">
          <div className="flex h-20 w-20 shrink-0 items-center justify-center rounded-full bg-gradient-to-b from-white/15 to-white/[0.03] ring-1 ring-white/10">
            <User className="h-9 w-9 text-white" />
          </div>
          <div className="min-w-0">
            <h1 className="truncate text-2xl font-semibold tracking-tight text-white">
              {savedUsername || t('profile.noUsername')}
            </h1>
            <p className="mt-1.5 flex items-center justify-center gap-2 text-sm text-zinc-500 sm:justify-start">
              <Mail className="h-4 w-4 shrink-0" />
              <span className="truncate">{user?.email ?? '—'}</span>
            </p>
          </div>
        </section>

        <section className="mb-6 rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
          <h2 className="mb-1.5 text-lg font-semibold tracking-tight text-white">
            {t('profile.language')}
          </h2>
          <p className="mb-5 text-sm text-zinc-500">{t('profile.languageHint')}</p>

          <div className="flex flex-wrap gap-3">
            {LANGUAGES.map((option) => {
              const isActive = option.id === activeLanguage
              return (
                <button
                  key={option.id}
                  type="button"
                  onClick={() => setLanguage(option.id)}
                  className={`flex items-center gap-2 rounded-xl px-5 py-3 text-sm font-semibold transition-all duration-300 focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:scale-95 ${
                    isActive
                      ? 'bg-white text-black'
                      : 'border border-white/15 bg-transparent text-zinc-300 hover:border-[#0066ff] hover:bg-[#0066ff]/10 hover:text-white'
                  }`}
                >
                  {isActive && <Check className="h-4 w-4" />}
                  {option.native}
                </button>
              )
            })}
          </div>
        </section>

        <section className="mb-6 rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
          <h2 className="mb-1.5 text-lg font-semibold tracking-tight text-white">
            {t('profile.accountId')}
          </h2>
          <p className="mb-5 text-sm text-zinc-500">
            {t('profile.accountIdHint')}
          </p>

          <div className="flex flex-col gap-3 sm:flex-row sm:items-center">
            <code className="min-w-0 flex-1 truncate rounded-xl border border-white/10 bg-white/[0.03] px-4 py-3 font-mono text-[13px] text-zinc-300">
              {user?.id ?? '—'}
            </code>
            <button
              type="button"
              onClick={handleCopyId}
              disabled={!user}
              className="flex shrink-0 items-center justify-center gap-2 rounded-xl border border-white/15 bg-transparent px-4 py-3 text-sm font-semibold text-zinc-300 transition-all duration-300 hover:border-[#0066ff] hover:bg-[#0066ff]/10 hover:text-white focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:scale-95 disabled:opacity-50"
            >
              {isCopied ? (
                <>
                  <Check className="h-4 w-4 text-emerald-400" />
                  {t('profile.copied')}
                </>
              ) : (
                <>
                  <Copy className="h-4 w-4" />
                  {t('profile.copy')}
                </>
              )}
            </button>
          </div>
        </section>

        <section className="mb-6 rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
          <h2 className="mb-1.5 flex items-center gap-2.5 text-lg font-semibold tracking-tight text-white">
            <Users className="h-5 w-5 text-zinc-400" />
            {t('profile.friends')}
          </h2>
          <p className="mb-6 text-sm text-zinc-500">
            {t(friendCount === 1 ? 'profile.friendCount' : 'profile.friendCountPlural', {
              count: friendCount,
            })}
            {pendingCount > 0 &&
              ` · ${t(
                pendingCount === 1 ? 'profile.pendingCount' : 'profile.pendingCountPlural',
                { count: pendingCount },
              )}`}
          </p>

          <div className="flex flex-wrap gap-3">
            <button
              type="button"
              onClick={() => setIsAddingFriend(true)}
              className="flex items-center justify-center gap-2 rounded-xl bg-white px-5 py-3 text-sm font-semibold text-black transition-all duration-300 hover:-translate-y-0.5 hover:bg-[#0066ff] hover:text-white hover:shadow-[0_0_25px_rgba(0,102,255,0.65)] focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:translate-y-0 active:scale-95"
            >
              <UserPlus className="h-4 w-4" />
              {t('profile.findFriends')}
            </button>

            <button
              type="button"
              onClick={() => navigate('/profile/friends')}
              className="flex items-center justify-center gap-2 rounded-xl border border-white/15 bg-transparent px-5 py-3 text-sm font-semibold text-zinc-300 transition-all duration-300 hover:border-[#0066ff] hover:bg-[#0066ff]/10 hover:text-white focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:scale-95"
            >
              <Users className="h-4 w-4" />
              {t('dashboard.friendsMenu')}
              {pendingCount > 0 && (
                <span className="ml-1 rounded-full bg-blue-600 px-2 py-0.5 text-xs font-semibold text-white">
                  {pendingCount}
                </span>
              )}
            </button>
          </div>
        </section>

        <section className="mb-6 rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
          <h2 className="mb-1.5 text-lg font-semibold tracking-tight text-white">
            {t('common.username')}
          </h2>
          <p className="mb-6 text-sm text-zinc-500">
            {t('profile.usernameHint')}
          </p>

          <form onSubmit={handleSaveUsername} noValidate>
            {error && (
              <div className="mb-5 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-[13px] text-red-200">
                <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
                <p>{error}</p>
              </div>
            )}

            <div className="relative">
              <input
                id="username"
                type="text"
                value={username}
                onChange={(event) => {
                  setUsername(event.target.value)
                  setIsSaved(false)
                  setError('')
                }}
                placeholder={t('register.usernamePlaceholder')}
                className={`peer w-full rounded-xl border bg-white/[0.03] py-3.5 pl-11 pr-4 text-[15px] text-white placeholder:text-zinc-600 transition-all duration-300 focus:bg-white/[0.06] focus:outline-none focus:ring-4 ${
                  error
                    ? 'border-red-500/40 focus:border-red-500/70 focus:ring-red-500/10'
                    : 'border-white/10 hover:border-white/20 focus:border-white/30 focus:ring-white/5'
                }`}
              />
              <User
                className={`pointer-events-none absolute left-3.5 top-1/2 h-[18px] w-[18px] -translate-y-1/2 transition-colors duration-300 ${
                  error ? 'text-red-400/80' : 'text-zinc-500 peer-focus:text-white'
                }`}
              />
            </div>

            <div className="mt-5 flex flex-wrap items-center gap-4">
              <button
                type="submit"
                disabled={isSaving}
                className="flex items-center justify-center gap-2 rounded-xl bg-white px-5 py-3 text-sm font-semibold text-black transition-all duration-300 hover:-translate-y-0.5 hover:bg-[#0066ff] hover:text-white hover:shadow-[0_0_25px_rgba(0,102,255,0.65)] focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:translate-y-0 active:scale-95 disabled:cursor-not-allowed disabled:opacity-60"
              >
                {isSaving ? (
                  <>
                    <Loader2 className="h-4 w-4 animate-spin" />
                    {t('reset.saving')}
                  </>
                ) : (
                  t('profile.saveChanges')
                )}
              </button>

              {isSaved && (
                <span className="flex items-center gap-2 text-sm text-emerald-400">
                  <Check className="h-4 w-4" />
                  {t('profile.saved')}
                </span>
              )}
            </div>
          </form>
        </section>

        <section className="rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
          <h2 className="mb-1.5 flex items-center gap-2.5 text-lg font-semibold tracking-tight text-white">
            <KeyRound className="h-5 w-5 text-zinc-400" />
            {t('reset.submit')}
          </h2>
          <p className="mb-6 text-sm leading-relaxed text-zinc-500">
            {t('profile.resetHintStart')}{' '}
            <span className="text-zinc-300">{user?.email ?? t('profile.yourEmail')}</span>
            {t('profile.resetHintEnd')}
          </p>

          {resetError && (
            <div className="mb-5 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-[13px] text-red-200">
              <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
              <p>{resetError}</p>
            </div>
          )}

          {resetSent ? (
            <div className="flex items-start gap-3 rounded-xl border border-emerald-500/30 bg-emerald-500/10 px-4 py-3.5 text-sm text-emerald-200">
              <Check className="mt-0.5 h-4 w-4 shrink-0" />
              <p>
                {t('profile.resetSent')}
              </p>
            </div>
          ) : (
            <button
              type="button"
              onClick={handleSendReset}
              disabled={isSendingReset || !user}
              className="flex items-center justify-center gap-2 rounded-xl border border-white/15 bg-transparent px-5 py-3 text-sm font-semibold text-zinc-300 transition-all duration-300 hover:border-[#0066ff] hover:bg-[#0066ff]/10 hover:text-white hover:shadow-[0_0_25px_rgba(0,102,255,0.25)] focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:scale-95 disabled:cursor-not-allowed disabled:opacity-60"
            >
              {isSendingReset ? (
                <>
                  <Loader2 className="h-4 w-4 animate-spin" />
                  {t('profile.sending')}
                </>
              ) : (
                <>
                  <Send className="h-4 w-4" />
                  {t('profile.sendReset')}
                </>
              )}
            </button>
          )}
        </section>
      </main>

      {isAddingFriend && user && (
        <AddFriendModal
          userId={user.id}
          relations={relations}
          onClose={() => setIsAddingFriend(false)}
          onSent={() => refreshFriends(user.id)}
        />
      )}
    </div>
  )
}

export default UserProfile

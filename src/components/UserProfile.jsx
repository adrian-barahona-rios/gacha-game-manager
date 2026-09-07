import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  AlertCircle,
  ArrowLeft,
  Check,
  KeyRound,
  Loader2,
  LogOut,
  Mail,
  Send,
  User,
} from 'lucide-react'
import { supabase } from '../config/supabase'

function UserProfile() {
  const navigate = useNavigate()
  const [user, setUser] = useState(null)
  const [username, setUsername] = useState('')
  const [savedUsername, setSavedUsername] = useState('')
  const [isSaving, setIsSaving] = useState(false)
  const [isSaved, setIsSaved] = useState(false)
  const [error, setError] = useState('')
  const [isSendingReset, setIsSendingReset] = useState(false)
  const [resetSent, setResetSent] = useState(false)
  const [resetError, setResetError] = useState('')

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
      setError('El nombre de usuario debe tener al menos 3 caracteres.')
      return
    }

    if (trimmed.toLowerCase() === savedUsername.toLowerCase()) {
      setError('Ese ya es tu nombre de usuario.')
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
      setError('Ese nombre de usuario ya está en uso.')
      return
    }

    const { error: profileError } = await supabase
      .from('profiles')
      .update({ username: trimmed })
      .eq('id', user.id)

    if (profileError) {
      setIsSaving(false)
      setError(`No se pudo guardar: ${profileError.message}`)
      return
    }

    // Se guarda tambien en el usuario de Auth para que el dashboard lo tenga
    // disponible sin consultar la tabla.
    await supabase.auth.updateUser({ data: { username: trimmed } })

    setIsSaving(false)
    setSavedUsername(trimmed)
    setIsSaved(true)
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
              aria-label="Volver al dashboard"
              className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
            >
              <ArrowLeft className="h-4 w-4" />
            </button>
            <span className="text-lg font-semibold tracking-tight text-white">
              Tu perfil
            </span>
          </div>

          <button
            type="button"
            onClick={handleLogout}
            className="flex items-center gap-2 rounded-lg bg-white px-3 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:bg-red-600 hover:text-white hover:shadow-[0_0_25px_rgba(220,38,38,0.6)] focus:outline-none focus:ring-4 focus:ring-red-500/30 active:scale-95 sm:px-4"
          >
            <LogOut className="h-4 w-4" />
            <span className="hidden sm:inline">Cerrar sesión</span>
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
              {savedUsername || 'Sin nombre de usuario'}
            </h1>
            <p className="mt-1.5 flex items-center justify-center gap-2 text-sm text-zinc-500 sm:justify-start">
              <Mail className="h-4 w-4 shrink-0" />
              <span className="truncate">{user?.email ?? '—'}</span>
            </p>
          </div>
        </section>

        <section className="mb-6 rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
          <h2 className="mb-1.5 text-lg font-semibold tracking-tight text-white">
            Nombre de usuario
          </h2>
          <p className="mb-6 text-sm text-zinc-500">
            Es el nombre por el que te llamaremos. Debe ser único.
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
                placeholder="¿Cómo quieres que te llamemos?"
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
                    Guardando…
                  </>
                ) : (
                  'Guardar cambios'
                )}
              </button>

              {isSaved && (
                <span className="flex items-center gap-2 text-sm text-emerald-400">
                  <Check className="h-4 w-4" />
                  Guardado
                </span>
              )}
            </div>
          </form>
        </section>

        <section className="rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
          <h2 className="mb-1.5 flex items-center gap-2.5 text-lg font-semibold tracking-tight text-white">
            <KeyRound className="h-5 w-5 text-zinc-400" />
            Cambiar contraseña
          </h2>
          <p className="mb-6 text-sm leading-relaxed text-zinc-500">
            Te enviaremos un enlace a{' '}
            <span className="text-zinc-300">{user?.email ?? 'tu email'}</span>{' '}
            para que elijas una contraseña nueva.
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
                Email enviado. Abre el enlace desde tu correo para elegir la
                contraseña nueva.
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
                  Enviando…
                </>
              ) : (
                <>
                  <Send className="h-4 w-4" />
                  Enviar email de reset
                </>
              )}
            </button>
          )}
        </section>
      </main>
    </div>
  )
}

export default UserProfile

import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  AlertCircle,
  ArrowRight,
  Loader2,
  Lock,
  Mail,
  MailCheck,
  Sparkles,
  User,
} from 'lucide-react'
import { supabase } from '../config/supabase'

const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

const AUTH_MESSAGES = {
  user_already_exists: 'Ya existe una cuenta con ese email.',
  email_exists: 'Ya existe una cuenta con ese email.',
  weak_password: 'La contraseña es demasiado débil.',
  signup_disabled: 'El registro está deshabilitado en Supabase.',
  email_provider_disabled:
    'El registro por email no está habilitado en Supabase.',
  over_email_send_rate_limit:
    'Demasiados emails enviados. Prueba de nuevo en unos minutos.',
  validation_failed: 'Revisa el email y la contraseña.',
}

function Register() {
  const navigate = useNavigate()
  const [username, setUsername] = useState('')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [errors, setErrors] = useState({})
  const [authError, setAuthError] = useState('')
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [needsConfirmation, setNeedsConfirmation] = useState(false)

  const validate = () => {
    const nextErrors = {}

    if (username.trim().length < 3) {
      nextErrors.username = 'El nombre de usuario debe tener al menos 3 caracteres.'
    }

    if (!EMAIL_REGEX.test(email)) {
      nextErrors.email = 'Introduce un email válido.'
    }

    if (password.length < 6) {
      nextErrors.password = 'La contraseña debe tener al menos 6 caracteres.'
    }

    setErrors(nextErrors)
    return Object.keys(nextErrors).length === 0
  }

  const handleSubmit = async (event) => {
    event.preventDefault()
    setAuthError('')

    if (!validate()) {
      return
    }

    setIsSubmitting(true)
    const trimmedUsername = username.trim()

    const { data: taken, error: lookupError } = await supabase
      .from('profiles')
      .select('id')
      .ilike('username', trimmedUsername)
      .maybeSingle()

    if (lookupError) {
      setIsSubmitting(false)
      setAuthError(`No se pudo comprobar el nombre de usuario: ${lookupError.message}`)
      return
    }

    if (taken) {
      setIsSubmitting(false)
      setErrors((current) => ({
        ...current,
        username: 'Ese nombre de usuario ya está en uso.',
      }))
      return
    }

    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: { data: { username: trimmedUsername } },
    })
    setIsSubmitting(false)

    if (error) {
      // El trigger de la base de datos rechaza el alta si el nombre se ocupo
      // entre la comprobacion y el registro.
      if (error.message?.toLowerCase().includes('database error')) {
        setAuthError('Ese nombre de usuario acaba de ser ocupado. Prueba con otro.')
        return
      }
      setAuthError(AUTH_MESSAGES[error.code] ?? error.message)
      return
    }

    // Con "Confirm email" activado, Supabase crea el usuario pero no devuelve
    // sesion hasta que se confirma desde el correo.
    if (!data.session) {
      setNeedsConfirmation(true)
      return
    }

    navigate('/dashboard', { replace: true })
  }

  const inputClasses = (hasError) =>
    `peer w-full rounded-xl border bg-white/[0.03] py-3.5 pl-11 pr-4 text-[15px] text-white placeholder:text-zinc-600 transition-all duration-300 focus:bg-white/[0.06] focus:outline-none focus:ring-4 ${
      hasError
        ? 'border-red-500/40 focus:border-red-500/70 focus:ring-red-500/10'
        : 'border-white/10 hover:border-white/20 focus:border-white/30 focus:ring-white/5'
    }`

  const iconClasses = (hasError) =>
    `pointer-events-none absolute left-3.5 top-1/2 h-[18px] w-[18px] -translate-y-1/2 transition-colors duration-300 ${
      hasError ? 'text-red-400/80' : 'text-zinc-500 peer-focus:text-white'
    }`

  return (
    <div className="relative flex min-h-screen scheme-dark items-center justify-center overflow-hidden bg-[#08080a] px-4 py-10">
      <div className="pointer-events-none absolute inset-0 bg-[linear-gradient(to_right,rgba(255,255,255,0.045)_1px,transparent_1px),linear-gradient(to_bottom,rgba(255,255,255,0.045)_1px,transparent_1px)] bg-[size:56px_56px] [mask-image:radial-gradient(ellipse_at_center,black_20%,transparent_72%)]" />
      <div className="pointer-events-none absolute -top-48 left-1/2 h-[34rem] w-[34rem] -translate-x-1/2 rounded-full bg-white/[0.07] blur-[130px]" />
      <div className="pointer-events-none absolute -bottom-40 -right-32 h-[26rem] w-[26rem] rounded-full bg-white/[0.04] blur-[120px]" />

      <div className="relative w-full max-w-md rounded-[26px] bg-gradient-to-b from-white/20 via-white/[0.08] to-white/[0.02] p-px shadow-2xl shadow-black/80">
        <div className="rounded-[25px] bg-[#0c0c0f]/95 p-8 backdrop-blur-2xl sm:p-10">
          {needsConfirmation ? (
            <div className="flex flex-col items-center text-center">
              <div className="mb-6 flex h-14 w-14 items-center justify-center rounded-2xl bg-gradient-to-b from-white/15 to-white/[0.03] ring-1 ring-white/10">
                <MailCheck className="h-6 w-6 text-white" />
              </div>
              <h1 className="text-[26px] font-semibold leading-tight tracking-tight text-white sm:text-3xl">
                Confirma tu email
              </h1>
              <p className="mt-3 text-sm leading-relaxed text-zinc-500">
                Hemos enviado un enlace de confirmación a{' '}
                <span className="text-zinc-300">{email}</span>. Ábrelo y vuelve
                aquí para iniciar sesión.
              </p>
              <button
                type="button"
                onClick={() => navigate('/')}
                className="mt-8 w-full rounded-xl bg-white py-3.5 text-[15px] font-semibold text-black transition-all duration-300 hover:-translate-y-0.5 hover:bg-zinc-100 focus:outline-none focus:ring-4 focus:ring-white/20 active:translate-y-0"
              >
                Ir a iniciar sesión
              </button>
            </div>
          ) : (
          <>
          <div className="mb-9 flex flex-col items-center text-center">
            <div className="mb-6 flex h-14 w-14 items-center justify-center rounded-2xl bg-gradient-to-b from-white/15 to-white/[0.03] ring-1 ring-white/10">
              <Sparkles className="h-6 w-6 text-white" />
            </div>
            <h1 className="text-[26px] font-semibold leading-tight tracking-tight text-white sm:text-3xl">
              Crea tu cuenta
            </h1>
            <p className="mt-2.5 text-sm leading-relaxed text-zinc-500">
              Empieza a gestionar tus juegos gacha en un minuto
            </p>
          </div>

          <form onSubmit={handleSubmit} noValidate className="space-y-5">
            {authError && (
              <div className="flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-[13px] text-red-200">
                <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
                <p>{authError}</p>
              </div>
            )}

            <div>
              <label
                htmlFor="username"
                className="mb-2 block text-[13px] font-medium tracking-wide text-zinc-400"
              >
                Nombre de usuario
              </label>
              <div className="relative">
                <input
                  id="username"
                  type="text"
                  value={username}
                  onChange={(event) => setUsername(event.target.value)}
                  placeholder="¿Cómo quieres que te llamemos?"
                  className={inputClasses(errors.username)}
                />
                <User className={iconClasses(errors.username)} />
              </div>
              {errors.username && (
                <p className="mt-2 text-[13px] text-red-400/90">
                  {errors.username}
                </p>
              )}
            </div>

            <div>
              <label
                htmlFor="email"
                className="mb-2 block text-[13px] font-medium tracking-wide text-zinc-400"
              >
                Email
              </label>
              <div className="relative">
                <input
                  id="email"
                  type="email"
                  value={email}
                  onChange={(event) => setEmail(event.target.value)}
                  placeholder="tucorreo@ejemplo.com"
                  className={inputClasses(errors.email)}
                />
                <Mail className={iconClasses(errors.email)} />
              </div>
              {errors.email && (
                <p className="mt-2 text-[13px] text-red-400/90">{errors.email}</p>
              )}
            </div>

            <div>
              <label
                htmlFor="password"
                className="mb-2 block text-[13px] font-medium tracking-wide text-zinc-400"
              >
                Contraseña
              </label>
              <div className="relative">
                <input
                  id="password"
                  type="password"
                  value={password}
                  onChange={(event) => setPassword(event.target.value)}
                  placeholder="Mínimo 6 caracteres"
                  className={inputClasses(errors.password)}
                />
                <Lock className={iconClasses(errors.password)} />
              </div>
              {errors.password && (
                <p className="mt-2 text-[13px] text-red-400/90">
                  {errors.password}
                </p>
              )}
            </div>

            <button
              type="submit"
              disabled={isSubmitting}
              className="group flex w-full items-center justify-center gap-2 rounded-xl bg-white py-3.5 text-[15px] font-semibold text-black shadow-lg shadow-white/5 transition-all duration-300 hover:-translate-y-0.5 hover:bg-zinc-100 hover:shadow-xl hover:shadow-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:translate-y-0 disabled:cursor-not-allowed disabled:opacity-60 disabled:hover:translate-y-0"
            >
              {isSubmitting ? (
                <>
                  <Loader2 className="h-[18px] w-[18px] animate-spin" />
                  Creando cuenta…
                </>
              ) : (
                <>
                  Crear cuenta
                  <ArrowRight className="h-[18px] w-[18px] transition-transform duration-300 group-hover:translate-x-1" />
                </>
              )}
            </button>
          </form>

          <p className="mt-8 text-center text-sm text-zinc-500">
            ¿Ya tienes cuenta?{' '}
            <button
              type="button"
              onClick={() => navigate('/')}
              className="rounded font-semibold text-white underline-offset-4 transition-colors duration-300 hover:text-zinc-300 hover:underline focus:outline-none focus:ring-2 focus:ring-white/30"
            >
              Inicia sesión
            </button>
          </p>
          </>
          )}
        </div>
      </div>
    </div>
  )
}

export default Register

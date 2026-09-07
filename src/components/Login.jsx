import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { ArrowRight, Gamepad2, Lock, Mail } from 'lucide-react'

const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

function Login() {
  const navigate = useNavigate()
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [errors, setErrors] = useState({})

  const validate = () => {
    const nextErrors = {}

    if (!EMAIL_REGEX.test(email)) {
      nextErrors.email = 'Introduce un email válido.'
    }

    if (password.length < 6) {
      nextErrors.password = 'La contraseña debe tener al menos 6 caracteres.'
    }

    setErrors(nextErrors)
    return Object.keys(nextErrors).length === 0
  }

  const handleSubmit = (event) => {
    event.preventDefault()

    if (!validate()) {
      return
    }

    navigate('/dashboard')
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
          <div className="mb-9 flex flex-col items-center text-center">
            <div className="mb-6 flex h-14 w-14 items-center justify-center rounded-2xl bg-gradient-to-b from-white/15 to-white/[0.03] ring-1 ring-white/10">
              <Gamepad2 className="h-6 w-6 text-white" />
            </div>
            <h1 className="text-[26px] font-semibold leading-tight tracking-tight text-white sm:text-3xl">
              Bienvenido de nuevo
            </h1>
            <p className="mt-2.5 text-sm leading-relaxed text-zinc-500">
              Inicia sesión para gestionar tus juegos gacha
            </p>
          </div>

          <form onSubmit={handleSubmit} noValidate className="space-y-5">
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
                  placeholder="••••••••"
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
              className="group flex w-full items-center justify-center gap-2 rounded-xl bg-white py-3.5 text-[15px] font-semibold text-black shadow-lg shadow-white/5 transition-all duration-300 hover:-translate-y-0.5 hover:bg-zinc-100 hover:shadow-xl hover:shadow-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:translate-y-0"
            >
              Iniciar sesión
              <ArrowRight className="h-[18px] w-[18px] transition-transform duration-300 group-hover:translate-x-1" />
            </button>
          </form>

          <p className="mt-8 text-center text-sm text-zinc-500">
            ¿No tienes cuenta?{' '}
            <button
              type="button"
              onClick={() => navigate('/register')}
              className="rounded font-semibold text-white underline-offset-4 transition-colors duration-300 hover:text-zinc-300 hover:underline focus:outline-none focus:ring-2 focus:ring-white/30"
            >
              Regístrate
            </button>
          </p>
        </div>
      </div>
    </div>
  )
}

export default Login

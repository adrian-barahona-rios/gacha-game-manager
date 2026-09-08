import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  AlertCircle,
  ArrowRight,
  Check,
  KeyRound,
  Loader2,
  Lock,
} from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'

function ResetPassword() {
  const navigate = useNavigate()
  const { t } = useI18n()
  const [status, setStatus] = useState('checking')
  const [password, setPassword] = useState('')
  const [confirmation, setConfirmation] = useState('')
  const [errors, setErrors] = useState({})
  const [formError, setFormError] = useState('')
  const [isSaving, setIsSaving] = useState(false)

  useEffect(() => {
    let active = true

    // Supabase lee el token del enlace al cargar la pagina y abre una sesion
    // temporal de recuperacion; puede llegar por el evento o ya estar lista.
    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((event, session) => {
      if (!active) {
        return
      }
      if (event === 'PASSWORD_RECOVERY' || session) {
        setStatus('ready')
      }
    })

    supabase.auth.getSession().then(({ data }) => {
      if (!active) {
        return
      }
      setStatus(data.session ? 'ready' : 'invalid')
    })

    return () => {
      active = false
      subscription.unsubscribe()
    }
  }, [])

  const handleSubmit = async (event) => {
    event.preventDefault()
    setFormError('')

    const nextErrors = {}

    if (password.length < 6) {
      nextErrors.password = t('login.error.password')
    }

    if (password !== confirmation) {
      nextErrors.confirmation = t('reset.error.mismatch')
    }

    setErrors(nextErrors)

    if (Object.keys(nextErrors).length > 0) {
      return
    }

    setIsSaving(true)
    const { error } = await supabase.auth.updateUser({ password })

    if (error) {
      setIsSaving(false)
      setFormError(error.message)
      return
    }

    setStatus('done')
    await supabase.auth.signOut()
    setTimeout(() => navigate('/login', { replace: true }), 2500)
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

      <div className="relative w-full max-w-md rounded-[26px] bg-gradient-to-b from-white/20 via-white/[0.08] to-white/[0.02] p-px shadow-2xl shadow-black/80">
        <div className="rounded-[25px] bg-[#0c0c0f]/95 p-8 backdrop-blur-2xl sm:p-10">
          <div className="mb-9 flex flex-col items-center text-center">
            <div className="mb-6 flex h-14 w-14 items-center justify-center rounded-2xl bg-gradient-to-b from-white/15 to-white/[0.03] ring-1 ring-white/10">
              {status === 'done' ? (
                <Check className="h-6 w-6 text-emerald-400" />
              ) : (
                <KeyRound className="h-6 w-6 text-white" />
              )}
            </div>
            <h1 className="text-[26px] font-semibold leading-tight tracking-tight text-white sm:text-3xl">
              {status === 'done' ? t('reset.doneTitle') : t('reset.title')}
            </h1>
            <p className="mt-2.5 text-sm leading-relaxed text-zinc-500">
              {status === 'done'
                ? t('reset.doneSubtitle')
                : t('reset.subtitle')}
            </p>
          </div>

          {status === 'checking' && (
            <div className="flex items-center justify-center gap-3 py-6 text-sm text-zinc-500">
              <Loader2 className="h-4 w-4 animate-spin" />
              {t('reset.checking')}
            </div>
          )}

          {status === 'invalid' && (
            <>
              <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-[13px] text-red-200">
                <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
                <p>
                  {t('reset.invalidLink')}
                </p>
              </div>
              <button
                type="button"
                onClick={() => navigate('/login')}
                className="w-full rounded-xl bg-white py-3.5 text-[15px] font-semibold text-black transition-all duration-300 hover:-translate-y-0.5 hover:bg-zinc-100 focus:outline-none focus:ring-4 focus:ring-white/20 active:translate-y-0"
              >
                {t('register.goToLogin')}
              </button>
            </>
          )}

          {status === 'ready' && (
            <form onSubmit={handleSubmit} noValidate className="space-y-5">
              {formError && (
                <div className="flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-[13px] text-red-200">
                  <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
                  <p>{formError}</p>
                </div>
              )}

              <div>
                <label
                  htmlFor="password"
                  className="mb-2 block text-[13px] font-medium tracking-wide text-zinc-400"
                >
                  {t('reset.newPassword')}
                </label>
                <div className="relative">
                  <input
                    id="password"
                    type="password"
                    value={password}
                    onChange={(event) => setPassword(event.target.value)}
                    placeholder={t('register.passwordPlaceholder')}
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

              <div>
                <label
                  htmlFor="confirmation"
                  className="mb-2 block text-[13px] font-medium tracking-wide text-zinc-400"
                >
                  {t('reset.repeatPassword')}
                </label>
                <div className="relative">
                  <input
                    id="confirmation"
                    type="password"
                    value={confirmation}
                    onChange={(event) => setConfirmation(event.target.value)}
                    placeholder="••••••••"
                    className={inputClasses(errors.confirmation)}
                  />
                  <Lock className={iconClasses(errors.confirmation)} />
                </div>
                {errors.confirmation && (
                  <p className="mt-2 text-[13px] text-red-400/90">
                    {errors.confirmation}
                  </p>
                )}
              </div>

              <button
                type="submit"
                disabled={isSaving}
                className="group flex w-full items-center justify-center gap-2 rounded-xl bg-white py-3.5 text-[15px] font-semibold text-black shadow-lg shadow-white/5 transition-all duration-300 hover:-translate-y-0.5 hover:bg-zinc-100 hover:shadow-xl hover:shadow-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:translate-y-0 disabled:cursor-not-allowed disabled:opacity-60 disabled:hover:translate-y-0"
              >
                {isSaving ? (
                  <>
                    <Loader2 className="h-[18px] w-[18px] animate-spin" />
                    {t('reset.saving')}
                  </>
                ) : (
                  <>
                    {t('reset.submit')}
                    <ArrowRight className="h-[18px] w-[18px] transition-transform duration-300 group-hover:translate-x-1" />
                  </>
                )}
              </button>
            </form>
          )}

          {status === 'done' && (
            <div className="flex items-center justify-center gap-3 py-2 text-sm text-zinc-500">
              <Loader2 className="h-4 w-4 animate-spin" />
              {t('reset.redirecting')}
            </div>
          )}
        </div>
      </div>
    </div>
  )
}

export default ResetPassword

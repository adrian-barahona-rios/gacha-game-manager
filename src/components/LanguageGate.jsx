import { Check, Gamepad2, Languages } from 'lucide-react'
import { LANGUAGES } from '../i18n/context'
import { useI18n } from '../i18n/useI18n'

// Los textos de esta pantalla no pasan por t(): se ven antes de elegir idioma,
// asi que van en los dos idiomas a la vez.
const COPY = {
  es: { title: 'Elige tu idioma', subtitle: 'Podrás cambiarlo cuando quieras desde tu perfil.' },
  en: { title: 'Choose your language', subtitle: 'You can change it anytime from your profile.' },
}

function LanguageGate({ children }) {
  const { hasChosen, activeLanguage, setLanguage } = useI18n()

  if (hasChosen) {
    return children
  }

  return (
    <div className="relative flex min-h-screen scheme-dark items-center justify-center overflow-hidden bg-[#08080a] px-4 py-10">
      <div className="pointer-events-none absolute inset-0 bg-[linear-gradient(to_right,rgba(255,255,255,0.045)_1px,transparent_1px),linear-gradient(to_bottom,rgba(255,255,255,0.045)_1px,transparent_1px)] bg-[size:56px_56px] [mask-image:radial-gradient(ellipse_at_center,black_20%,transparent_72%)]" />
      <div className="pointer-events-none absolute -top-48 left-1/2 h-[34rem] w-[34rem] -translate-x-1/2 rounded-full bg-white/[0.07] blur-[130px]" />

      <div className="relative w-full max-w-md rounded-[26px] bg-gradient-to-b from-white/20 via-white/[0.08] to-white/[0.02] p-px shadow-2xl shadow-black/80">
        <div className="rounded-[25px] bg-[#0c0c0f]/95 p-8 backdrop-blur-2xl sm:p-10">
          <div className="mb-9 flex flex-col items-center text-center">
            <div className="mb-6 flex h-14 w-14 items-center justify-center rounded-2xl bg-gradient-to-b from-white/15 to-white/[0.03] ring-1 ring-white/10">
              <Gamepad2 className="h-6 w-6 text-white" />
            </div>
            <h1 className="text-[26px] font-semibold leading-tight tracking-tight text-white sm:text-3xl">
              {COPY.es.title} · {COPY.en.title}
            </h1>
            <p className="mt-2.5 flex items-center gap-2 text-sm leading-relaxed text-zinc-500">
              <Languages className="h-4 w-4" />
              Gacha Manager
            </p>
          </div>

          <div className="space-y-3">
            {LANGUAGES.map((option) => {
              const isSuggested = option.id === activeLanguage
              return (
                <button
                  key={option.id}
                  type="button"
                  onClick={() => setLanguage(option.id)}
                  className="group flex w-full items-center justify-between rounded-xl border border-white/10 bg-white/[0.03] px-5 py-4 text-left transition-all duration-300 hover:-translate-y-0.5 hover:border-white/30 hover:bg-white/[0.07] focus:outline-none focus:ring-4 focus:ring-white/10"
                >
                  <span>
                    <span className="block text-[15px] font-semibold text-white">
                      {option.native}
                    </span>
                    <span className="block text-[13px] text-zinc-500">{option.hint}</span>
                  </span>
                  {isSuggested ? (
                    <span className="flex items-center gap-1.5 rounded-full bg-white/10 px-2.5 py-1 text-[11px] font-medium uppercase tracking-wide text-zinc-300">
                      <Check className="h-3 w-3" />
                      {option.id === 'es' ? 'Sugerido' : 'Suggested'}
                    </span>
                  ) : (
                    <span className="text-[11px] font-medium uppercase tracking-wide text-zinc-600">
                      {option.id}
                    </span>
                  )}
                </button>
              )
            })}
          </div>

          <p className="mt-8 text-center text-[13px] leading-relaxed text-zinc-600">
            {COPY.es.subtitle}
            <br />
            {COPY.en.subtitle}
          </p>
        </div>
      </div>
    </div>
  )
}

export default LanguageGate

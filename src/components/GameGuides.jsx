import { useNavigate, useParams } from 'react-router-dom'
import { ArrowLeft, ChevronRight, Compass, Sparkles } from 'lucide-react'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { getGameModes, getModeName } from '../data/gameModes'
import ProfileButton from './ProfileButton'

function GameGuides() {
  const { t, activeLanguage } = useI18n()
  const navigate = useNavigate()
  const { gameId } = useParams()
  const game = getGameById(gameId)
  const modes = getGameModes(gameId)

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <div className="pointer-events-none fixed inset-0" aria-hidden="true">
        <div className="absolute -top-40 left-[12%] h-[30rem] w-[30rem] animate-pulse rounded-full bg-emerald-600/10 blur-[130px] [animation-duration:12s]" />
      </div>

      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-5xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}`)}
            aria-label={t('characters.backToGame')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">
              {t('gameGuides.title')}
            </h1>
            <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>
              {game?.name ?? gameId}
            </p>
          </div>
          <ProfileButton />
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-5xl px-4 py-10 sm:px-6 sm:py-14">
        <section className="mb-8 rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
          <h2 className="mb-2 flex items-center gap-2.5 text-lg font-semibold tracking-tight text-white">
            <Compass className="h-5 w-5 text-emerald-400" />
            {t('gameGuides.headline')}
          </h2>
          <p className="text-[15px] leading-7 text-zinc-400">{t('gameGuides.description')}</p>
        </section>

        {modes.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
            <Compass className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
            <p className="text-zinc-400">{t('gameGuides.empty')}</p>
          </div>
        ) : (
          <div className="grid gap-4 sm:grid-cols-2">
            {modes.map((mode) => (
              <button
                key={mode.id}
                type="button"
                onClick={() => navigate(`/game/${gameId}/guides/${mode.id}`)}
                className="group flex flex-col rounded-2xl border border-white/10 bg-[#1a1a1a] p-5 text-left transition-all duration-300 hover:-translate-y-1 hover:border-emerald-500/40 hover:shadow-[0_0_35px_rgba(16,185,129,0.15)] focus:outline-none focus:ring-4 focus:ring-emerald-500/25"
              >
                <div className="mb-3 flex items-start justify-between gap-3">
                  <h3 className="text-[17px] font-semibold text-white">
                    {getModeName(mode, activeLanguage)}
                  </h3>

                  <div className="flex shrink-0 items-center gap-2">
                    {mode.isNew && (
                      <span className="inline-flex items-center gap-1 rounded-full bg-emerald-500/15 px-2.5 py-1 text-[11px] font-semibold uppercase tracking-wide text-emerald-300 ring-1 ring-emerald-400/30">
                        <Sparkles className="h-3 w-3" />
                        {t('gameGuides.new')}
                      </span>
                    )}
                    <ChevronRight className="h-4 w-4 text-zinc-600 transition-transform duration-300 group-hover:translate-x-1 group-hover:text-white" />
                  </div>
                </div>

                <ul className="space-y-1.5">
                  {mode.points[activeLanguage].map((point) => (
                    <li key={point} className="flex gap-2.5 text-sm leading-6 text-zinc-400">
                      <span className="mt-2.5 h-1 w-1 shrink-0 rounded-full bg-zinc-600" />
                      {point}
                    </li>
                  ))}
                </ul>
              </button>
            ))}
          </div>
        )}
      </main>
    </div>
  )
}

export default GameGuides

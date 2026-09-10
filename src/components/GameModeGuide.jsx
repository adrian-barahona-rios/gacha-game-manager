import { useNavigate, useParams } from 'react-router-dom'
import { ArrowLeft, Compass, Sparkles } from 'lucide-react'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { getGameMode, getModeName } from '../data/gameModes'
import YouTubeGuidesSection from './YouTubeGuidesSection'
import ProfileButton from './ProfileButton'

function GameModeGuide() {
  const { t, activeLanguage } = useI18n()
  const navigate = useNavigate()
  const { gameId, modeId } = useParams()
  const game = getGameById(gameId)
  const mode = getGameMode(gameId, modeId)

  // La busqueda va siempre con el nombre en ingles del modo: es el que usan
  // los canales de guias, tambien los que hablan en espanol.
  const query = mode ? `${mode.name} ${game?.name ?? gameId} ${t('guides.video.queryWord')}` : ''

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <div className="pointer-events-none fixed inset-0" aria-hidden="true">
        <div className="absolute -top-40 right-[10%] h-[30rem] w-[30rem] animate-pulse rounded-full bg-emerald-600/10 blur-[130px] [animation-duration:12s]" />
      </div>

      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-4xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}/guides`)}
            aria-label={t('common.back')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">
              {mode ? getModeName(mode, activeLanguage) : t('gameGuides.title')}
            </h1>
            <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>
              {game?.name ?? gameId}
            </p>
          </div>
          <ProfileButton />
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-4xl space-y-6 px-4 py-10 sm:px-6 sm:py-14">
        {!mode ? (
          <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
            <Compass className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
            <p className="mb-6 text-zinc-400">{t('gameGuides.modeNotFound')}</p>
            <button
              type="button"
              onClick={() => navigate(`/game/${gameId}/guides`)}
              className="inline-flex items-center gap-2 rounded-lg bg-white px-4 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:bg-emerald-500 hover:text-white active:scale-95"
            >
              <ArrowLeft className="h-4 w-4" />
              {t('gameGuides.backToModes')}
            </button>
          </div>
        ) : (
          <>
            <section className="rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
              <div className="mb-5 flex flex-wrap items-center gap-3">
                <h2 className="text-lg font-semibold tracking-tight text-white">
                  {t('gameGuides.aboutMode')}
                </h2>
                {mode.isNew && (
                  <span className="inline-flex items-center gap-1 rounded-full bg-emerald-500/15 px-2.5 py-1 text-[11px] font-semibold uppercase tracking-wide text-emerald-300 ring-1 ring-emerald-400/30">
                    <Sparkles className="h-3 w-3" />
                    {t('gameGuides.new')}
                  </span>
                )}
                {mode.since && (
                  <span className="rounded-full bg-white/5 px-2.5 py-1 text-[11px] font-medium text-zinc-400 ring-1 ring-white/15">
                    {t('gameGuides.since', { version: mode.since })}
                  </span>
                )}
              </div>

              <ul className="space-y-3">
                {mode.points[activeLanguage].map((point) => (
                  <li key={point} className="flex gap-3 text-[15px] leading-7 text-zinc-300">
                    <span className="mt-3 h-1.5 w-1.5 shrink-0 rounded-full bg-emerald-400/70" />
                    {point}
                  </li>
                ))}
              </ul>

              {mode.nameEs && mode.nameEs !== mode.name && (
                <p className="mt-5 text-xs text-zinc-600">
                  {t('gameGuides.alsoKnown', {
                    name: activeLanguage === 'es' ? mode.name : mode.nameEs,
                  })}
                </p>
              )}
            </section>

            <YouTubeGuidesSection query={query} key={activeLanguage} />
          </>
        )}
      </main>
    </div>
  )
}

export default GameModeGuide

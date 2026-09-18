import { useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { ArrowLeft } from 'lucide-react'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { VIDEO_SECTIONS } from '../data/videoGuides'
import YouTubeGuidesSection from './YouTubeGuidesSection'
import ProfileButton from './ProfileButton'

// Guias en video del juego: gameplays, como empezar, capturas, jefes... Cada
// pestana es una busqueda distinta en YouTube.
function VideoGuides() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const { t } = useI18n()
  const game = getGameById(gameId)
  const section = VIDEO_SECTIONS[gameId]
  const [categoriaId, setCategoriaId] = useState(section?.categories[0]?.id ?? null)

  if (!section) {
    return null
  }

  const categoria = section.categories.find((c) => c.id === categoriaId) ?? section.categories[0]

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
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
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">{t('videos.title')}</h1>
            <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>{game?.name ?? gameId}</p>
          </div>

          <ProfileButton />
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-5xl px-4 py-10 sm:px-6 sm:py-14">
        <p className="mb-6 max-w-3xl text-sm leading-relaxed text-zinc-400">{t('videos.hint')}</p>

        <div className="mb-8 flex flex-wrap gap-2">
          {section.categories.map((item) => {
            const isActive = item.id === categoria.id
            return (
              <button
                key={item.id}
                type="button"
                aria-pressed={isActive}
                onClick={() => setCategoriaId(item.id)}
                className={`rounded-full px-3.5 py-1.5 text-sm font-medium ring-1 transition-all duration-200 focus:outline-none focus:ring-4 focus:ring-white/15 ${
                  isActive
                    ? 'bg-white text-black ring-white'
                    : 'bg-white/[0.03] text-zinc-300 ring-white/15 hover:bg-white/10 hover:text-white'
                }`}
              >
                {t(item.labelKey)}
              </button>
            )
          })}
        </div>

        <YouTubeGuidesSection
          query={`${section.queryPrefix} ${t(categoria.queryKey)}`}
          recent={categoria.recent}
          subtitleKey={categoria.recent ? undefined : 'videos.subtitle'}
          emptyKey="videos.empty"
        />
      </main>
    </div>
  )
}

export default VideoGuides

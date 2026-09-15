import { useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { ArrowLeft, Map as MapIcon, PlayCircle } from 'lucide-react'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { hasExploration } from '../data/exploration'
import ExplorationRoutes from './ExplorationRoutes'
import InteractiveMap from './InteractiveMap'
import ProfileButton from './ProfileButton'

const TABS = [
  { id: 'mapa', labelKey: 'exploration.tab.map', icon: MapIcon, enabled: true },
  { id: 'rutas', labelKey: 'exploration.tab.guides', icon: PlayCircle, enabled: true },
]

// Apartado de exploracion: el mapa interactivo oficial y guias en video de
// rutas por el mapa. Desde una ruta, "Ver en el mapa" salta a la pestana del
// mapa con esa zona o ese filtro ya puestos.
function ExplorationPage() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const { t } = useI18n()
  const game = getGameById(gameId)
  const [tab, setTab] = useState('mapa')
  const [enfoque, setEnfoque] = useState(null)

  const verEnMapa = (destino) => {
    setEnfoque({ ...destino, vez: (enfoque?.vez ?? 0) + 1 })
    setTab('mapa')
  }

  return (
    <div className="flex h-dvh min-h-[36rem] scheme-dark flex-col bg-black">
      <header className="z-20 shrink-0 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-[110rem] items-center gap-4 px-4 py-4 sm:px-6">
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
              {t('exploration.title')}
            </h1>
            <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>
              {game?.name ?? gameId}
            </p>
          </div>

          <ProfileButton />
        </div>
      </header>

      <main className="mx-auto flex min-h-0 w-full max-w-[110rem] flex-1 flex-col px-3 pb-3 pt-3 sm:px-6 sm:pb-6">
        <div role="tablist" className="mb-3 flex shrink-0 gap-1 overflow-x-auto [scrollbar-width:none] border-b border-white/10 sm:gap-2">
          {TABS.map((item) => {
            const Icon = item.icon
            const isActive = tab === item.id
            return (
              <button
                key={item.id}
                type="button"
                role="tab"
                aria-selected={isActive}
                disabled={!item.enabled}
                onClick={() => setTab(item.id)}
                className={`-mb-px flex shrink-0 items-center gap-2 whitespace-nowrap border-b-2 px-3 py-2.5 sm:px-4 text-sm font-medium transition-colors duration-200 focus:outline-none disabled:cursor-not-allowed ${
                  isActive
                    ? 'border-white text-white'
                    : 'border-transparent text-zinc-500 hover:text-zinc-200 disabled:hover:text-zinc-500'
                }`}
              >
                <Icon className="h-4 w-4" />
                {t(item.labelKey)}
                {!item.enabled && (
                  <span className="rounded bg-white/5 px-1.5 py-0.5 text-[10px] uppercase tracking-wide text-zinc-500">
                    {t('common.soon')}
                  </span>
                )}
              </button>
            )
          })}
        </div>

        {!hasExploration(gameId) ? (
          <p className="py-20 text-center text-zinc-500">{t('exploration.unavailable')}</p>
        ) : (
          <>
            {tab === 'mapa' && <InteractiveMap key={enfoque?.vez ?? 0} gameId={gameId} enfoque={enfoque} />}
            {/* Las rutas se quedan montadas al ir al mapa: al volver sigue
                elegido lo mismo. */}
            <div hidden={tab !== 'rutas'} className="flex min-h-0 flex-1 flex-col">
              <ExplorationRoutes gameId={gameId} onViewOnMap={verEnMapa} />
            </div>
          </>
        )}
      </main>
    </div>
  )
}

export default ExplorationPage

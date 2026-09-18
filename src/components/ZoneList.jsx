import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, Compass, Loader2, MapPin, Skull } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { getElementChip } from '../data/characterStyles'
import { EXPLORATION_TIPS, POINTS_OF_INTEREST, REGIONS } from '../data/aniimoZones'
import ProfileButton from './ProfileButton'

// El ancla de cada zona, para poder llegar desde la ficha de una criatura.
const ancla = (zona) => encodeURIComponent(zona)

// Apartado de mapa y zonas: que criaturas se capturan en cada sitio, que jefes
// hay y que te vas a encontrar por el mundo.
function ZoneList() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const { t } = useI18n()
  const game = getGameById(gameId)

  const [criaturas, setCriaturas] = useState([])
  const [jefes, setJefes] = useState([])
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')

  useEffect(() => {
    let active = true

    Promise.all([
      supabase.from('characters').select('id, name, image_url, element, habitats').eq('game_id', gameId).order('name'),
      supabase.from('enemies').select('id, name, image_url, faction, classification').eq('game_id', gameId).order('name'),
    ]).then(([personajes, enemigos]) => {
      if (!active) return
      const fallo = personajes.error ?? enemigos.error
      if (fallo) {
        setError(t('zones.error.load', { message: fallo.message }))
      } else {
        setError('')
        setCriaturas(personajes.data ?? [])
        setJefes(enemigos.data ?? [])
      }
      setIsLoading(false)
    })

    return () => {
      active = false
    }
  }, [gameId, t])

  // Al llegar con /zones#Campos%20Nubosos se baja hasta esa zona.
  useEffect(() => {
    if (isLoading || !window.location.hash) return
    const destino = document.getElementById(window.location.hash.slice(1))
    destino?.scrollIntoView({ behavior: 'smooth', block: 'start' })
  }, [isLoading])

  const deLaZona = (zona) => criaturas.filter((c) => (c.habitats ?? []).includes(zona))
  const jefesDeLaZona = (zona) => jefes.filter((j) => j.faction === zona)
  const sinZona = criaturas.filter((c) => (c.habitats ?? []).length === 0)

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-7xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}`)}
            aria-label={t('characters.backToGame')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">{t('zones.title')}</h1>
            <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>{game?.name ?? gameId}</p>
          </div>

          <ProfileButton />
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-7xl px-4 py-10 sm:px-6 sm:py-14">
        {error && (
          <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
            <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{error}</p>
          </div>
        )}

        <p className="mb-8 max-w-3xl text-sm leading-relaxed text-zinc-400">{t('zones.hint')}</p>

        {isLoading ? (
          <div className="flex items-center justify-center gap-2.5 py-20 text-zinc-500">
            <Loader2 className="h-5 w-5 animate-spin" />
            {t('common.loading')}
          </div>
        ) : (
          <>
            {REGIONS.map((region) => (
              <section key={region.id} className="mb-12">
                <h2 className="mb-1.5 flex items-center gap-2.5 text-xl font-semibold text-white">
                  <Compass className="h-5 w-5 text-zinc-500" />
                  {region.name}
                </h2>
                <p className="mb-6 max-w-3xl text-sm leading-relaxed text-zinc-400">{region.description}</p>

                {region.areas.length === 0 ? (
                  <p className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-6 text-sm text-zinc-500">
                    {t('zones.noCreatures')}
                  </p>
                ) : (
                  <div className="space-y-4">
                    {region.areas.map((zona) => {
                      const habitantes = deLaZona(zona)
                      const susJefes = jefesDeLaZona(zona)

                      return (
                        <article
                          key={zona}
                          id={ancla(zona)}
                          className="scroll-mt-24 rounded-2xl border border-white/10 bg-white/[0.02] p-4"
                        >
                          <h3 className="mb-3 flex flex-wrap items-center gap-x-3 gap-y-1 text-base font-semibold text-white">
                            <MapPin className="h-4 w-4 shrink-0 text-zinc-500" />
                            {zona}
                            <span className="text-xs font-normal text-zinc-500">
                              {t(habitantes.length === 1 ? 'zones.creatureCount' : 'zones.creatureCountPlural', {
                                count: habitantes.length,
                              })}
                            </span>
                          </h3>

                          {habitantes.length > 0 ? (
                            <ul className="mb-3 grid grid-cols-3 gap-2 sm:grid-cols-5 lg:grid-cols-8">
                              {habitantes.map((criatura) => (
                                <li key={criatura.id}>
                                  <button
                                    type="button"
                                    onClick={() => navigate(`/game/${gameId}/characters/${criatura.id}`)}
                                    className="group flex w-full flex-col items-center gap-1 rounded-xl border border-white/10 bg-white/[0.03] p-2 transition hover:-translate-y-0.5 hover:border-white/25 hover:bg-white/[0.07] focus:outline-none focus:ring-4 focus:ring-white/15"
                                  >
                                    <span className="flex aspect-square w-full items-center justify-center overflow-hidden rounded-lg bg-black/30">
                                      {criatura.image_url ? (
                                        <img
                                          src={criatura.image_url}
                                          alt=""
                                          loading="lazy"
                                          className="h-full w-full object-contain transition-transform duration-300 group-hover:scale-105"
                                        />
                                      ) : (
                                        <span className="text-sm font-bold text-white/70">{criatura.name.charAt(0)}</span>
                                      )}
                                    </span>
                                    <span className="line-clamp-2 text-center text-[11px] font-medium leading-tight text-zinc-200">
                                      {criatura.name}
                                    </span>
                                    {criatura.element && (
                                      <span
                                        className={`rounded-md bg-white/[0.03] px-1.5 py-0.5 text-[10px] font-medium ring-1 ${getElementChip(criatura.element)}`}
                                      >
                                        {criatura.element}
                                      </span>
                                    )}
                                  </button>
                                </li>
                              ))}
                            </ul>
                          ) : (
                            <p className="mb-3 text-sm text-zinc-500">{t('zones.noCreatures')}</p>
                          )}

                          {susJefes.length > 0 && (
                            <div className="flex flex-wrap items-center gap-2 border-t border-white/5 pt-3">
                              <span className="flex items-center gap-1.5 text-[11px] font-semibold uppercase tracking-wide text-zinc-500">
                                <Skull className="h-3.5 w-3.5" />
                                {t('zones.bosses')}
                              </span>
                              {susJefes.map((jefe) => (
                                <button
                                  key={jefe.id}
                                  type="button"
                                  onClick={() => navigate(`/game/${gameId}/enemies/${jefe.id}`)}
                                  className="rounded-full border border-white/15 bg-white/[0.03] px-3 py-1 text-xs font-medium text-zinc-200 transition hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/15"
                                >
                                  {jefe.name}
                                </button>
                              ))}
                            </div>
                          )}
                        </article>
                      )
                    })}
                  </div>
                )}
              </section>
            ))}

            {sinZona.length > 0 && (
              <section className="mb-12 rounded-2xl border border-white/10 bg-white/[0.02] p-4">
                <h2 className="mb-1 text-base font-semibold text-white">{t('zones.unlisted')}</h2>
                <p className="mb-3 text-sm text-zinc-500">{t('zones.unlistedHint')}</p>
                <div className="flex flex-wrap gap-2">
                  {sinZona.map((criatura) => (
                    <button
                      key={criatura.id}
                      type="button"
                      onClick={() => navigate(`/game/${gameId}/characters/${criatura.id}`)}
                      className="rounded-full border border-white/15 bg-white/[0.03] px-3 py-1 text-xs font-medium text-zinc-200 transition hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/15"
                    >
                      {criatura.name}
                    </button>
                  ))}
                </div>
              </section>
            )}

            <section className="mb-12">
              <h2 className="mb-4 text-xl font-semibold text-white">{t('zones.poi')}</h2>
              <ul className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
                {POINTS_OF_INTEREST.map((punto) => (
                  <li key={punto.name} className="rounded-2xl border border-white/10 bg-white/[0.02] p-4">
                    <p className="mb-1 text-sm font-semibold text-white">{punto.name}</p>
                    <p className="text-[13px] leading-relaxed text-zinc-400">{punto.description}</p>
                  </li>
                ))}
              </ul>
            </section>

            <section>
              <h2 className="mb-4 text-xl font-semibold text-white">{t('zones.tips')}</h2>
              <ul className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
                {EXPLORATION_TIPS.map((consejo) => (
                  <li key={consejo.name} className="rounded-2xl border border-white/10 bg-white/[0.02] p-4">
                    <p className="mb-1 text-sm font-semibold text-white">{consejo.name}</p>
                    <p className="text-[13px] leading-relaxed text-zinc-400">{consejo.description}</p>
                  </li>
                ))}
              </ul>
            </section>
          </>
        )}
      </main>
    </div>
  )
}

export default ZoneList

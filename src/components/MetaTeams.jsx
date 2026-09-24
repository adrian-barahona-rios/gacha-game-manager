import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, Loader2, Users } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { getElementChip } from '../data/characterStyles'
import { roleByValue } from '../data/aniimoRoles'
import ProfileButton from './ProfileButton'

// Una criatura dentro de un hueco del equipo. Si todavia no tiene ficha en la
// base de datos se ensena igual, pero sin enlace.
function Miembro({ opcion, criatura, onOpen }) {
  const contenido = (
    <>
      <span className="flex h-16 w-16 items-center justify-center overflow-hidden rounded-lg bg-black/30">
        {criatura?.image_url ? (
          <img
            src={criatura.image_url}
            alt=""
            loading="lazy"
            className="h-full w-full object-contain transition-transform duration-300 group-hover:scale-105"
          />
        ) : (
          <span className="text-sm font-bold text-white/60">{opcion.nombre.charAt(0)}</span>
        )}
      </span>
      <span className="line-clamp-2 text-center text-[11px] font-medium leading-tight text-zinc-200">
        {opcion.nombre}
      </span>
      {criatura?.element && (
        <span
          className={`rounded-md bg-white/[0.03] px-1.5 py-0.5 text-[10px] font-medium ring-1 ${getElementChip(criatura.element)}`}
        >
          {criatura.element}
        </span>
      )}
    </>
  )

  if (!criatura) {
    return <span className="flex w-full flex-col items-center gap-1 rounded-xl border border-dashed border-white/10 bg-white/[0.02] p-2">{contenido}</span>
  }

  return (
    <button
      type="button"
      onClick={() => onOpen(criatura.id)}
      className="group flex w-full flex-col items-center gap-1 rounded-xl border border-white/10 bg-white/[0.03] p-2 transition hover:-translate-y-0.5 hover:border-white/25 hover:bg-white/[0.07] focus:outline-none focus:ring-4 focus:ring-white/15"
    >
      {contenido}
    </button>
  )
}

// Equipos meta: la composicion recomendada para cada elemento, con sus cuatro
// huecos por rol y por que funciona.
function MetaTeams() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const { t, activeLanguage } = useI18n()
  const game = getGameById(gameId)

  const [equipos, setEquipos] = useState([])
  const [criaturas, setCriaturas] = useState({})
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')
  const [elemento, setElemento] = useState('')

  useEffect(() => {
    let active = true

    Promise.all([
      supabase.from('meta_teams').select('*').eq('game_id', gameId).order('sort_order'),
      supabase.from('characters').select('id, name, image_url, element, role').eq('game_id', gameId),
    ]).then(([teams, chars]) => {
      if (!active) return
      const fallo = teams.error ?? chars.error
      if (fallo) {
        setError(t('teams.error.load', { message: fallo.message }))
      } else {
        setError('')
        setEquipos(teams.data ?? [])
        setCriaturas(Object.fromEntries((chars.data ?? []).map((c) => [c.id, c])))
      }
      setIsLoading(false)
    })

    return () => {
      active = false
    }
  }, [gameId, t])

  const elementos = [...new Set(equipos.map((e) => e.element).filter(Boolean))].sort((a, b) =>
    a.localeCompare(b, 'es'),
  )
  const visibles = elemento ? equipos.filter((e) => e.element === elemento) : equipos

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-6xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}`)}
            aria-label={t('characters.backToGame')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">{t('teams.title')}</h1>
            <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>{game?.name ?? gameId}</p>
          </div>

          <ProfileButton />
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-6xl px-4 py-10 sm:px-6 sm:py-14">
        {error && (
          <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
            <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{error}</p>
          </div>
        )}

        <p className="mb-6 max-w-3xl text-sm leading-relaxed text-zinc-400">{t('teams.hint')}</p>

        {isLoading ? (
          <div className="flex items-center justify-center gap-2.5 py-20 text-zinc-500">
            <Loader2 className="h-5 w-5 animate-spin" />
            {t('common.loading')}
          </div>
        ) : equipos.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
            <Users className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
            <p className="text-zinc-400">{t('teams.empty')}</p>
          </div>
        ) : (
          <>
            {elementos.length > 1 && (
              <div className="mb-8 flex flex-wrap gap-2">
                {['', ...elementos].map((valor) => {
                  const isActive = elemento === valor
                  return (
                    <button
                      key={valor || 'todos'}
                      type="button"
                      aria-pressed={isActive}
                      onClick={() => setElemento(valor)}
                      className={`rounded-full px-3 py-1 text-xs font-medium ring-1 transition-all duration-200 focus:outline-none focus:ring-4 focus:ring-white/15 ${
                        isActive
                          ? 'bg-white text-black ring-white'
                          : `bg-white/[0.03] hover:bg-white/10 ${valor ? getElementChip(valor) : 'text-zinc-300 ring-white/15'}`
                      }`}
                    >
                      {valor || t('enemies.all')}
                    </button>
                  )
                })}
              </div>
            )}

            <div className="space-y-4">
              {visibles.map((equipo) => {
                const huecos = Array.isArray(equipo.slots) ? equipo.slots : []
                const porque = activeLanguage === 'en' ? equipo.why_en : equipo.why_es

                return (
                  <article key={equipo.id} className="rounded-2xl border border-white/10 bg-white/[0.02] p-4 sm:p-5">
                    <h2 className="mb-4 flex flex-wrap items-center gap-x-3 gap-y-2 text-base font-semibold text-white">
                      {activeLanguage === 'en' ? equipo.name_en : equipo.name_es}
                      {equipo.element && (
                        <span
                          className={`rounded-full px-2.5 py-0.5 text-[11px] font-medium ring-1 ${getElementChip(equipo.element)}`}
                        >
                          {equipo.element}
                        </span>
                      )}
                    </h2>

                    <div className="mb-4 grid grid-cols-2 gap-3 sm:grid-cols-4">
                      {huecos.map((hueco, index) => {
                        const rol = roleByValue(hueco.rol)
                        return (
                          <div key={`${hueco.rol}-${index}`} className="rounded-xl border border-white/10 bg-black/20 p-2.5">
                            <p
                              className={`mb-2 inline-block rounded-md px-2 py-0.5 text-[10px] font-semibold uppercase tracking-wide ring-1 ${
                                rol?.chip ?? 'bg-white/5 text-zinc-300 ring-white/15'
                              }`}
                            >
                              {hueco.rol}
                            </p>
                            <div className="space-y-2">
                              {(hueco.opciones ?? []).map((opcion) => (
                                <Miembro
                                  key={opcion.nombre}
                                  opcion={opcion}
                                  criatura={opcion.id ? criaturas[opcion.id] : null}
                                  onOpen={(id) => navigate(`/game/${gameId}/characters/${id}`)}
                                />
                              ))}
                            </div>
                          </div>
                        )
                      })}
                    </div>

                    {porque && <p className="text-[13px] leading-relaxed text-zinc-400">{porque}</p>}
                  </article>
                )
              })}
            </div>

            <p className="mt-6 text-xs leading-relaxed text-zinc-600">{t('teams.source')}</p>
          </>
        )}
      </main>
    </div>
  )
}

export default MetaTeams

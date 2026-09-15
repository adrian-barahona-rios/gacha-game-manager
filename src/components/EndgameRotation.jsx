import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { CalendarDays, ChevronDown, Loader2, Skull, Sparkles, Users } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getElementChip } from '../data/characterStyles'

const formatoFecha = (texto, idioma) =>
  new Date(`${texto}T00:00:00`).toLocaleDateString(idioma === 'en' ? 'en-GB' : 'es-ES', {
    day: 'numeric',
    month: 'long',
  })

function Elementos({ lista }) {
  return (
    <span className="flex flex-wrap gap-1.5">
      {lista.map((elemento) => (
        <span
          key={elemento}
          className={`rounded-md bg-white/[0.03] px-2 py-0.5 text-[11px] font-medium ring-1 ${getElementChip(elemento)}`}
        >
          {elemento}
        </span>
      ))}
    </span>
  )
}

function Efectos({ lista, t }) {
  return (
    <ul className="space-y-2.5">
      {lista.map((efecto, index) => (
        <li key={`${efecto.nombre}-${index}`} className="rounded-xl border border-white/10 bg-black/20 p-3.5">
          <p className="mb-0.5 flex flex-wrap items-center gap-2 text-sm font-semibold text-white">
            {efecto.nombre}
            {efecto.tipo === 'elegible' && (
              <span className="rounded-full bg-sky-500/15 px-2 py-0.5 text-[10px] font-semibold uppercase tracking-wide text-sky-200 ring-1 ring-sky-400/30">
                {t('endgame.selectable')}
              </span>
            )}
          </p>
          {efecto.descripcion && (
            <p className="whitespace-pre-wrap text-[13px] leading-relaxed text-zinc-400">{efecto.descripcion}</p>
          )}
        </li>
      ))}
    </ul>
  )
}

// Grupos de personajes (iniciales, invitados, equipos recomendados) con icono.
function GruposPersonajes({ grupos, personajes, onOpen }) {
  return (
    <ul className="space-y-3">
      {grupos.map((grupo, index) => (
        <li key={`${grupo.nombre}-${index}`}>
          <p className="mb-1.5 text-xs text-zinc-400">{grupo.nombre}</p>
          <div className="flex flex-wrap gap-2">
            {(grupo.personajes ?? []).map((id) => {
              const pj = personajes[id]
              if (!pj) return null
              return (
                <button
                  key={id}
                  type="button"
                  onClick={() => onOpen(id)}
                  title={pj.name}
                  className="flex items-center gap-2 rounded-xl border border-white/10 bg-white/[0.03] py-1 pl-1 pr-3 text-left transition hover:border-white/25 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/15"
                >
                  <span className="flex h-9 w-9 shrink-0 items-center justify-center overflow-hidden rounded-lg bg-black/40">
                    {pj.image_url ? (
                      <img src={pj.image_url} alt="" loading="lazy" className="h-full w-full object-cover" />
                    ) : (
                      <Users className="h-4 w-4 text-zinc-600" />
                    )}
                  </span>
                  <span className="text-[13px] text-zinc-200">{pj.name}</span>
                </button>
              )
            })}
          </div>
        </li>
      ))}
    </ul>
  )
}

// Enemigos que no tienen ficha en la app se guardan como "nombre:...".
const SIN_FICHA = 'nombre:'

// Rotacion actual de un modo de endgame (y la siguiente si ya se conoce), con
// los enemigos de cada piso enlazados a su ficha.
function EndgameRotation({ gameId, modeId }) {
  const { t, activeLanguage } = useI18n()
  const navigate = useNavigate()
  const [cargado, setCargado] = useState(null)
  // Piso desplegado por rotacion. Por defecto, el ultimo (el mas dificil).
  const [abiertos, setAbiertos] = useState({})

  useEffect(() => {
    let active = true

    supabase
      .from('endgame_rotations')
      .select('id, name, status, begins_on, ends_on, effects, floors, extra')
      .eq('game_id', gameId)
      .eq('mode', modeId)
      .in('status', ['actual', 'proxima', 'reciente'])
      .order('begins_on', { ascending: true, nullsFirst: true })
      .then(async ({ data }) => {
        const rotaciones = data ?? []
        const ids = [
          ...new Set(
            rotaciones.flatMap((r) =>
              (r.floors ?? []).flatMap((p) => (p.mitades ?? []).flatMap((m) => (m.oleadas ?? []).flat())),
            ),
          ),
        ].filter((id) => !id.startsWith(SIN_FICHA))
        const idsPersonajes = [
          ...new Set(
            rotaciones.flatMap((r) =>
              [...(r.extra?.grupos ?? []), ...(r.extra?.equipos ?? [])].flatMap((g) => g.personajes ?? []),
            ),
          ),
        ]
        const [{ data: enemigos }, { data: personajes }] = await Promise.all([
          ids.length
            ? supabase.from('enemies').select('id, name, image_url, weaknesses').in('id', ids)
            : { data: [] },
          idsPersonajes.length
            ? supabase.from('characters').select('id, name, image_url').in('id', idsPersonajes)
            : { data: [] },
        ])
        if (!active) return
        setCargado({
          clave: `${gameId}/${modeId}`,
          rotaciones,
          enemigos: Object.fromEntries((enemigos ?? []).map((e) => [e.id, e])),
          personajes: Object.fromEntries((personajes ?? []).map((p) => [p.id, p])),
        })
      })

    return () => {
      active = false
    }
  }, [gameId, modeId])

  const isLoading = cargado?.clave !== `${gameId}/${modeId}`

  if (isLoading) {
    return (
      <section className="flex items-center gap-2.5 rounded-3xl border border-white/10 bg-[#111114]/80 p-6 text-sm text-zinc-500">
        <Loader2 className="h-4 w-4 animate-spin" />
        {t('common.loading')}
      </section>
    )
  }

  if (cargado.rotaciones.length === 0) return null

  return (
    <>
      {cargado.rotaciones.map((rotacion) => {
        const pisos = rotacion.floors ?? []
        const abierto = abiertos[rotacion.id] ?? pisos.at(-1)?.piso
        const generales = (rotacion.effects ?? []).filter((e) => e.tipo !== 'elegible')
        const elegibles = (rotacion.effects ?? []).filter((e) => e.tipo === 'elegible')

        return (
          <section
            key={rotacion.id}
            className="rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8"
          >
            <div className="mb-5 flex flex-wrap items-center gap-3">
              <span className="rounded-full bg-emerald-500/15 px-2.5 py-1 text-[11px] font-semibold uppercase tracking-wide text-emerald-300 ring-1 ring-emerald-400/30">
                {t(`endgame.status.${rotacion.status}`)}
              </span>
              <h2 className="text-lg font-semibold tracking-tight text-white">{rotacion.name}</h2>
              {rotacion.begins_on && rotacion.ends_on && (
                <span className="flex items-center gap-1.5 text-xs text-zinc-400">
                  <CalendarDays className="h-3.5 w-3.5" />
                  {t('endgame.dates', {
                    from: formatoFecha(rotacion.begins_on, activeLanguage),
                    to: formatoFecha(rotacion.ends_on, activeLanguage),
                  })}
                </span>
              )}
            </div>

            {generales.length > 0 && (
              <div className="mb-6">
                <h3 className="mb-3 flex items-center gap-2 text-sm font-semibold text-zinc-200">
                  <Sparkles className="h-4 w-4 text-amber-300" />
                  {t('endgame.effects')}
                </h3>
                <Efectos lista={generales} t={t} />
              </div>
            )}

            {elegibles.length > 0 && (
              <div className="mb-6">
                <h3 className="mb-3 flex items-center gap-2 text-sm font-semibold text-zinc-200">
                  <Sparkles className="h-4 w-4 text-sky-300" />
                  {t('endgame.selectableEffects')}
                </h3>
                <Efectos lista={elegibles} t={t} />
              </div>
            )}

            {(rotacion.extra?.elementos ?? []).length > 0 && (
              <div className="mb-6 flex flex-wrap items-center gap-2">
                <span className="text-sm font-semibold text-zinc-200">{t('endgame.allowedElements')}</span>
                <Elementos lista={rotacion.extra.elementos} />
              </div>
            )}

            {(rotacion.extra?.grupos ?? []).length > 0 && (
              <div className="mb-6">
                <GruposPersonajes
                  grupos={rotacion.extra.grupos}
                  personajes={cargado.personajes}
                  onOpen={(id) => navigate(`/game/${gameId}/characters/${id}`)}
                />
              </div>
            )}

            {(rotacion.extra?.equipos ?? []).length > 0 && (
              <div className="mb-6">
                <h3 className="mb-3 flex items-center gap-2 text-sm font-semibold text-zinc-200">
                  <Users className="h-4 w-4 text-sky-300" />
                  {t('endgame.teams')}
                </h3>
                <GruposPersonajes
                  grupos={rotacion.extra.equipos}
                  personajes={cargado.personajes}
                  onOpen={(id) => navigate(`/game/${gameId}/characters/${id}`)}
                />
              </div>
            )}

            {pisos.length === 0 && rotacion.status === 'proxima' && (
              <p className="text-xs text-zinc-500">{t('endgame.pendingHint')}</p>
            )}

            {pisos.length > 0 && (
            <h3 className="mb-3 flex items-center gap-2 text-sm font-semibold text-zinc-200">
              <Skull className="h-4 w-4 text-rose-300" />
              {t('endgame.floors')}
            </h3>
            )}
            <ul className="space-y-2">
              {pisos.map((piso) => {
                const isOpen = abierto === piso.piso
                return (
                  <li key={piso.piso} className="rounded-2xl border border-white/10 bg-white/[0.02]">
                    <button
                      type="button"
                      aria-expanded={isOpen}
                      onClick={() => setAbiertos((prev) => ({ ...prev, [rotacion.id]: isOpen ? null : piso.piso }))}
                      className="flex w-full items-center justify-between gap-3 px-4 py-3 text-left text-sm font-medium text-zinc-200 transition hover:text-white focus:outline-none"
                    >
                      {piso.nombre || t('endgame.floor', { number: piso.piso })}
                      <ChevronDown className={`h-4 w-4 shrink-0 transition-transform duration-300 ${isOpen ? 'rotate-180' : ''}`} />
                    </button>

                    {isOpen && (
                      <div className="space-y-4 border-t border-white/10 px-4 py-4">
                        {(piso.mitades ?? []).map((mitad, index) => (
                          <div key={index}>
                            <div className="mb-2.5 flex flex-wrap items-center gap-2">
                              <span className="text-[11px] font-semibold uppercase tracking-wide text-zinc-500">
                                {mitad.nombre
                                  ? mitad.nombre
                                  : mitad.dificil
                                  ? t('endgame.hardMode')
                                  : (piso.mitades ?? []).length > 1
                                    ? t('endgame.half', { number: index + 1 })
                                    : t('endgame.battle')}
                              </span>
                              {(mitad.elementos ?? []).length > 0 && (
                                <>
                                  <span className="text-[11px] text-zinc-500">· {t('endgame.recommended')}</span>
                                  <Elementos lista={mitad.elementos} />
                                </>
                              )}
                            </div>

                            <div className="space-y-2">
                              {(mitad.oleadas ?? []).map((ola, n) => (
                                <div key={n} className="flex flex-wrap items-center gap-2">
                                  <span className="w-16 shrink-0 text-[11px] text-zinc-500">
                                    {t('endgame.wave', { number: n + 1 })}
                                  </span>
                                  {[...new Set(ola)].map((id) => {
                                    if (id.startsWith(SIN_FICHA)) {
                                      return (
                                        <span
                                          key={id}
                                          className="flex items-center gap-2 rounded-xl border border-white/10 bg-white/[0.03] py-1 pl-1 pr-3"
                                        >
                                          <span className="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-black/40">
                                            <Skull className="h-4 w-4 text-zinc-600" />
                                          </span>
                                          <span className="text-[13px] text-zinc-300">{id.slice(SIN_FICHA.length)}</span>
                                        </span>
                                      )
                                    }
                                    const enemigo = cargado.enemigos[id]
                                    if (!enemigo) return null
                                    const veces = ola.filter((x) => x === id).length
                                    return (
                                      <button
                                        key={id}
                                        type="button"
                                        onClick={() => navigate(`/game/${gameId}/enemies/${id}`)}
                                        className="flex items-center gap-2 rounded-xl border border-white/10 bg-white/[0.03] py-1 pl-1 pr-3 text-left transition hover:border-white/25 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/15"
                                      >
                                        <span className="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-black/40">
                                          {enemigo.image_url ? (
                                            <img src={enemigo.image_url} alt="" loading="lazy" className="h-full w-full object-contain" />
                                          ) : (
                                            <Skull className="h-4 w-4 text-zinc-600" />
                                          )}
                                        </span>
                                        <span className="text-[13px] text-zinc-200">
                                          {enemigo.name}
                                          {veces > 1 && <span className="ml-1 text-zinc-500">×{veces}</span>}
                                        </span>
                                      </button>
                                    )
                                  })}
                                </div>
                              ))}
                            </div>

                            {(mitad.efectos ?? []).length > 0 && (
                              <div className="mt-3">
                                <Efectos lista={mitad.efectos} t={t} />
                              </div>
                            )}
                          </div>
                        ))}
                      </div>
                    )}
                  </li>
                )
              })}
            </ul>

            {rotacion.status === 'reciente' && (
              <p className="mt-4 text-xs text-zinc-500">{t('endgame.recentHint')}</p>
            )}
          </section>
        )
      })}
    </>
  )
}

export default EndgameRotation

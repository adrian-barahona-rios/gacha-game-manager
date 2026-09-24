import { useEffect, useMemo, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, AlertTriangle, ArrowLeft, Check, Loader2, Search, Sparkles, X } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { getElementChip } from '../data/characterStyles'
import { roleByValue } from '../data/aniimoRoles'
import { matchupsOf } from '../data/aniimoTypes'
import { analizarEquipo, effectStyle } from '../data/aniimoTraits'
import ProfileButton from './ProfileButton'

const HUECOS = 4

const sinAcentos = (texto) =>
  (texto ?? '')
    .normalize('NFD')
    .replace(/\p{Diacritic}/gu, '')
    .toLowerCase()

// Barra de una de las tres partes de la nota.
function Barra({ label, value, max }) {
  return (
    <div className="flex items-center gap-3">
      <span className="w-32 shrink-0 text-[11px] uppercase tracking-wide text-zinc-500">{label}</span>
      <span className="h-1.5 min-w-0 flex-1 overflow-hidden rounded-full bg-white/10">
        <span className="block h-full rounded-full bg-white/70" style={{ width: `${(value / max) * 100}%` }} />
      </span>
      <span className="w-12 shrink-0 text-right text-xs font-medium text-white">
        {value}/{max}
      </span>
    </div>
  )
}

// Creador de equipos: eliges cuatro criaturas y te dice como queda el reparto
// de roles, que elementos amenaza y que rasgos se aprovechan entre si.
function TeamBuilder() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const { t, activeLanguage } = useI18n()
  const game = getGameById(gameId)

  const [criaturas, setCriaturas] = useState([])
  const [rasgos, setRasgos] = useState([])
  const [elegidas, setElegidas] = useState([])
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')
  const [termino, setTermino] = useState('')

  useEffect(() => {
    let active = true

    Promise.all([
      supabase.from('characters').select('id, name, image_url, element, role, signature').eq('game_id', gameId).order('name'),
      supabase.from('traits').select('*').eq('game_id', gameId),
    ]).then(([chars, traits]) => {
      if (!active) return
      const fallo = chars.error ?? traits.error
      if (fallo) {
        setError(t('builder.error.load', { message: fallo.message }))
      } else {
        setError('')
        setCriaturas(chars.data ?? [])
        setRasgos(traits.data ?? [])
      }
      setIsLoading(false)
    })

    return () => {
      active = false
    }
  }, [gameId, t])

  // El rasgo de una criatura: la tabla de rasgos guarda a quien lo lleva.
  const rasgoPorCriatura = useMemo(() => {
    const mapa = {}
    for (const rasgo of rasgos) for (const id of rasgo.creature_ids ?? []) mapa[id] = rasgo
    return mapa
  }, [rasgos])

  const miembros = elegidas.map((id) => criaturas.find((c) => c.id === id)).filter(Boolean)
  const analisis = useMemo(
    () => analizarEquipo(miembros, (c) => rasgoPorCriatura[c.id], matchupsOf),
    // eslint-disable-next-line react-hooks/exhaustive-deps
    [elegidas, rasgoPorCriatura, criaturas],
  )

  const alternar = (id) => {
    setElegidas((actual) => {
      if (actual.includes(id)) return actual.filter((x) => x !== id)
      if (actual.length >= HUECOS) return actual
      return [...actual, id]
    })
  }

  const aguja = sinAcentos(termino.trim())
  const visibles = criaturas.filter(
    (c) => !aguja || sinAcentos(c.name).includes(aguja) || sinAcentos(c.role).includes(aguja) || sinAcentos(c.element).includes(aguja),
  )

  const textoRasgo = (rasgo) => (activeLanguage === 'en' ? rasgo.description_en : rasgo.description_es) ?? rasgo.description_es
  const nombreRasgo = (rasgo) => (activeLanguage === 'en' ? rasgo.name_en : rasgo.name_es)

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
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">{t('builder.title')}</h1>
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

        <p className="mb-6 max-w-3xl text-sm leading-relaxed text-zinc-400">{t('builder.hint')}</p>

        {isLoading ? (
          <div className="flex items-center justify-center gap-2.5 py-20 text-zinc-500">
            <Loader2 className="h-5 w-5 animate-spin" />
            {t('common.loading')}
          </div>
        ) : (
          <div className="grid gap-6 lg:grid-cols-[1fr_22rem]">
            <div>
              {/* Los cuatro huecos */}
              <div className="mb-6 grid grid-cols-4 gap-2 sm:gap-3">
                {Array.from({ length: HUECOS }, (_, index) => {
                  const criatura = miembros[index]
                  const rol = criatura ? roleByValue(criatura.role) : null
                  const rasgo = criatura ? rasgoPorCriatura[criatura.id] : null

                  return (
                    <div
                      key={index}
                      className={`rounded-2xl border p-2.5 ${criatura ? 'border-white/15 bg-white/[0.04]' : 'border-dashed border-white/15 bg-white/[0.02]'}`}
                    >
                      {criatura ? (
                        <>
                          <div className="mb-1.5 flex items-start justify-between gap-1">
                            <span
                              className={`rounded-md px-1.5 py-0.5 text-[10px] font-semibold uppercase tracking-wide ring-1 ${rol?.chip ?? 'bg-white/5 text-zinc-300 ring-white/15'}`}
                            >
                              {criatura.role}
                            </span>
                            <button
                              type="button"
                              onClick={() => alternar(criatura.id)}
                              aria-label={t('builder.remove', { name: criatura.name })}
                              className="rounded-md p-0.5 text-zinc-500 transition hover:bg-white/10 hover:text-white focus:outline-none focus:ring-2 focus:ring-white/20"
                            >
                              <X className="h-3.5 w-3.5" />
                            </button>
                          </div>
                          <span className="mb-1 flex h-16 w-full items-center justify-center overflow-hidden rounded-lg bg-black/30">
                            {criatura.image_url ? (
                              <img src={criatura.image_url} alt="" loading="lazy" className="h-full w-full object-contain" />
                            ) : (
                              <span className="text-lg font-bold text-white/70">{criatura.name.charAt(0)}</span>
                            )}
                          </span>
                          <p className="text-center text-[11px] font-semibold leading-tight text-white">{criatura.name}</p>
                          {rasgo && (
                            <p className="mt-1 text-center text-[10px] leading-tight text-zinc-500">{nombreRasgo(rasgo)}</p>
                          )}
                        </>
                      ) : (
                        <p className="flex h-[7.5rem] items-center justify-center text-center text-[11px] text-zinc-600">
                          {t('builder.emptySlot', { number: index + 1 })}
                        </p>
                      )}
                    </div>
                  )
                })}
              </div>

              {/* Buscador y rejilla de criaturas */}
              <div className="relative mb-4">
                <input
                  value={termino}
                  onChange={(event) => setTermino(event.target.value)}
                  placeholder={t('builder.search')}
                  className="peer w-full rounded-xl border border-white/10 bg-white/[0.03] py-3 pl-11 pr-4 text-[15px] text-white placeholder:text-zinc-600 transition-all duration-300 hover:border-white/20 focus:border-white/30 focus:bg-white/[0.06] focus:outline-none focus:ring-4 focus:ring-white/5"
                />
                <Search className="pointer-events-none absolute left-3.5 top-1/2 h-[18px] w-[18px] -translate-y-1/2 text-zinc-500 transition-colors duration-300 peer-focus:text-white" />
              </div>

              <ul className="grid grid-cols-3 gap-2 sm:grid-cols-5 lg:grid-cols-6">
                {visibles.map((criatura) => {
                  const dentro = elegidas.includes(criatura.id)
                  const lleno = elegidas.length >= HUECOS && !dentro

                  return (
                    <li key={criatura.id}>
                      <button
                        type="button"
                        onClick={() => alternar(criatura.id)}
                        disabled={lleno}
                        aria-pressed={dentro}
                        className={`group flex w-full flex-col items-center gap-1 rounded-xl border p-2 transition focus:outline-none focus:ring-4 focus:ring-white/15 ${
                          dentro
                            ? 'border-white/40 bg-white/10'
                            : lleno
                              ? 'border-white/5 bg-white/[0.01] opacity-40'
                              : 'border-white/10 bg-white/[0.03] hover:-translate-y-0.5 hover:border-white/25 hover:bg-white/[0.07]'
                        }`}
                      >
                        <span className="relative flex aspect-square w-full items-center justify-center overflow-hidden rounded-lg bg-black/30">
                          {criatura.image_url ? (
                            <img src={criatura.image_url} alt="" loading="lazy" className="h-full w-full object-contain" />
                          ) : (
                            <span className="text-sm font-bold text-white/70">{criatura.name.charAt(0)}</span>
                          )}
                          {dentro && (
                            <span className="absolute right-1 top-1 rounded-full bg-white p-0.5 text-black">
                              <Check className="h-3 w-3" />
                            </span>
                          )}
                        </span>
                        <span className="line-clamp-2 text-center text-[11px] font-medium leading-tight text-zinc-200">
                          {criatura.name}
                        </span>
                        <span className="flex flex-wrap justify-center gap-1">
                          {criatura.element && (
                            <span className={`rounded-md bg-white/[0.03] px-1 py-0.5 text-[9px] font-medium ring-1 ${getElementChip(criatura.element)}`}>
                              {criatura.element}
                            </span>
                          )}
                        </span>
                      </button>
                    </li>
                  )
                })}
              </ul>
            </div>

            {/* Analisis */}
            <aside className="space-y-4 lg:sticky lg:top-24 lg:self-start">
              <section className="rounded-2xl border border-white/10 bg-white/[0.02] p-4">
                <div className="mb-3 flex items-baseline justify-between gap-3">
                  <h2 className="text-sm font-semibold text-white">{t('builder.score')}</h2>
                  <span className="text-2xl font-bold tracking-tight text-white">{analisis.score}</span>
                </div>
                <div className="space-y-2">
                  <Barra label={t('builder.roleBalance')} value={analisis.roleBalance} max={40} />
                  <Barra label={t('builder.elementCoverage')} value={analisis.elementCoverage} max={30} />
                  <Barra label={t('builder.traitSynergy')} value={analisis.traitSynergy} max={30} />
                </div>
                <p className="mt-3 text-[11px] leading-relaxed text-zinc-600">{t('builder.scoreHint')}</p>
              </section>

              {analisis.avisos.length > 0 && (
                <section className="rounded-2xl border border-white/10 bg-white/[0.02] p-4">
                  <h2 className="mb-2 text-sm font-semibold text-white">{t('builder.warnings')}</h2>
                  <ul className="space-y-2">
                    {analisis.avisos.map((aviso) => (
                      <li key={aviso.clave} className="flex gap-2 text-[13px] leading-relaxed">
                        <AlertTriangle
                          className={`mt-0.5 h-3.5 w-3.5 shrink-0 ${
                            aviso.nivel === 'alto' ? 'text-rose-400' : aviso.nivel === 'medio' ? 'text-amber-400' : 'text-zinc-500'
                          }`}
                        />
                        <span className="text-zinc-400">{t(`builder.warning.${aviso.clave}`)}</span>
                      </li>
                    ))}
                  </ul>
                </section>
              )}

              <section className="rounded-2xl border border-white/10 bg-white/[0.02] p-4">
                <h2 className="mb-2 text-sm font-semibold text-white">{t('builder.synergies')}</h2>
                {analisis.hallazgos.length === 0 ? (
                  <p className="text-[13px] leading-relaxed text-zinc-500">{t('builder.noSynergies')}</p>
                ) : (
                  <ul className="space-y-3">
                    {analisis.hallazgos.map((hallazgo, index) => (
                      <li key={`${hallazgo.criatura.id}-${index}`}>
                        <p className="mb-0.5 flex flex-wrap items-center gap-x-2 gap-y-1 text-[13px] font-medium text-white">
                          {hallazgo.criatura.name}
                          <span className={`rounded-md px-1.5 py-0.5 text-[10px] font-semibold uppercase tracking-wide ring-1 ${effectStyle(hallazgo.rasgo.effect_type)}`}>
                            {nombreRasgo(hallazgo.rasgo)}
                          </span>
                        </p>
                        <p className="text-[12px] leading-relaxed text-zinc-500">{textoRasgo(hallazgo.rasgo)}</p>
                        {hallazgo.tipo === 'familia' && (
                          <p className="mt-0.5 text-[12px] text-emerald-300/80">
                            {t('builder.familyMet', {
                              family: hallazgo.familia,
                              names: hallazgo.acompanantes.map((c) => c.name).join(', '),
                            })}
                          </p>
                        )}
                        {hallazgo.tipo === 'elemento' && (
                          <p className="mt-0.5 text-[12px] text-emerald-300/80">
                            {t('builder.elementMet', {
                              element: hallazgo.elemento,
                              names: hallazgo.acompanantes.map((c) => c.name).join(', '),
                            })}
                          </p>
                        )}
                        {hallazgo.tipo === 'familiaSinCumplir' && (
                          <p className="mt-0.5 text-[12px] text-amber-300/80">
                            {t('builder.familyMissing', { family: hallazgo.familia })}
                          </p>
                        )}
                      </li>
                    ))}
                  </ul>
                )}
              </section>

              <section className="rounded-2xl border border-white/10 bg-white/[0.02] p-4">
                <h2 className="mb-2 flex items-center gap-2 text-sm font-semibold text-white">
                  <Sparkles className="h-3.5 w-3.5 text-zinc-500" />
                  {t('builder.threatens')}
                </h2>
                {analisis.amenazados.length === 0 ? (
                  <p className="text-[13px] text-zinc-500">{t('builder.threatensNone')}</p>
                ) : (
                  <div className="flex flex-wrap gap-1.5">
                    {analisis.amenazados.map((elemento) => (
                      <span
                        key={elemento}
                        className={`rounded-md bg-white/[0.03] px-2 py-0.5 text-[11px] font-medium ring-1 ${getElementChip(elemento)}`}
                      >
                        {elemento}
                      </span>
                    ))}
                  </div>
                )}
                <p className="mt-2 text-[11px] leading-relaxed text-zinc-600">
                  {t('builder.threatensHint', { count: analisis.amenazados.length })}
                </p>
              </section>
            </aside>
          </div>
        )}
      </main>
    </div>
  )
}

export default TeamBuilder

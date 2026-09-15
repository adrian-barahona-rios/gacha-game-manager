import { useEffect, useState } from 'react'
import { useLocation, useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, Gem, Loader2, Search } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { RELIC_SECTIONS } from '../data/relics'
import ProfileButton from './ProfileButton'

const sinAcentos = (texto) =>
  texto
    .normalize('NFD')
    .replace(/\p{Diacritic}/gu, '')
    .toLowerCase()

// Primero los de mas rareza ("4-5★" > "3-4★"), y dentro, por nombre.
const rarezaMax = (rarity) => Number(String(rarity ?? '').match(/(\d)★/)?.[1] ?? 0)

// Conjuntos de reliquias y ornamentos de Honkai y de artefactos de Genshin.
// Como los discos de Zenless, todo lo importante (efectos y donde se
// consiguen) cabe en la tarjeta.
function RelicSetList() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const { hash } = useLocation()
  const { t } = useI18n()
  const game = getGameById(gameId)
  const section = RELIC_SECTIONS[gameId] ?? RELIC_SECTIONS['honkai-star-rail']

  const [sets, setSets] = useState([])
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')
  const [tab, setTab] = useState(section.tabs[0].id)
  const [term, setTerm] = useState('')

  useEffect(() => {
    let active = true

    supabase
      .from('relic_sets')
      .select('id, name, name_en, type, rarity, image_url, one_piece, two_piece, four_piece, how_to_get, pieces, version')
      .eq('game_id', gameId)
      .order('name', { ascending: true })
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(t('relics.error.load', { message: loadError.message }))
          setSets([])
        } else {
          setError('')
          setSets(data ?? [])
          // Desde una build se llega con #id del conjunto: se abre su pestana.
          const objetivo = (data ?? []).find((set) => `#${set.id}` === window.location.hash)
          if (objetivo) setTab(objetivo.type)
        }
        setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [gameId, t])

  // Y se baja hasta su tarjeta en cuanto esta pintada.
  const destino = hash.slice(1)
  const hayDestino = !isLoading && sets.some((set) => set.id === destino)
  useEffect(() => {
    if (hayDestino) document.getElementById(destino)?.scrollIntoView({ block: 'start' })
  }, [destino, hayDestino])

  // Tambien se busca en los efectos: "velocidad" o "crítico" encuentran los
  // conjuntos que lo mejoran.
  const needle = sinAcentos(term.trim())
  const deLaPestana = sets
    .filter((set) => set.type === tab)
    .sort((a, b) => rarezaMax(b.rarity) - rarezaMax(a.rarity))
  const visible = deLaPestana.filter((set) =>
    !needle
      ? true
      : [set.name, set.name_en, set.one_piece, set.two_piece, set.four_piece].some((texto) =>
          sinAcentos(texto ?? '').includes(needle),
        ),
  )
  const cuantos = (id) => sets.filter((set) => set.type === id).length

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
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">
              {t(section.titleKey)}
            </h1>
            <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>
              {game?.name ?? gameId}
            </p>
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

        <div role="tablist" className={`mb-6 flex gap-2 border-b border-white/10 ${section.tabs.length < 2 ? 'hidden' : ''}`}>
          {section.tabs.map((item) => {
            const isActive = tab === item.id
            return (
              <button
                key={item.id}
                type="button"
                role="tab"
                aria-selected={isActive}
                onClick={() => setTab(item.id)}
                className={`-mb-px border-b-2 px-4 py-2.5 text-sm font-medium transition-colors duration-200 focus:outline-none ${
                  isActive
                    ? 'border-white text-white'
                    : 'border-transparent text-zinc-500 hover:text-zinc-200'
                }`}
              >
                {t(item.labelKey)}
                {!isLoading && <span className="ml-2 text-xs text-zinc-500">{cuantos(item.id)}</span>}
              </button>
            )
          })}
        </div>

        <div className="mb-8 flex flex-wrap items-center gap-4">
          <div className="relative min-w-[15rem] flex-1">
            <input
              value={term}
              onChange={(event) => setTerm(event.target.value)}
              placeholder={t('relics.search')}
              className="peer w-full rounded-xl border border-white/10 bg-white/[0.03] py-3 pl-11 pr-4 text-[15px] text-white placeholder:text-zinc-600 transition-all duration-300 hover:border-white/20 focus:border-white/30 focus:bg-white/[0.06] focus:outline-none focus:ring-4 focus:ring-white/5"
            />
            <Search className="pointer-events-none absolute left-3.5 top-1/2 h-[18px] w-[18px] -translate-y-1/2 text-zinc-500 transition-colors duration-300 peer-focus:text-white" />
          </div>

          {!isLoading && (
            <span className="text-sm text-zinc-500">
              {t(visible.length === 1 ? 'weapons.count' : 'weapons.countPlural', {
                count: visible.length,
              })}
            </span>
          )}
        </div>

        {isLoading ? (
          <div className="flex items-center justify-center gap-2.5 py-20 text-zinc-500">
            <Loader2 className="h-5 w-5 animate-spin" />
            {t('common.loading')}
          </div>
        ) : visible.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
            <Gem className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
            <p className="text-zinc-400">
              {deLaPestana.length ? t('weapons.noMatches') : t('relics.empty')}
            </p>
          </div>
        ) : (
          <div className="grid gap-5 md:grid-cols-2">
            {visible.map((set) => (
              <article
                key={set.id}
                id={set.id}
                className="flex scroll-mt-24 flex-col rounded-2xl border border-white/10 bg-white/[0.03] p-5"
              >
                <div className="mb-4 flex items-center gap-4">
                  <span className="flex h-20 w-20 shrink-0 items-center justify-center rounded-xl bg-black/40 p-1.5">
                    {set.image_url ? (
                      <img
                        src={set.image_url}
                        alt={set.name}
                        loading="lazy"
                        className="h-full w-full object-contain"
                      />
                    ) : (
                      <Gem className="h-9 w-9 text-zinc-600" />
                    )}
                  </span>
                  <div className="min-w-0">
                    <h2 className="text-lg font-semibold leading-snug tracking-tight text-white">
                      {set.name}
                    </h2>
                    <p className="text-xs text-zinc-500">{set.name_en}</p>
                    {set.rarity && <p className="mt-1 text-xs text-amber-300/80">{set.rarity}</p>}
                    {set.version && (
                      <p className="mt-1 text-[11px] text-zinc-600">
                        {t('relics.version', { version: set.version })}
                      </p>
                    )}
                  </div>
                </div>

                <dl className="mb-4 space-y-3 text-[14px] leading-relaxed">
                  {set.one_piece && (
                    <div>
                      <dt className="mb-0.5 text-[11px] font-semibold uppercase tracking-wide text-[#7aa7ff]">
                        {t('relics.onePiece')}
                      </dt>
                      <dd className="text-zinc-200">{set.one_piece}</dd>
                    </div>
                  )}
                  {set.two_piece && (
                    <div>
                      <dt className="mb-0.5 text-[11px] font-semibold uppercase tracking-wide text-[#7aa7ff]">
                        {t('discs.twoPiece')}
                      </dt>
                      <dd className="text-zinc-200">{set.two_piece}</dd>
                    </div>
                  )}
                  {set.four_piece && (
                    <div>
                      <dt className="mb-0.5 text-[11px] font-semibold uppercase tracking-wide text-[#7aa7ff]">
                        {t('discs.fourPiece')}
                      </dt>
                      <dd className="text-zinc-300">{set.four_piece}</dd>
                    </div>
                  )}
                </dl>

                {Array.isArray(set.pieces) && set.pieces.length > 0 && (
                  <ul className="mb-4 flex flex-wrap gap-2">
                    {set.pieces.map((pieza) => (
                      <li
                        key={pieza.pieza}
                        title={`${pieza.pieza}: ${pieza.nombre}`}
                        className="flex items-center gap-2 rounded-lg border border-white/10 bg-black/20 py-1 pl-1 pr-2.5"
                      >
                        <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-md bg-white/5">
                          {pieza.icono && <img src={pieza.icono} alt="" loading="lazy" className="h-full w-full object-contain" />}
                        </span>
                        <span className="text-[11px] leading-tight">
                          <span className="block text-zinc-500">{pieza.pieza}</span>
                          <span className="block text-zinc-300">{pieza.nombre}</span>
                        </span>
                      </li>
                    ))}
                  </ul>
                )}

                {set.how_to_get && (
                  <div className="mt-auto border-t border-white/10 pt-3">
                    <p className="mb-1 text-[11px] font-semibold uppercase tracking-wide text-zinc-500">
                      {t('discs.howToGet')}
                    </p>
                    <ul className="space-y-1">
                      {set.how_to_get.split(' · ').map((linea) => (
                        <li key={linea} className="flex gap-2 text-[13px] text-zinc-400">
                          <span className="mt-[7px] h-1 w-1 shrink-0 rounded-full bg-zinc-500" />
                          {linea}
                        </li>
                      ))}
                    </ul>
                  </div>
                )}
              </article>
            ))}
          </div>
        )}
      </main>
    </div>
  )
}

export default RelicSetList

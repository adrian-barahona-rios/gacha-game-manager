import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, Loader2, Search, Skull } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { getElementChip } from '../data/characterStyles'
import { ENEMY_SECTIONS, HIGH_RESISTANCE, RANK_STYLES } from '../data/enemies'
import ProfileButton from './ProfileButton'

const sinAcentos = (texto) =>
  texto
    .normalize('NFD')
    .replace(/\p{Diacritic}/gu, '')
    .toLowerCase()

const TAB_LABELS = {
  jefe: 'enemies.tab.bosses',
  esbirro: 'enemies.tab.minions',
  fauna: 'enemies.tab.fauna',
}

// Elementos que un enemigo resiste mucho (o a los que es inmune).
const resistenciasAltas = (enemy) =>
  (Array.isArray(enemy.resistances) ? enemy.resistances : []).filter(
    (r) => r.inmune || r.valor >= HIGH_RESISTANCE,
  )

function EnemyList() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const { t } = useI18n()
  const game = getGameById(gameId)
  const section = ENEMY_SECTIONS[gameId] ?? ENEMY_SECTIONS['honkai-star-rail']

  const [enemies, setEnemies] = useState([])
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')
  const [tab, setTab] = useState('jefe')
  const [term, setTerm] = useState('')
  // Elemento del filtro (debil a / sin resistencia alta a); vacio = todos.
  const [elementFilter, setElementFilter] = useState('')

  useEffect(() => {
    let active = true

    supabase
      .from('enemies')
      .select('id, name, name_en, category, rank, faction, classification, image_url, weaknesses, resistances, variants')
      .eq('game_id', gameId)
      .order('name', { ascending: true })
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(t('enemies.error.load', { message: loadError.message }))
          setEnemies([])
        } else {
          setError('')
          setEnemies(data ?? [])
        }
        setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [gameId, t])

  // Un enemigo cuenta como debil a un elemento si lo es en cualquiera de sus
  // versiones, que es lo que interesa al buscar a quien llevar.
  const debilidadesDe = (enemy) => {
    const variantes = Array.isArray(enemy.variants) ? enemy.variants : []
    return new Set([...(enemy.weaknesses ?? []), ...variantes.flatMap((v) => v.debilidades ?? [])])
  }

  // En Genshin: que no resista mucho a ese elemento ni sea inmune.
  const pasaFiltro = (enemy) => {
    if (!elementFilter) return true
    if (section.filter === 'weakTo') return debilidadesDe(enemy).has(elementFilter)
    return !resistenciasAltas(enemy).some((r) => r.elemento === elementFilter)
  }

  const needle = sinAcentos(term.trim())
  const deLaPestana = enemies.filter((enemy) => enemy.category === tab)
  const visible = deLaPestana.filter(
    (enemy) =>
      pasaFiltro(enemy) &&
      (!needle ||
        [enemy.name, enemy.name_en, enemy.faction, enemy.classification].some((texto) =>
          sinAcentos(texto ?? '').includes(needle),
        )),
  )
  const cuantos = (id) => enemies.filter((enemy) => enemy.category === id).length

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
              {t('enemies.title')}
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

        <div role="tablist" className="mb-6 flex gap-2 border-b border-white/10">
          {section.tabs.map((id) => ({ id, labelKey: TAB_LABELS[id] })).map((item) => {
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

        <div className="mb-4 flex flex-wrap items-center gap-4">
          <div className="relative min-w-[15rem] flex-1">
            <input
              value={term}
              onChange={(event) => setTerm(event.target.value)}
              placeholder={t('enemies.search')}
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

        <div className="mb-8 flex flex-wrap items-center gap-2">
          <span className="mr-1 text-xs font-semibold uppercase tracking-wide text-zinc-500">
            {t(section.filter === 'weakTo' ? 'enemies.weakTo' : 'enemies.notResistant')}
          </span>
          {['', ...section.elements].map((elemento) => {
            const isActive = elementFilter === elemento
            return (
              <button
                key={elemento || 'todos'}
                type="button"
                onClick={() => setElementFilter(elemento)}
                aria-pressed={isActive}
                className={`rounded-full px-3 py-1 text-xs font-medium ring-1 transition-all duration-200 focus:outline-none ${
                  isActive
                    ? 'bg-white text-black ring-white'
                    : `bg-white/[0.03] hover:bg-white/10 ${elemento ? getElementChip(elemento) : 'text-zinc-300 ring-white/15'}`
                }`}
              >
                {elemento || t('enemies.all')}
              </button>
            )
          })}
        </div>

        {isLoading ? (
          <div className="flex items-center justify-center gap-2.5 py-20 text-zinc-500">
            <Loader2 className="h-5 w-5 animate-spin" />
            {t('common.loading')}
          </div>
        ) : visible.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
            <Skull className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
            <p className="text-zinc-400">
              {deLaPestana.length ? t('weapons.noMatches') : t('enemies.empty')}
            </p>
          </div>
        ) : (
          <ul className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5">
            {visible.map((enemy) => (
              <li key={enemy.id}>
                <button
                  type="button"
                  onClick={() => navigate(`/game/${gameId}/enemies/${enemy.id}`)}
                  className="group flex h-full w-full flex-col overflow-hidden rounded-2xl border border-white/10 bg-white/[0.03] text-left transition-all duration-300 hover:-translate-y-0.5 hover:border-white/25 hover:bg-white/[0.06] focus:outline-none focus:ring-4 focus:ring-white/15"
                >
                  <span className="flex aspect-square w-full items-center justify-center bg-gradient-to-b from-white/[0.06] to-transparent p-3">
                    {enemy.image_url ? (
                      <img
                        src={enemy.image_url}
                        alt={enemy.name}
                        loading="lazy"
                        className="h-full w-full object-contain transition-transform duration-300 group-hover:scale-105"
                      />
                    ) : (
                      <Skull className="h-10 w-10 text-zinc-600" />
                    )}
                  </span>
                  <span className="flex flex-1 flex-col gap-2 p-3.5">
                    <span className="line-clamp-2 text-sm font-semibold leading-snug text-white">
                      {enemy.name}
                    </span>
                    {enemy.rank === 'elite' && (
                      <span
                        className={`self-start rounded-full px-2 py-0.5 text-[10px] font-semibold uppercase tracking-wide ring-1 ${RANK_STYLES.elite}`}
                      >
                        {t('enemies.rank.elite')}
                      </span>
                    )}
                    {(enemy.weaknesses ?? []).length > 0 && (
                      <span className="flex flex-wrap gap-1">
                        {enemy.weaknesses.map((elemento) => (
                          <span
                            key={elemento}
                            className={`rounded-md bg-white/[0.03] px-1.5 py-0.5 text-[10px] font-medium ring-1 ${getElementChip(elemento)}`}
                          >
                            {elemento}
                          </span>
                        ))}
                      </span>
                    )}
                    {/* Zenless: resistencias sin porcentaje, solo el elemento. */}
                    {section.filter === 'weakTo' &&
                      (enemy.resistances ?? []).some((r) => r.valor == null) && (
                        <span className="mt-auto flex flex-wrap items-center gap-1">
                          <span className="text-[10px] text-zinc-500">{t('enemies.resists')}</span>
                          {enemy.resistances.map((r) => (
                            <span
                              key={r.elemento}
                              className={`rounded-md bg-white/[0.03] px-1.5 py-0.5 text-[10px] font-medium ring-1 ${getElementChip(r.elemento)}`}
                            >
                              {r.elemento}
                            </span>
                          ))}
                        </span>
                      )}
                    {section.filter === 'notResistant' && resistenciasAltas(enemy).length > 0 && (
                      <span className="mt-auto flex flex-wrap items-center gap-1">
                        <span className="text-[10px] text-zinc-500">{t('enemies.resists')}</span>
                        {resistenciasAltas(enemy).length === 8 ? (
                          <span className="rounded-md bg-white/5 px-1.5 py-0.5 text-[10px] font-medium text-zinc-300 ring-1 ring-white/15">
                            {t('enemies.immuneAll')}
                          </span>
                        ) : (
                          resistenciasAltas(enemy).map((r) => (
                            <span
                              key={r.elemento}
                              className={`rounded-md bg-white/[0.03] px-1.5 py-0.5 text-[10px] font-medium ring-1 ${getElementChip(r.elemento)}`}
                            >
                              {r.elemento} {r.inmune ? '∞' : `${r.valor}%`}
                            </span>
                          ))
                        )}
                      </span>
                    )}
                  </span>
                </button>
              </li>
            ))}
          </ul>
        )}
      </main>
    </div>
  )
}

export default EnemyList

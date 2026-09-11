import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, Loader2, Search, Swords } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { WEAPON_SECTIONS, getCategoryStyle, rarityLabel, rarityRank } from '../data/weapons'
import ProfileButton from './ProfileButton'

const RARITY_STYLES = {
  5: 'border-amber-500/50 bg-amber-950 text-amber-200',
  4: 'border-purple-500/50 bg-purple-950 text-purple-200',
  3: 'border-sky-500/50 bg-sky-950 text-sky-200',
  2: 'border-emerald-500/50 bg-emerald-950 text-emerald-200',
  1: 'border-zinc-500/50 bg-zinc-900 text-zinc-300',
}

const sinAcentos = (texto) =>
  texto
    .normalize('NFD')
    .replace(/\p{Diacritic}/gu, '')
    .toLowerCase()

// Lista de armas o conos de luz de un juego: se filtra por categoria con un
// desplegable y por nombre con el buscador, igual que en personajes.
function WeaponList() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const { t } = useI18n()
  const game = getGameById(gameId)
  const seccion = WEAPON_SECTIONS[gameId]

  const [weapons, setWeapons] = useState([])
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')
  const [category, setCategory] = useState('todas')
  const [term, setTerm] = useState('')

  useEffect(() => {
    let active = true

    supabase
      .from('weapons')
      .select('id, name, name_en, rarity, category, image_url, base_atk')
      .eq('game_id', gameId)
      .order('rarity', { ascending: false })
      .order('name', { ascending: true })
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(t('weapons.error.load', { message: loadError.message }))
          setWeapons([])
        } else {
          setError('')
          // Se ordena aqui y no en la consulta: la rareza de Zenless es una letra
          // y ordenada como texto quedaria S, B, A.
          setWeapons(
            [...(data ?? [])].sort(
              (a, b) => rarityRank(b.rarity) - rarityRank(a.rarity) || a.name.localeCompare(b.name),
            ),
          )
        }
        setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [gameId, t])

  // Las categorias salen de los propios datos, asi no hay que mantener una
  // lista aparte cuando el juego saca una via o un tipo de arma nuevo.
  const categories = [...new Set(weapons.map((w) => w.category).filter(Boolean))].sort((a, b) =>
    a.localeCompare(b),
  )

  const needle = sinAcentos(term.trim())
  const visible = weapons.filter((w) => {
    if (category !== 'todas' && w.category !== category) {
      return false
    }
    if (!needle) {
      return true
    }
    return (
      sinAcentos(w.name).includes(needle) || sinAcentos(w.name_en ?? '').includes(needle)
    )
  })

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
              {t(seccion?.titleKey ?? 'weapons.title')}
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

        <div className="mb-8 flex flex-wrap items-center gap-4">
          <div className="flex items-center gap-2.5">
            <label htmlFor="categoria" className="text-sm text-zinc-400">
              {t(seccion?.categoryKey ?? 'weapons.category')}
            </label>
            <select
              id="categoria"
              value={category}
              onChange={(event) => setCategory(event.target.value)}
              className="rounded-xl border border-white/10 bg-white/[0.03] px-4 py-3 text-sm text-white transition-all duration-300 hover:border-white/20 focus:border-white/30 focus:outline-none focus:ring-4 focus:ring-white/5"
            >
              <option value="todas" className="bg-[#111114]">
                {t('weapons.allCategories')}
              </option>
              {categories.map((option) => (
                <option key={option} value={option} className="bg-[#111114]">
                  {option}
                </option>
              ))}
            </select>
          </div>

          <div className="relative min-w-[15rem] flex-1">
            <input
              value={term}
              onChange={(event) => setTerm(event.target.value)}
              placeholder={t('weapons.search')}
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
            <Swords className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
            <p className="text-zinc-400">
              {needle || category !== 'todas' ? t('weapons.noMatches') : t('weapons.empty')}
            </p>
          </div>
        ) : (
          <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5">
            {visible.map((weapon) => (
              <button
                key={weapon.id}
                type="button"
                onClick={() => navigate(`/game/${gameId}/weapons/${weapon.id}`)}
                className={`group overflow-hidden rounded-2xl border text-left transition-all duration-300 hover:-translate-y-1 hover:shadow-[0_0_30px_rgba(255,255,255,0.08)] focus:outline-none focus:ring-4 focus:ring-white/20 ${RARITY_STYLES[rarityRank(weapon.rarity)] ?? RARITY_STYLES[1]}`}
              >
                <span className="flex h-32 w-full items-center justify-center bg-black/40 p-2">
                  {weapon.image_url ? (
                    <img
                      src={weapon.image_url}
                      alt={weapon.name}
                      loading="lazy"
                      className="h-full w-auto max-w-full object-contain transition-transform duration-300 group-hover:scale-110"
                    />
                  ) : (
                    <Swords className="h-10 w-10 text-zinc-600" />
                  )}
                </span>

                <span className="block px-3 py-3">
                  <span className="mb-1.5 block truncate text-sm font-semibold text-white" title={weapon.name}>
                    {weapon.name}
                  </span>
                  <span className="flex flex-wrap items-center gap-1.5 text-[11px]">
                    <span className="font-semibold">{rarityLabel(weapon.rarity)}</span>
                    {weapon.category && (
                      <span
                        className={`rounded-full px-2 py-0.5 font-medium ring-1 ${getCategoryStyle(weapon.category)}`}
                      >
                        {weapon.category}
                      </span>
                    )}
                  </span>
                </span>
              </button>
            ))}
          </div>
        )}
      </main>
    </div>
  )
}

export default WeaponList

import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, Bot, Loader2, Search } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { getRarityStyle } from '../data/characterStyles'
import { BANGBOO_GRADES } from '../data/bangboos'
import ProfileButton from './ProfileButton'

const sinAcentos = (texto) =>
  texto
    .normalize('NFD')
    .replace(/\p{Diacritic}/gu, '')
    .toLowerCase()

// Bangbus de Zenless: rejilla con filtro por grado y busqueda por nombre,
// afiliacion o texto de sus habilidades.
function BangbooList() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const { t } = useI18n()
  const game = getGameById(gameId)

  const [bangboos, setBangboos] = useState([])
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')
  const [term, setTerm] = useState('')
  const [grade, setGrade] = useState('')

  useEffect(() => {
    let active = true

    supabase
      .from('bangboos')
      .select('id, name, name_en, rarity, faction, faction_icon, icon_url, image_url, skills')
      .eq('game_id', gameId)
      .order('name', { ascending: true })
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(t('bangboos.error.load', { message: loadError.message }))
          setBangboos([])
        } else {
          setError('')
          setBangboos(data ?? [])
        }
        setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [gameId, t])

  const needle = sinAcentos(term.trim())
  const visible = bangboos
    .filter((b) => !grade || b.rarity === grade)
    .filter(
      (b) =>
        !needle ||
        [b.name, b.name_en, b.faction, ...(b.skills ?? []).flatMap((s) => [s.nombre, s.descripcion])].some((texto) =>
          sinAcentos(texto ?? '').includes(needle),
        ),
    )
    .sort((a, b) => BANGBOO_GRADES.indexOf(a.rarity) - BANGBOO_GRADES.indexOf(b.rarity))

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
              {t('bangboos.title')}
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

        <div className="mb-4 flex flex-wrap items-center gap-4">
          <div className="relative min-w-[15rem] flex-1">
            <input
              value={term}
              onChange={(event) => setTerm(event.target.value)}
              placeholder={t('bangboos.search')}
              className="peer w-full rounded-xl border border-white/10 bg-white/[0.03] py-3 pl-11 pr-4 text-[15px] text-white placeholder:text-zinc-600 transition-all duration-300 hover:border-white/20 focus:border-white/30 focus:bg-white/[0.06] focus:outline-none focus:ring-4 focus:ring-white/5"
            />
            <Search className="pointer-events-none absolute left-3.5 top-1/2 h-[18px] w-[18px] -translate-y-1/2 text-zinc-500 transition-colors duration-300 peer-focus:text-white" />
          </div>

          {!isLoading && (
            <span className="text-sm text-zinc-500">
              {t(visible.length === 1 ? 'weapons.count' : 'weapons.countPlural', { count: visible.length })}
            </span>
          )}
        </div>

        <div className="mb-8 flex flex-wrap items-center gap-2">
          <span className="mr-1 text-xs font-semibold uppercase tracking-wide text-zinc-500">{t('bangboos.grade')}</span>
          {['', ...BANGBOO_GRADES].map((item) => (
            <button
              key={item || 'todos'}
              type="button"
              aria-pressed={grade === item}
              onClick={() => setGrade(item)}
              className={`rounded-full px-3 py-1 text-xs font-medium ring-1 transition-all duration-200 focus:outline-none ${
                grade === item ? 'bg-white text-black ring-white' : `bg-white/[0.03] hover:bg-white/10 ${item ? getRarityStyle(item) : 'text-zinc-300 ring-white/15'}`
              }`}
            >
              {item || t('enemies.all')}
            </button>
          ))}
        </div>

        {isLoading ? (
          <div className="flex items-center justify-center gap-2.5 py-20 text-zinc-500">
            <Loader2 className="h-5 w-5 animate-spin" />
            {t('common.loading')}
          </div>
        ) : visible.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
            <Bot className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
            <p className="text-zinc-400">{bangboos.length ? t('weapons.noMatches') : t('bangboos.empty')}</p>
          </div>
        ) : (
          <ul className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-6">
            {visible.map((b) => (
              <li key={b.id}>
                <button
                  type="button"
                  onClick={() => navigate(`/game/${gameId}/bangboos/${b.id}`)}
                  className="group flex h-full w-full flex-col overflow-hidden rounded-2xl border border-white/10 bg-white/[0.03] text-left transition-all duration-300 hover:-translate-y-0.5 hover:border-white/25 hover:bg-white/[0.06] focus:outline-none focus:ring-4 focus:ring-white/15"
                >
                  <span className="relative flex h-40 w-full items-center justify-center overflow-hidden bg-gradient-to-b from-white/[0.06] to-transparent p-3">
                    {b.icon_url || b.image_url ? (
                      <img
                        src={b.icon_url ?? b.image_url}
                        alt={b.name}
                        loading="lazy"
                        className="h-full w-full object-contain transition-transform duration-300 group-hover:scale-105"
                      />
                    ) : (
                      <Bot className="h-10 w-10 text-zinc-600" />
                    )}
                    {b.rarity && (
                      <span className={`absolute left-2 top-2 rounded-md px-1.5 py-0.5 text-[11px] font-bold ring-1 ${getRarityStyle(b.rarity)}`}>
                        {b.rarity}
                      </span>
                    )}
                  </span>
                  <span className="flex flex-1 flex-col gap-1 p-3.5">
                    <span className="line-clamp-2 text-sm font-semibold leading-snug text-white">{b.name}</span>
                    {b.faction && (
                      <span className="flex items-center gap-1.5 text-[11px] text-zinc-500">
                        {b.faction_icon && <img src={b.faction_icon} alt="" loading="lazy" className="h-4 w-4 object-contain" />}
                        <span className="line-clamp-1">{b.faction}</span>
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

export default BangbooList

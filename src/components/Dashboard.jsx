import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  AlertCircle,
  Check,
  Gamepad2,
  Info,
  Loader2,
  Plus,
  Trash2,
  Users,
  X,
} from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { GAME_CATALOG, getGameCopy } from '../data/games'
import GameArtwork from './GameArtwork'
import ProfileButton from './ProfileButton'

const PARTICLES = [
  'left-[8%] top-[18%] [animation-duration:5s] [animation-delay:0s]',
  'left-[22%] top-[62%] [animation-duration:7s] [animation-delay:1.2s]',
  'left-[34%] top-[30%] [animation-duration:6s] [animation-delay:2.4s]',
  'left-[47%] top-[78%] [animation-duration:8s] [animation-delay:0.6s]',
  'left-[58%] top-[22%] [animation-duration:5.5s] [animation-delay:3s]',
  'left-[69%] top-[55%] [animation-duration:7.5s] [animation-delay:1.8s]',
  'left-[78%] top-[35%] [animation-duration:6.5s] [animation-delay:2.2s]',
  'left-[88%] top-[70%] [animation-duration:9s] [animation-delay:0.9s]',
  'left-[15%] top-[85%] [animation-duration:6.2s] [animation-delay:3.6s]',
  'left-[92%] top-[14%] [animation-duration:7.8s] [animation-delay:1.5s]',
]

const CARD_DELAYS = ['delay-0', 'delay-100', 'delay-200', 'delay-300']

function AnimatedBackground() {
  return (
    <div className="pointer-events-none fixed inset-0 overflow-hidden" aria-hidden="true">
      <div className="absolute inset-0 bg-[linear-gradient(to_right,rgba(255,255,255,0.035)_1px,transparent_1px),linear-gradient(to_bottom,rgba(255,255,255,0.035)_1px,transparent_1px)] bg-[size:64px_64px] [mask-image:radial-gradient(ellipse_at_center,black_10%,transparent_70%)]" />

      <div className="absolute left-1/2 top-1/2 h-[70rem] w-[70rem] -translate-x-1/2 -translate-y-1/2 animate-spin rounded-full bg-[conic-gradient(from_0deg,transparent_0deg,rgba(0,102,255,0.10)_90deg,transparent_180deg,rgba(147,51,234,0.10)_270deg,transparent_360deg)] [animation-duration:70s]" />

      <div className="absolute -top-40 left-[12%] h-[30rem] w-[30rem] animate-pulse rounded-full bg-blue-600/15 blur-[130px] [animation-duration:9s]" />
      <div className="absolute -bottom-48 right-[8%] h-[28rem] w-[28rem] animate-pulse rounded-full bg-purple-600/12 blur-[130px] [animation-duration:11s] [animation-delay:2s]" />
      <div className="absolute bottom-[20%] left-[-6rem] h-[22rem] w-[22rem] animate-pulse rounded-full bg-cyan-500/10 blur-[120px] [animation-duration:13s] [animation-delay:4s]" />

      {PARTICLES.map((particle) => (
        <span
          key={particle}
          className={`absolute h-1 w-1 animate-pulse rounded-full bg-white/50 ${particle}`}
        />
      ))}
    </div>
  )
}

function GameCard({ game, delayClass, isRemoving, onOpen, onDelete }) {
  const { t } = useI18n()
  const [shown, setShown] = useState(false)

  useEffect(() => {
    const frame = requestAnimationFrame(() => setShown(true))
    return () => cancelAnimationFrame(frame)
  }, [])

  const visible = shown && !isRemoving

  return (
    <article
      className={`group rounded-2xl border border-white/10 bg-[#1a1a1a] p-5 transition-all duration-500 ease-out hover:-translate-y-1 hover:scale-[1.02] hover:border-blue-500/40 hover:shadow-[0_0_40px_rgba(0,102,255,0.15)] ${delayClass} ${
        visible
          ? 'translate-y-0 scale-100 opacity-100'
          : 'translate-y-6 scale-95 opacity-0'
      }`}
    >
      <div className="mb-5 h-36 overflow-hidden rounded-xl ring-1 ring-white/10">
        <GameArtwork
          game={game}
          fill
          className="transition-transform duration-500 group-hover:scale-105"
        />
      </div>

      <h3 className="mb-5 truncate text-lg font-semibold text-white" title={game.name}>
        {game.name}
      </h3>

      <div className="flex gap-3">
        <button
          type="button"
          onClick={() => onOpen(game)}
          className="flex flex-1 items-center justify-center gap-2 rounded-lg bg-white px-3 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:bg-purple-600 hover:text-white hover:shadow-[0_0_25px_rgba(147,51,234,0.6)] focus:outline-none focus:ring-4 focus:ring-purple-500/30 active:scale-95 active:bg-[#0066ff] active:shadow-[0_0_25px_rgba(0,102,255,0.7)]"
        >
          <Info className="h-4 w-4" />
          {t('dashboard.info')}
        </button>

        <button
          type="button"
          onClick={() => onDelete(game)}
          disabled={isRemoving}
          aria-label={t('dashboard.remove', { game: game.name })}
          className="flex items-center justify-center rounded-lg bg-white px-3 py-2.5 text-black transition-all duration-300 hover:bg-red-600 hover:text-white hover:shadow-[0_0_25px_rgba(220,38,38,0.6)] focus:outline-none focus:ring-4 focus:ring-red-500/30 active:scale-95 active:bg-[#0066ff] active:shadow-[0_0_25px_rgba(0,102,255,0.7)] disabled:opacity-50"
        >
          {isRemoving ? (
            <Loader2 className="h-4 w-4 animate-spin" />
          ) : (
            <Trash2 className="h-4 w-4" />
          )}
        </button>
      </div>
    </article>
  )
}

function Dashboard() {
  const navigate = useNavigate()
  const [user, setUser] = useState(null)
  const [games, setGames] = useState([])
  const [isLoading, setIsLoading] = useState(true)
  const [isAdding, setIsAdding] = useState(false)
  const [pendingId, setPendingId] = useState(null)
  const [removingIds, setRemovingIds] = useState([])
  const { t, activeLanguage } = useI18n()
  const [error, setError] = useState('')

  useEffect(() => {
    let active = true

    supabase.auth.getSession().then(({ data }) => {
      if (!active) {
        return
      }
      if (!data.session) {
        navigate('/login', { replace: true })
        return
      }
      setUser(data.session.user)
    })

    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((_event, session) => {
      if (!session) {
        navigate('/login', { replace: true })
        return
      }
      setUser(session.user)
    })

    return () => {
      active = false
      subscription.unsubscribe()
    }
  }, [navigate])

  const userId = user?.id

  useEffect(() => {
    if (!userId) {
      return
    }

    let active = true

    supabase
      .from('user_games')
      .select('game_id, game_name')
      .eq('user_id', userId)
      .order('added_date', { ascending: true })
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }

        if (loadError) {
          setError(t('dashboard.error.load', { message: loadError.message }))
        } else {
          setGames(
            data.map((row) => {
              const fromCatalog = GAME_CATALOG.find(
                (item) => item.id === row.game_id,
              )
              return { ...fromCatalog, id: row.game_id, name: row.game_name }
            }),
          )
          setError('')
        }

        setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [userId, t])

  const handleAdd = async (game) => {
    if (!userId || games.some((item) => item.id === game.id)) {
      return
    }

    setPendingId(game.id)

    const { error: addError } = await supabase.from('user_games').insert({
      user_id: userId,
      game_id: game.id,
      game_name: game.name,
    })

    setPendingId(null)

    if (addError) {
      setError(t('dashboard.error.add', { message: addError.message }))
      return
    }

    setGames((current) => [...current, game])
    setError('')
    setIsAdding(false)
  }

  const handleDelete = async (game) => {
    if (!userId) {
      return
    }

    setRemovingIds((current) => [...current, game.id])

    const { error: deleteError } = await supabase
      .from('user_games')
      .delete()
      .eq('user_id', userId)
      .eq('game_id', game.id)

    if (deleteError) {
      setError(t('dashboard.error.remove', { message: deleteError.message }))
    } else {
      await new Promise((resolve) => setTimeout(resolve, 320))
      setGames((current) => current.filter((item) => item.id !== game.id))
      setError('')
    }

    setRemovingIds((current) => current.filter((id) => id !== game.id))
  }

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <AnimatedBackground />

      <header className="sticky top-0 z-20 border-b-2 border-blue-600/70 bg-[#0a0a0a]/90 backdrop-blur-xl">
        <div className="mx-auto flex max-w-7xl items-center justify-between gap-4 px-4 py-4 sm:px-6">
          <div className="flex min-w-0 items-center gap-2.5">
            <div className="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-gradient-to-b from-white/15 to-white/[0.03] ring-1 ring-white/10">
              <Gamepad2 className="h-5 w-5 text-white" />
            </div>
            <span className="truncate text-lg font-semibold tracking-tight text-white">
              {t('common.appName')}
            </span>
          </div>

          <div className="flex shrink-0 items-center gap-2">
          <button
            type="button"
            onClick={() => navigate('/profile/friends')}
            title={t('dashboard.friendsMenu')}
            aria-label={t('dashboard.friendsMenu')}
            className="flex h-11 w-11 items-center justify-center rounded-full border border-white/10 bg-white/5 text-zinc-300 transition-all duration-300 hover:border-[#0066ff] hover:bg-[#0066ff]/15 hover:text-white hover:shadow-[0_0_20px_rgba(0,102,255,0.3)] focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:scale-95"
          >
            <Users className="h-4 w-4" />
          </button>

          <ProfileButton />
          </div>
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-7xl px-4 py-10 sm:px-6 sm:py-14">
        <div className="mb-8 flex items-baseline gap-3">
          <h1 className="text-2xl font-semibold tracking-tight text-white sm:text-3xl">
            {t('dashboard.title')}
          </h1>
          {!isLoading && (
            <span className="text-sm text-zinc-500">
              {t(games.length === 1 ? 'dashboard.gameCount' : 'dashboard.gameCountPlural', {
                count: games.length,
              })}
            </span>
          )}
        </div>

        {error && (
          <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
            <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{error}</p>
          </div>
        )}

        {isLoading ? (
          <div className="grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3">
            {[0, 1, 2].map((slot) => (
              <div
                key={slot}
                className="animate-pulse rounded-2xl border border-white/10 bg-[#1a1a1a] p-5"
              >
                <div className="mb-5 h-36 rounded-xl bg-white/5" />
                <div className="mb-5 h-5 w-2/3 rounded bg-white/5" />
                <div className="h-10 rounded-lg bg-white/5" />
              </div>
            ))}
          </div>
        ) : games.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
            <Gamepad2 className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
            <p className="text-zinc-400">
              {t('dashboard.empty')}
            </p>
          </div>
        ) : (
          <div className="grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3">
            {games.map((game, index) => (
              <GameCard
                key={game.id}
                game={game}
                delayClass={CARD_DELAYS[index % CARD_DELAYS.length]}
                isRemoving={removingIds.includes(game.id)}
                onOpen={(target) =>
                  navigate(`/game/${encodeURIComponent(target.id)}`)
                }
                onDelete={handleDelete}
              />
            ))}
          </div>
        )}

        {!isLoading && (
          <button
            type="button"
            onClick={() => setIsAdding(true)}
            className="group mt-8 flex w-full items-center justify-center gap-3 rounded-2xl border border-dashed border-white/20 bg-transparent py-8 text-sm font-semibold text-zinc-400 transition-all duration-300 hover:border-[#0066ff] hover:bg-[#0066ff]/10 hover:text-white hover:shadow-[0_0_35px_rgba(0,102,255,0.25)] focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:scale-[0.99] active:border-[#0066ff] active:bg-[#0066ff]/25 active:text-white"
          >
            <Plus className="h-5 w-5 transition-transform duration-300 group-hover:rotate-90" />
            {t('dashboard.addGame')}
          </button>
        )}
      </main>

      {isAdding && (
        <div className="fixed inset-0 z-30 flex items-center justify-center bg-black/70 px-4 py-10 backdrop-blur-sm">
          <div className="max-h-full w-full max-w-4xl overflow-y-auto rounded-3xl border border-white/10 bg-[#111114] p-6 shadow-2xl shadow-black/80 sm:p-8">
            <div className="mb-7 flex items-start justify-between gap-4">
              <div>
                <h2 className="text-xl font-semibold tracking-tight text-white sm:text-2xl">
                  {t('dashboard.addGame')}
                </h2>
                <p className="mt-1.5 text-sm text-zinc-500">
                  {t('dashboard.libraryCount', {
                    count: games.length,
                    total: GAME_CATALOG.length,
                  })}
                </p>
              </div>
              <button
                type="button"
                onClick={() => setIsAdding(false)}
                aria-label={t('common.close')}
                className="shrink-0 rounded-lg p-2 text-zinc-400 transition-colors duration-300 hover:bg-white/10 hover:text-white focus:outline-none focus:ring-2 focus:ring-white/30"
              >
                <X className="h-5 w-5" />
              </button>
            </div>

            <ul className="grid grid-cols-1 gap-4 sm:grid-cols-2">
              {GAME_CATALOG.map((game) => {
                const isAdded = games.some((item) => item.id === game.id)

                return (
                  <li key={game.id}>
                    <button
                      type="button"
                      onClick={() => handleAdd(game)}
                      disabled={isAdded || pendingId !== null}
                      className={`flex w-full items-center gap-4 rounded-2xl border p-4 text-left transition-all duration-300 focus:outline-none focus:ring-4 focus:ring-blue-500/20 ${
                        isAdded
                          ? 'cursor-default border-white/5 bg-white/[0.01]'
                          : 'border-white/10 bg-white/[0.03] hover:border-[#0066ff] hover:bg-[#0066ff]/10 hover:shadow-[0_0_30px_rgba(0,102,255,0.22)] active:scale-[0.98] disabled:opacity-50'
                      }`}
                    >
                      <span
                        className={`h-16 w-16 shrink-0 overflow-hidden rounded-xl ring-1 ring-white/10 transition-all duration-300 ${
                          isAdded ? 'opacity-30 grayscale' : ''
                        }`}
                      >
                        <GameArtwork game={game} />
                      </span>

                      <span className="min-w-0 flex-1">
                        <span
                          className={`block truncate text-[15px] font-medium ${
                            isAdded ? 'text-zinc-600' : 'text-white'
                          }`}
                        >
                          {game.name}
                        </span>
                        {isAdded ? (
                          <span className="mt-1 flex items-center gap-1.5 text-xs text-zinc-600">
                            <Check className="h-3.5 w-3.5" />
                            {t('dashboard.added')}
                          </span>
                        ) : (
                          <span className="mt-1 block truncate text-xs text-zinc-500">
                            {getGameCopy(game, activeLanguage).genre}
                          </span>
                        )}
                      </span>

                      {pendingId === game.id ? (
                        <Loader2 className="h-5 w-5 shrink-0 animate-spin text-blue-400" />
                      ) : (
                        !isAdded && <Plus className="h-5 w-5 shrink-0 text-zinc-500" />
                      )}
                    </button>
                  </li>
                )
              })}
            </ul>
          </div>
        </div>
      )}
    </div>
  )
}

export default Dashboard

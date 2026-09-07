import { useCallback, useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { onAuthStateChanged, signOut } from 'firebase/auth'
import {
  collection,
  deleteDoc,
  doc,
  getDocs,
  orderBy,
  query,
  serverTimestamp,
  setDoc,
} from 'firebase/firestore'
import {
  AlertCircle,
  Check,
  Gamepad2,
  Loader2,
  LogOut,
  Plus,
  Trash2,
  Users,
  X,
} from 'lucide-react'
import { auth, db } from '../config/firebase'

// Drop a file named <game id>.png/jpg/webp/svg into src/assets/games/ and the
// card picks it up automatically — no code change needed.
const gameImages = import.meta.glob(
  '../assets/games/*.{png,jpg,jpeg,webp,avif,svg}',
  { eager: true, query: '?url', import: 'default' },
)

const imageByGameId = Object.fromEntries(
  Object.entries(gameImages).map(([path, url]) => [
    path.split('/').pop().replace(/\.[^.]+$/, ''),
    url,
  ]),
)

const GAME_CATALOG = [
  {
    id: 'genshin-impact',
    name: 'Genshin Impact',
    short: 'GI',
    banner: 'from-sky-500/45 via-cyan-500/15 to-transparent',
    glow: 'text-sky-200',
  },
  {
    id: 'honkai-star-rail',
    name: 'Honkai: Star Rail',
    short: 'HSR',
    banner: 'from-indigo-500/45 via-violet-500/15 to-transparent',
    glow: 'text-indigo-200',
  },
  {
    id: 'high-school-dxd-opi',
    name: 'High School DxD: OPI',
    short: 'DxD',
    banner: 'from-rose-500/45 via-red-500/15 to-transparent',
    glow: 'text-rose-200',
  },
  {
    id: 'zenless-zone-zero',
    name: 'Zenless Zone Zero',
    short: 'ZZZ',
    banner: 'from-amber-500/45 via-orange-500/15 to-transparent',
    glow: 'text-amber-200',
  },
]

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

function GameArtwork({ game, className }) {
  const image = imageByGameId[game.id]

  if (image) {
    return (
      <img
        src={image}
        alt={game.name}
        loading="lazy"
        className={`h-full w-full object-cover ${className ?? ''}`}
      />
    )
  }

  return (
    <div
      className={`flex h-full w-full items-center justify-center bg-gradient-to-br ${game.banner} ${className ?? ''}`}
    >
      <span className={`text-3xl font-bold tracking-tight ${game.glow}`}>
        {game.short}
      </span>
    </div>
  )
}

function GameCard({ game, delayClass, isRemoving, onOpen, onDelete }) {
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
          <Users className="h-4 w-4" />
          Ver personajes
        </button>

        <button
          type="button"
          onClick={() => onDelete(game)}
          disabled={isRemoving}
          aria-label={`Eliminar ${game.name}`}
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
  const [error, setError] = useState('')

  useEffect(() => {
    return onAuthStateChanged(auth, (currentUser) => {
      if (!currentUser) {
        navigate('/login', { replace: true })
        return
      }
      setUser(currentUser)
    })
  }, [navigate])

  const loadGames = useCallback(async (userId) => {
    setIsLoading(true)
    try {
      const snapshot = await getDocs(
        query(
          collection(db, 'users', userId, 'userGames'),
          orderBy('addedDate', 'asc'),
        ),
      )
      const stored = snapshot.docs.map((entry) => {
        const data = entry.data()
        const fromCatalog = GAME_CATALOG.find((item) => item.id === data.gameId)
        return { ...fromCatalog, id: data.gameId, name: data.gameName }
      })
      setGames(stored)
      setError('')
    } catch (loadError) {
      setError(`No se pudieron cargar tus juegos: ${loadError.message}`)
    } finally {
      setIsLoading(false)
    }
  }, [])

  useEffect(() => {
    if (user) {
      loadGames(user.uid)
    }
  }, [user, loadGames])

  const handleAdd = async (game) => {
    if (!user || games.some((item) => item.id === game.id)) {
      return
    }

    setPendingId(game.id)
    try {
      await setDoc(doc(db, 'users', user.uid, 'userGames', game.id), {
        userId: user.uid,
        gameId: game.id,
        gameName: game.name,
        addedDate: serverTimestamp(),
      })
      setGames((current) => [...current, game])
      setError('')
      setIsAdding(false)
    } catch (addError) {
      setError(`No se pudo guardar el juego: ${addError.message}`)
    } finally {
      setPendingId(null)
    }
  }

  const handleDelete = async (game) => {
    if (!user) {
      return
    }

    setRemovingIds((current) => [...current, game.id])
    try {
      await deleteDoc(doc(db, 'users', user.uid, 'userGames', game.id))
      await new Promise((resolve) => setTimeout(resolve, 320))
      setGames((current) => current.filter((item) => item.id !== game.id))
      setError('')
    } catch (deleteError) {
      setError(`No se pudo eliminar el juego: ${deleteError.message}`)
    } finally {
      setRemovingIds((current) => current.filter((id) => id !== game.id))
    }
  }

  const handleLogout = async () => {
    await signOut(auth)
    navigate('/login', { replace: true })
  }

  const availableGames = GAME_CATALOG.filter(
    (game) => !games.some((item) => item.id === game.id),
  )

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <AnimatedBackground />

      <header className="sticky top-0 z-20 border-b-2 border-blue-600/70 bg-[#0a0a0a]/90 backdrop-blur-xl">
        <div className="mx-auto flex max-w-7xl flex-col items-center gap-4 px-4 py-4 sm:px-6 md:flex-row md:justify-between md:gap-6">
          <div className="flex items-center gap-2.5">
            <div className="flex h-9 w-9 items-center justify-center rounded-lg bg-gradient-to-b from-white/15 to-white/[0.03] ring-1 ring-white/10">
              <Gamepad2 className="h-5 w-5 text-white" />
            </div>
            <span className="text-lg font-semibold tracking-tight text-white">
              Gacha Game Manager
            </span>
          </div>

          <button
            type="button"
            onClick={() => setIsAdding(true)}
            className="flex items-center gap-2 rounded-lg bg-white px-4 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:bg-[#0066ff] hover:text-white hover:shadow-[0_0_25px_rgba(0,102,255,0.65)] focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:scale-95"
          >
            <Plus className="h-4 w-4" />
            Agregar Juego
          </button>

          <button
            type="button"
            onClick={handleLogout}
            className="flex items-center gap-2 rounded-lg bg-white px-4 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:bg-red-600 hover:text-white hover:shadow-[0_0_25px_rgba(220,38,38,0.6)] focus:outline-none focus:ring-4 focus:ring-red-500/30 active:scale-95"
          >
            <LogOut className="h-4 w-4" />
            Cerrar sesión
          </button>
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-7xl px-4 py-10 sm:px-6 sm:py-14">
        <div className="mb-8 flex items-baseline gap-3">
          <h1 className="text-2xl font-semibold tracking-tight text-white sm:text-3xl">
            Mis Juegos
          </h1>
          {!isLoading && (
            <span className="text-sm text-zinc-500">
              {games.length} {games.length === 1 ? 'juego' : 'juegos'}
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
            <p className="mb-5 text-zinc-400">
              Todavía no has añadido ningún juego.
            </p>
            <button
              type="button"
              onClick={() => setIsAdding(true)}
              className="inline-flex items-center gap-2 rounded-lg bg-white px-4 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:bg-[#0066ff] hover:text-white hover:shadow-[0_0_25px_rgba(0,102,255,0.65)] focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:scale-95"
            >
              <Plus className="h-4 w-4" />
              Agregar Juego
            </button>
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
      </main>

      {isAdding && (
        <div className="fixed inset-0 z-30 flex items-center justify-center bg-black/70 px-4 py-10 backdrop-blur-sm">
          <div className="max-h-full w-full max-w-md overflow-y-auto rounded-2xl border border-white/10 bg-[#1a1a1a] p-6 shadow-2xl shadow-black/80">
            <div className="mb-5 flex items-center justify-between">
              <h2 className="text-lg font-semibold text-white">Agregar juego</h2>
              <button
                type="button"
                onClick={() => setIsAdding(false)}
                aria-label="Cerrar"
                className="rounded-lg p-1.5 text-zinc-400 transition-colors duration-300 hover:bg-white/10 hover:text-white focus:outline-none focus:ring-2 focus:ring-white/30"
              >
                <X className="h-4 w-4" />
              </button>
            </div>

            {availableGames.length === 0 ? (
              <p className="py-6 text-center text-sm text-zinc-400">
                Ya has añadido todos los juegos disponibles.
              </p>
            ) : (
              <ul className="space-y-3">
                {availableGames.map((game) => (
                  <li key={game.id}>
                    <button
                      type="button"
                      onClick={() => handleAdd(game)}
                      disabled={pendingId !== null}
                      className="flex w-full items-center gap-4 rounded-xl border border-white/10 bg-white/[0.03] p-3 text-left transition-all duration-300 hover:border-blue-500/50 hover:bg-white/[0.07] hover:shadow-[0_0_25px_rgba(0,102,255,0.2)] focus:outline-none focus:ring-4 focus:ring-blue-500/20 active:scale-[0.98] disabled:opacity-50"
                    >
                      <span className="h-12 w-12 shrink-0 overflow-hidden rounded-lg ring-1 ring-white/10">
                        <GameArtwork game={game} />
                      </span>
                      <span className="flex-1 text-sm font-medium text-white">
                        {game.name}
                      </span>
                      {pendingId === game.id ? (
                        <Loader2 className="h-4 w-4 animate-spin text-blue-400" />
                      ) : (
                        <Plus className="h-4 w-4 text-zinc-500" />
                      )}
                    </button>
                  </li>
                ))}
              </ul>
            )}

            {games.length > 0 && (
              <p className="mt-5 flex items-center gap-2 text-xs text-zinc-500">
                <Check className="h-3.5 w-3.5" />
                {games.length} ya en tu biblioteca
              </p>
            )}
          </div>
        </div>
      )}
    </div>
  )
}

export default Dashboard

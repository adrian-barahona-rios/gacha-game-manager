import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { Gamepad2, LogOut, Plus, Trash2, Users, X } from 'lucide-react'

const BANNERS = [
  'from-blue-500/40 via-blue-500/10 to-transparent',
  'from-purple-500/40 via-purple-500/10 to-transparent',
  'from-cyan-500/40 via-cyan-500/10 to-transparent',
  'from-fuchsia-500/40 via-fuchsia-500/10 to-transparent',
  'from-indigo-500/40 via-indigo-500/10 to-transparent',
  'from-sky-500/40 via-sky-500/10 to-transparent',
]

const INITIAL_GAMES = [
  { id: 'genshin', name: 'Genshin Impact', banner: BANNERS[0] },
  { id: 'hsr', name: 'Honkai: Star Rail', banner: BANNERS[1] },
  { id: 'zzz', name: 'Zenless Zone Zero', banner: BANNERS[2] },
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

const CARD_DELAYS = [
  'delay-0',
  'delay-100',
  'delay-200',
  'delay-300',
  'delay-500',
  'delay-700',
]

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

function GameCard({ game, delayClass, onOpen, onDelete }) {
  const [shown, setShown] = useState(false)

  useEffect(() => {
    const frame = requestAnimationFrame(() => setShown(true))
    return () => cancelAnimationFrame(frame)
  }, [])

  return (
    <article
      className={`group rounded-2xl border border-white/10 bg-[#1a1a1a] p-5 transition-all duration-700 ease-out hover:-translate-y-1 hover:scale-[1.02] hover:border-blue-500/40 hover:shadow-[0_0_40px_rgba(0,102,255,0.15)] ${delayClass} ${
        shown ? 'translate-y-0 opacity-100' : 'translate-y-6 opacity-0'
      }`}
    >
      <div
        className={`mb-5 flex h-36 items-center justify-center rounded-xl bg-gradient-to-br ring-1 ring-white/10 transition-transform duration-500 group-hover:scale-[1.01] ${game.banner}`}
      >
        <Gamepad2 className="h-11 w-11 text-white/90 transition-transform duration-500 group-hover:scale-110" />
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
          onClick={() => onDelete(game.id)}
          aria-label={`Eliminar ${game.name}`}
          className="flex items-center justify-center rounded-lg bg-white px-3 py-2.5 text-black transition-all duration-300 hover:bg-red-600 hover:text-white hover:shadow-[0_0_25px_rgba(220,38,38,0.6)] focus:outline-none focus:ring-4 focus:ring-red-500/30 active:scale-95 active:bg-[#0066ff] active:shadow-[0_0_25px_rgba(0,102,255,0.7)]"
        >
          <Trash2 className="h-4 w-4" />
        </button>
      </div>
    </article>
  )
}

function Dashboard() {
  const navigate = useNavigate()
  const [games, setGames] = useState(INITIAL_GAMES)
  const [isAdding, setIsAdding] = useState(false)
  const [newGame, setNewGame] = useState('')
  const [error, setError] = useState('')

  const handleAdd = (event) => {
    event.preventDefault()
    const name = newGame.trim()

    if (!name) {
      setError('Escribe el nombre del juego.')
      return
    }

    setGames((current) => [
      ...current,
      {
        id: `${Date.now()}`,
        name,
        banner: BANNERS[current.length % BANNERS.length],
      },
    ])
    setNewGame('')
    setError('')
    setIsAdding(false)
  }

  const handleDelete = (id) => {
    setGames((current) => current.filter((game) => game.id !== id))
  }

  const closeModal = () => {
    setIsAdding(false)
    setNewGame('')
    setError('')
  }

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
            onClick={() => navigate('/login')}
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
          <span className="text-sm text-zinc-500">
            {games.length} {games.length === 1 ? 'juego' : 'juegos'}
          </span>
        </div>

        {games.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
            <Gamepad2 className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
            <p className="text-zinc-400">Todavía no has añadido ningún juego.</p>
          </div>
        ) : (
          <div className="grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3">
            {games.map((game, index) => (
              <GameCard
                key={game.id}
                game={game}
                delayClass={CARD_DELAYS[index % CARD_DELAYS.length]}
                onOpen={(target) =>
                  navigate(`/game/${encodeURIComponent(target.name)}`)
                }
                onDelete={handleDelete}
              />
            ))}
          </div>
        )}
      </main>

      {isAdding && (
        <div className="fixed inset-0 z-30 flex items-center justify-center bg-black/70 px-4 backdrop-blur-sm">
          <div className="w-full max-w-sm rounded-2xl border border-white/10 bg-[#1a1a1a] p-6 shadow-2xl shadow-black/80">
            <div className="mb-5 flex items-center justify-between">
              <h2 className="text-lg font-semibold text-white">Agregar juego</h2>
              <button
                type="button"
                onClick={closeModal}
                aria-label="Cerrar"
                className="rounded-lg p-1.5 text-zinc-400 transition-colors duration-300 hover:bg-white/10 hover:text-white focus:outline-none focus:ring-2 focus:ring-white/30"
              >
                <X className="h-4 w-4" />
              </button>
            </div>

            <form onSubmit={handleAdd} noValidate>
              <input
                autoFocus
                value={newGame}
                onChange={(event) => {
                  setNewGame(event.target.value)
                  setError('')
                }}
                placeholder="Nombre del juego"
                className={`w-full rounded-xl border bg-white/[0.03] px-4 py-3 text-[15px] text-white placeholder:text-zinc-600 transition-all duration-300 focus:bg-white/[0.06] focus:outline-none focus:ring-4 ${
                  error
                    ? 'border-red-500/40 focus:border-red-500/70 focus:ring-red-500/10'
                    : 'border-white/10 focus:border-blue-500/60 focus:ring-blue-500/10'
                }`}
              />
              {error && <p className="mt-2 text-[13px] text-red-400/90">{error}</p>}

              <button
                type="submit"
                className="mt-5 flex w-full items-center justify-center gap-2 rounded-lg bg-white py-3 text-sm font-semibold text-black transition-all duration-300 hover:bg-[#0066ff] hover:text-white hover:shadow-[0_0_25px_rgba(0,102,255,0.65)] focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:scale-95"
              >
                <Plus className="h-4 w-4" />
                Agregar
              </button>
            </form>
          </div>
        </div>
      )}
    </div>
  )
}

export default Dashboard

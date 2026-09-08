import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, ListOrdered } from 'lucide-react'
import { supabase } from '../config/supabase'
import { getGameById } from '../data/games'
import { getElementStyle } from '../data/characterStyles'

// Escala de Prydwen: 0 es el tier mas alto. Los colores siguen esa direccion,
// verde arriba y rojo abajo, como pidio Vara.
const RATING_STYLES = {
  0: 'border-emerald-500/40 bg-emerald-500/10 text-emerald-300',
  0.5: 'border-teal-500/40 bg-teal-500/10 text-teal-300',
  1: 'border-lime-500/40 bg-lime-500/10 text-lime-300',
  1.5: 'border-yellow-500/40 bg-yellow-500/10 text-yellow-300',
  2: 'border-amber-500/40 bg-amber-500/10 text-amber-300',
  3: 'border-orange-500/40 bg-orange-500/10 text-orange-300',
  4: 'border-rose-500/40 bg-rose-500/10 text-rose-300',
  5: 'border-red-600/40 bg-red-600/10 text-red-300',
}

const MODE_ORDER = [
  'General',
  'Memory of Chaos',
  'Pure Fiction',
  'Apocalyptic Shadow',
]

function TierListOfficial() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const game = getGameById(gameId)
  const [rows, setRows] = useState([])
  const [modes, setModes] = useState([])
  const [mode, setMode] = useState('')
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')

  useEffect(() => {
    let active = true

    supabase
      .from('tier_lists_oficial')
      .select('mode, rating, source, characters (id, name, element, rarity, role)')
      .eq('game_id', gameId)
      .order('rating', { ascending: true })
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }

        if (loadError) {
          setError(`No se pudo cargar la tier list: ${loadError.message}`)
        } else {
          setRows(data)
          const found = [...new Set(data.map((r) => r.mode))].sort(
            (a, b) => MODE_ORDER.indexOf(a) - MODE_ORDER.indexOf(b),
          )
          setModes(found)
          setMode((current) => current || found[0] || '')
          setError('')
        }

        setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [gameId])

  const visible = rows.filter((row) => row.mode === mode)
  const ratings = [...new Set(visible.map((row) => Number(row.rating)))].sort(
    (a, b) => a - b,
  )
  const source = rows[0]?.source

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <div className="pointer-events-none fixed inset-0" aria-hidden="true">
        <div className="absolute inset-0 bg-[linear-gradient(to_right,rgba(255,255,255,0.035)_1px,transparent_1px),linear-gradient(to_bottom,rgba(255,255,255,0.035)_1px,transparent_1px)] bg-[size:64px_64px] [mask-image:radial-gradient(ellipse_at_center,black_10%,transparent_70%)]" />
        <div className="absolute -top-40 left-[12%] h-[30rem] w-[30rem] animate-pulse rounded-full bg-blue-600/12 blur-[130px] [animation-duration:9s]" />
      </div>

      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-7xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}`)}
            aria-label="Volver al juego"
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">
              Tier list oficial
            </h1>
            <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>
              {game?.name ?? gameId}
            </p>
          </div>

          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}/tierlist/personal`)}
            className="shrink-0 rounded-lg border border-white/15 px-3 py-2.5 text-sm font-medium text-zinc-300 transition-all duration-300 hover:border-[#0066ff] hover:bg-[#0066ff]/10 hover:text-white focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:scale-95"
          >
            Mi tier list
          </button>
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-7xl px-4 py-10 sm:px-6 sm:py-14">
        {error && (
          <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
            <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{error}</p>
          </div>
        )}

        {modes.length > 0 && (
          <div className="mb-8 flex flex-wrap items-center gap-4">
            <label htmlFor="mode" className="text-sm text-zinc-400">
              Modo
            </label>
            <select
              id="mode"
              value={mode}
              onChange={(event) => setMode(event.target.value)}
              className="rounded-xl border border-white/10 bg-white/[0.03] px-4 py-2.5 text-sm text-white transition-all duration-300 hover:border-white/20 focus:border-white/30 focus:outline-none focus:ring-4 focus:ring-white/5"
            >
              {modes.map((option) => (
                <option key={option} value={option} className="bg-[#111114]">
                  {option}
                </option>
              ))}
            </select>

            {source && (
              <span className="text-xs text-zinc-600">
                Valoraciones de {source} · 0 es el tier más alto
              </span>
            )}
          </div>
        )}

        {isLoading ? (
          <div className="space-y-4">
            {[0, 1, 2].map((slot) => (
              <div
                key={slot}
                className="h-28 animate-pulse rounded-2xl border border-white/10 bg-[#1a1a1a]"
              />
            ))}
          </div>
        ) : visible.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
            <ListOrdered className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
            <p className="text-zinc-400">
              Todavía no hay valoraciones cargadas para este juego.
            </p>
          </div>
        ) : (
          <div className="space-y-4">
            {ratings.map((rating) => {
              const group = visible.filter((row) => Number(row.rating) === rating)

              return (
                <section
                  key={rating}
                  className={`flex flex-col gap-4 rounded-2xl border p-4 sm:flex-row sm:items-start sm:p-5 ${RATING_STYLES[rating] ?? 'border-white/10 bg-white/[0.03] text-zinc-300'}`}
                >
                  <div className="flex shrink-0 items-center gap-3 sm:w-24 sm:flex-col sm:items-start">
                    <span className="text-3xl font-bold tracking-tight">
                      {rating}
                    </span>
                    <span className="text-xs uppercase tracking-wide opacity-70">
                      {group.length}{' '}
                      {group.length === 1 ? 'personaje' : 'personajes'}
                    </span>
                  </div>

                  <div className="flex flex-1 flex-wrap gap-2">
                    {group.map((row) => (
                      <button
                        key={row.characters.id}
                        type="button"
                        onClick={() =>
                          navigate(
                            `/game/${gameId}/characters/${row.characters.id}`,
                          )
                        }
                        title={row.characters.role ?? undefined}
                        className={`rounded-lg px-3 py-2 text-sm font-medium ring-1 transition-all duration-300 hover:-translate-y-0.5 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 ${getElementStyle(row.characters.element).badge}`}
                      >
                        {row.characters.name}
                      </button>
                    ))}
                  </div>
                </section>
              )
            })}
          </div>
        )}
      </main>
    </div>
  )
}

export default TierListOfficial

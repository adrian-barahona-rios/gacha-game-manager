import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, ListOrdered } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { getElementChip, getElementStyle } from '../data/characterStyles'
import ProfileButton from './ProfileButton'

// Escala de Prydwen: 0 es el tier mas alto. Los colores siguen esa direccion,
// verde arriba y rojo abajo, como pidio Vara.
//
// Los fondos son opacos a proposito: con un color translucido se veia el fondo
// de la pagina por detras y las cajas perdian fuerza.
const RATING_STYLES = {
  0: 'border-emerald-500/50 bg-emerald-950 text-emerald-300',
  0.5: 'border-teal-500/50 bg-teal-950 text-teal-300',
  1: 'border-lime-500/50 bg-lime-950 text-lime-300',
  1.5: 'border-yellow-500/50 bg-yellow-950 text-yellow-300',
  2: 'border-amber-500/50 bg-amber-950 text-amber-300',
  3: 'border-orange-500/50 bg-orange-950 text-orange-300',
  4: 'border-rose-500/50 bg-rose-950 text-rose-300',
  5: 'border-red-600/50 bg-red-950 text-red-300',
}

const MODE_ORDER = [
  'General',
  'Memory of Chaos',
  'Pure Fiction',
  'Apocalyptic Shadow',
]

// Al entrar se abre Pura Ficcion, que es el modo que mas se consulta. Si el
// juego no lo tiene (Genshin y Zenless solo traen "General"), cae al primero.
const DEFAULT_MODE = 'Pure Fiction'

// Un color propio por modo, para distinguirlos de un vistazo.
const MODE_STYLES = {
  'Memory of Chaos': {
    on: 'border-violet-400 bg-violet-600 text-white shadow-[0_0_25px_rgba(139,92,246,0.45)]',
    off: 'border-violet-500/40 bg-violet-950 text-violet-300 hover:border-violet-400 hover:bg-violet-900',
  },
  'Pure Fiction': {
    on: 'border-sky-400 bg-sky-600 text-white shadow-[0_0_25px_rgba(56,189,248,0.45)]',
    off: 'border-sky-500/40 bg-sky-950 text-sky-300 hover:border-sky-400 hover:bg-sky-900',
  },
  'Apocalyptic Shadow': {
    on: 'border-rose-400 bg-rose-600 text-white shadow-[0_0_25px_rgba(244,63,94,0.45)]',
    off: 'border-rose-500/40 bg-rose-950 text-rose-300 hover:border-rose-400 hover:bg-rose-900',
  },
  General: {
    on: 'border-blue-400 bg-blue-600 text-white shadow-[0_0_25px_rgba(59,130,246,0.45)]',
    off: 'border-blue-500/40 bg-blue-950 text-blue-300 hover:border-blue-400 hover:bg-blue-900',
  },
}

const FALLBACK_MODE_STYLE = {
  on: 'border-white/60 bg-white/20 text-white',
  off: 'border-white/15 bg-zinc-900 text-zinc-300 hover:border-white/40 hover:bg-zinc-800',
}

// La ficha del personaje: retrato arriba y nombre debajo. El nombre lleva el
// color de su elemento, distinto del de la caja del tier que lo contiene.
function CharacterChip({ character, onOpen }) {
  const { tile } = getElementStyle(character.element)

  return (
    <button
      type="button"
      onClick={onOpen}
      title={character.role ?? undefined}
      className={`w-[5.5rem] overflow-hidden rounded-xl border border-white/10 bg-[#141418] ring-1 transition-all duration-300 hover:-translate-y-1 hover:border-white/30 focus:outline-none focus:ring-4 focus:ring-white/20 sm:w-24 ${getElementChip(character.element)}`}
    >
      <span
        className={`flex h-[4.5rem] w-full items-center justify-center bg-gradient-to-br sm:h-20 ${tile}`}
      >
        {character.image_url ? (
          <img
            src={character.image_url}
            alt={character.name}
            loading="lazy"
            className="h-full w-auto max-w-full object-contain"
          />
        ) : (
          <span className="text-2xl font-bold tracking-tight text-white/85">
            {character.name.charAt(0)}
          </span>
        )}
      </span>

      <span className="block px-1.5 py-1.5 text-center text-[11px] font-semibold leading-tight">
        {character.name}
      </span>
    </button>
  )
}

function TierListOfficial() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const game = getGameById(gameId)
  const [rows, setRows] = useState([])
  const [modes, setModes] = useState([])
  const [mode, setMode] = useState('')
  const [isLoading, setIsLoading] = useState(true)
  const { t } = useI18n()
  const [error, setError] = useState('')

  useEffect(() => {
    let active = true

    supabase
      .from('tier_lists_oficial')
      .select(
        'mode, rating, source, characters (id, name, element, rarity, role, image_url)',
      )
      .eq('game_id', gameId)
      .order('rating', { ascending: true })
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }

        if (loadError) {
          setError(t('tierlist.error.load', { message: loadError.message }))
        } else {
          setRows(data)
          const found = [...new Set(data.map((r) => r.mode))].sort(
            (a, b) => MODE_ORDER.indexOf(a) - MODE_ORDER.indexOf(b),
          )
          setModes(found)
          setMode(
            (current) =>
              current ||
              (found.includes(DEFAULT_MODE) ? DEFAULT_MODE : found[0]) ||
              '',
          )
          setError('')
        }

        setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [gameId, t])

  const visible = rows.filter((row) => row.mode === mode)
  const ratings = [...new Set(visible.map((row) => Number(row.rating)))].sort(
    (a, b) => a - b,
  )
  const source = rows[0]?.source

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
              {t('tierlist.officialTitle')}
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
            {t('tierlist.personalTitle')}
          </button>
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

        {/* Un juego con un solo modo no necesita elegir nada. */}
        {modes.length > 1 && (
          <div className="mb-6 flex flex-wrap gap-3">
            {modes.map((option) => {
              const style = MODE_STYLES[option] ?? FALLBACK_MODE_STYLE
              const active = option === mode

              return (
                <button
                  key={option}
                  type="button"
                  onClick={() => setMode(option)}
                  aria-pressed={active}
                  className={`rounded-xl border px-5 py-3 text-sm font-semibold tracking-tight transition-all duration-300 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95 ${
                    active ? style.on : style.off
                  }`}
                >
                  {option}
                </button>
              )
            })}
          </div>
        )}

        {source && (
          <p className="mb-8 text-xs text-zinc-600">
            Valoraciones de {source} · 0 es el tier más alto
          </p>
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
              {t('tierlist.empty')}
            </p>
          </div>
        ) : (
          <div className="space-y-4">
            {ratings.map((rating) => {
              const group = visible.filter((row) => Number(row.rating) === rating)

              return (
                <section
                  key={rating}
                  className={`flex flex-col gap-4 rounded-2xl border p-4 sm:flex-row sm:items-start sm:p-5 ${RATING_STYLES[rating] ?? 'border-white/10 bg-zinc-900 text-zinc-300'}`}
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

                  <div className="flex flex-1 flex-wrap items-start gap-2.5">
                    {group.map((row) => (
                      <CharacterChip
                        key={row.characters.id}
                        character={row.characters}
                        onOpen={() =>
                          navigate(
                            `/game/${gameId}/characters/${row.characters.id}`,
                          )
                        }
                      />
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

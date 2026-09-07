import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, Users } from 'lucide-react'
import { supabase } from '../config/supabase'
import { getGameById } from '../data/games'
import {
  formatRarity,
  getElementStyle,
  getRarityStyle,
} from '../data/characterStyles'

function CharacterPortrait({ character, className }) {
  const { tile } = getElementStyle(character.element)

  if (character.image_url) {
    return (
      <img
        src={character.image_url}
        alt={character.name}
        loading="lazy"
        className={`h-full w-full object-cover object-top ${className ?? ''}`}
      />
    )
  }

  return (
    <span
      className={`flex h-full w-full items-center justify-center bg-gradient-to-br ${tile} ${className ?? ''}`}
    >
      <span className="text-4xl font-bold tracking-tight text-white/85">
        {character.name.charAt(0)}
      </span>
    </span>
  )
}

function CharacterGrid() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const game = getGameById(gameId)
  const [characters, setCharacters] = useState([])
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')

  useEffect(() => {
    let active = true

    supabase
      .from('characters')
      .select('id, name, image_url, rarity, element, description')
      .eq('game_id', gameId)
      .order('rarity', { ascending: false })
      .order('name', { ascending: true })
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(`No se pudieron cargar los personajes: ${loadError.message}`)
        } else {
          setCharacters(data)
          setError('')
        }
        setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [gameId])

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
              Personajes
            </h1>
            <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>
              {game?.name ?? gameId}
            </p>
          </div>

          {!isLoading && (
            <span className="shrink-0 text-sm text-zinc-500">
              {characters.length}
            </span>
          )}
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-7xl px-4 py-10 sm:px-6 sm:py-14">
        {error && (
          <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
            <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{error}</p>
          </div>
        )}

        {isLoading ? (
          <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {[0, 1, 2, 3, 4, 5].map((slot) => (
              <div
                key={slot}
                className="animate-pulse rounded-2xl border border-white/10 bg-[#1a1a1a] p-5"
              >
                <div className="mb-5 h-48 rounded-xl bg-white/5" />
                <div className="mb-4 h-5 w-2/3 rounded bg-white/5" />
                <div className="h-10 rounded-lg bg-white/5" />
              </div>
            ))}
          </div>
        ) : characters.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
            <Users className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
            <p className="text-zinc-400">
              Todavía no hay personajes cargados para este juego.
            </p>
          </div>
        ) : (
          <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {characters.map((character) => {
              const elementStyle = getElementStyle(character.element)

              return (
                <article
                  key={character.id}
                  className="group rounded-2xl border border-white/10 bg-[#1a1a1a] p-5 transition-all duration-300 hover:-translate-y-1 hover:border-blue-500/40 hover:shadow-[0_0_40px_rgba(0,102,255,0.15)]"
                >
                  <div className="mb-5 h-48 overflow-hidden rounded-xl ring-1 ring-white/10">
                    <CharacterPortrait
                      character={character}
                      className="transition-transform duration-500 group-hover:scale-105"
                    />
                  </div>

                  <h2
                    className="mb-3 truncate text-lg font-semibold text-white"
                    title={character.name}
                  >
                    {character.name}
                  </h2>

                  <div className="mb-5 flex flex-wrap gap-2">
                    {character.rarity && (
                      <span
                        className={`rounded-full px-2.5 py-1 text-xs font-medium ring-1 ${getRarityStyle(character.rarity)}`}
                      >
                        {formatRarity(character.rarity)}
                      </span>
                    )}
                    {character.element && (
                      <span
                        className={`rounded-full px-2.5 py-1 text-xs font-medium ring-1 ${elementStyle.badge}`}
                      >
                        {character.element}
                      </span>
                    )}
                  </div>

                  <button
                    type="button"
                    onClick={() =>
                      navigate(`/game/${gameId}/characters/${character.id}`)
                    }
                    className="w-full rounded-lg bg-white px-3 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:bg-purple-600 hover:text-white hover:shadow-[0_0_25px_rgba(147,51,234,0.6)] focus:outline-none focus:ring-4 focus:ring-purple-500/30 active:scale-95 active:bg-[#0066ff]"
                  >
                    Ver detalles
                  </button>
                </article>
              )
            })}
          </div>
        )}
      </main>
    </div>
  )
}

export default CharacterGrid

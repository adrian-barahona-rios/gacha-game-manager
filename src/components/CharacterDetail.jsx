import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, BookOpen, Heart, Loader2 } from 'lucide-react'
import { supabase } from '../config/supabase'
import { getGameById } from '../data/games'
import {
  formatRarity,
  getElementStyle,
  getRarityStyle,
} from '../data/characterStyles'

const TABS = [
  { id: 'detalles', label: 'Detalles' },
  { id: 'biografia', label: 'Biografía' },
  { id: 'stats', label: 'Stats' },
]

// Cada juego llama distinto a lo mismo: Via en Star Rail, Especialidad en Zenless.
const PATH_LABELS = {
  'honkai-star-rail': ['Vía', 'Cono de luz'],
  'zenless-zone-zero': ['Especialidad', 'Motor-W'],
}

function CharacterDetail() {
  const { gameId, characterId } = useParams()
  const [activeTab, setActiveTab] = useState('detalles')
  const navigate = useNavigate()
  const game = getGameById(gameId)
  const [character, setCharacter] = useState(null)
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')
  const [userId, setUserId] = useState(null)
  const [isFavorite, setIsFavorite] = useState(false)
  const [isTogglingFavorite, setIsTogglingFavorite] = useState(false)

  useEffect(() => {
    let active = true

    supabase
      .from('characters')
      .select('*')
      .eq('id', characterId)
      .maybeSingle()
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(`No se pudo cargar el personaje: ${loadError.message}`)
        } else {
          setCharacter(data)
        }
        setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [characterId])

  useEffect(() => {
    let active = true

    supabase.auth.getSession().then(({ data }) => {
      if (!active || !data.session) {
        return
      }

      const currentId = data.session.user.id
      setUserId(currentId)

      supabase
        .from('favorite_characters')
        .select('character_id')
        .eq('user_id', currentId)
        .eq('character_id', characterId)
        .maybeSingle()
        .then(({ data: favorite }) => {
          if (active) {
            setIsFavorite(Boolean(favorite))
          }
        })
    })

    return () => {
      active = false
    }
  }, [characterId])

  const toggleFavorite = async () => {
    if (!userId) {
      navigate('/login')
      return
    }

    setIsTogglingFavorite(true)

    const { error: favoriteError } = isFavorite
      ? await supabase
          .from('favorite_characters')
          .delete()
          .eq('user_id', userId)
          .eq('character_id', characterId)
      : await supabase
          .from('favorite_characters')
          .insert({ user_id: userId, character_id: characterId })

    setIsTogglingFavorite(false)

    if (favoriteError) {
      setError(`No se pudo actualizar el favorito: ${favoriteError.message}`)
      return
    }

    setIsFavorite((current) => !current)
    setError('')
  }

  const elementStyle = getElementStyle(character?.element)
  const [pathLabel, signatureLabel] = PATH_LABELS[gameId] ?? [
    'Especialidad',
    'Equipo recomendado',
  ]

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <div className="pointer-events-none fixed inset-0" aria-hidden="true">
        <div className="absolute inset-0 bg-[linear-gradient(to_right,rgba(255,255,255,0.035)_1px,transparent_1px),linear-gradient(to_bottom,rgba(255,255,255,0.035)_1px,transparent_1px)] bg-[size:64px_64px] [mask-image:radial-gradient(ellipse_at_center,black_10%,transparent_70%)]" />
        <div className="absolute -top-40 right-[10%] h-[30rem] w-[30rem] animate-pulse rounded-full bg-purple-600/12 blur-[130px] [animation-duration:11s]" />
      </div>

      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-5xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}/characters`)}
            className="flex shrink-0 items-center gap-2 rounded-lg border border-white/10 bg-white/5 px-3 py-2.5 text-sm font-medium text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
            Volver
          </button>
          <span className={`truncate text-sm ${game?.accent ?? 'text-zinc-500'}`}>
            {game?.name ?? gameId}
          </span>
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-5xl px-4 py-10 sm:px-6 sm:py-14">
        {error && (
          <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
            <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{error}</p>
          </div>
        )}

        {isLoading ? (
          <div className="grid animate-pulse gap-8 sm:grid-cols-[minmax(0,20rem)_1fr]">
            <div className="h-96 rounded-3xl bg-white/5" />
            <div className="space-y-4">
              <div className="h-9 w-2/3 rounded bg-white/5" />
              <div className="h-5 w-1/3 rounded bg-white/5" />
              <div className="h-32 rounded-2xl bg-white/5" />
            </div>
          </div>
        ) : !character ? (
          <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
            <p className="mb-6 text-zinc-400">
              No encontramos ningún personaje con ese identificador.
            </p>
            <button
              type="button"
              onClick={() => navigate(`/game/${gameId}/characters`)}
              className="inline-flex items-center gap-2 rounded-lg bg-white px-4 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:bg-[#0066ff] hover:text-white active:scale-95"
            >
              <ArrowLeft className="h-4 w-4" />
              Ver todos los personajes
            </button>
          </div>
        ) : (
          <div className="grid gap-8 sm:grid-cols-[minmax(0,20rem)_1fr]">
            <div className="h-96 overflow-hidden rounded-3xl border border-white/10 ring-1 ring-white/5 sm:h-[28rem]">
              {character.image_url ? (
                <img
                  src={character.image_url}
                  alt={character.name}
                  className="h-full w-full object-cover object-top"
                />
              ) : (
                <span
                  className={`flex h-full w-full items-center justify-center bg-gradient-to-br ${elementStyle.tile}`}
                >
                  <span className="text-8xl font-bold tracking-tight text-white/85">
                    {character.name.charAt(0)}
                  </span>
                </span>
              )}
            </div>

            <div className="min-w-0">
              <h1 className="mb-4 text-3xl font-semibold tracking-tight text-white sm:text-4xl">
                {character.name}
              </h1>

              <div className="mb-7 flex flex-wrap gap-2">
                {character.rarity && (
                  <span
                    className={`rounded-full px-3 py-1 text-sm font-medium ring-1 ${getRarityStyle(character.rarity)}`}
                  >
                    {formatRarity(character.rarity)}
                  </span>
                )}
                {character.element && (
                  <span
                    className={`rounded-full px-3 py-1 text-sm font-medium ring-1 ${elementStyle.badge}`}
                  >
                    {character.element}
                  </span>
                )}
              </div>

              <div className="mb-6 flex gap-1 rounded-xl border border-white/10 bg-white/[0.03] p-1">
                {TABS.filter(
                  (tab) => tab.id !== 'stats' || character.level_cap,
                ).map((tab) => (
                  <button
                    key={tab.id}
                    type="button"
                    onClick={() => setActiveTab(tab.id)}
                    className={`flex-1 rounded-lg px-3 py-2.5 text-sm font-medium transition-all duration-300 focus:outline-none focus:ring-2 focus:ring-white/30 ${
                      activeTab === tab.id
                        ? 'bg-white text-black'
                        : 'text-zinc-400 hover:bg-white/5 hover:text-white'
                    }`}
                  >
                    {tab.label}
                  </button>
                ))}
              </div>

              {activeTab === 'detalles' && (
                <dl className="mb-8 grid grid-cols-2 gap-4">
                  {[
                    ['Rareza', character.rarity ? formatRarity(character.rarity) : 'Sin definir'],
                    ['Elemento', character.element ?? 'Sin definir'],
                    ['Rol', character.role ?? 'Sin definir'],
                    [pathLabel, character.path ?? 'Sin definir'],
                    [signatureLabel, character.signature ?? 'Sin definir'],
                    ['Juego', game?.name ?? gameId],
                  ].map(([label, value]) => (
                    <div
                      key={label}
                      className="rounded-xl border border-white/10 bg-white/[0.03] p-4"
                    >
                      <dt className="mb-1.5 text-[11px] uppercase tracking-wide text-zinc-500">
                        {label}
                      </dt>
                      <dd className="text-sm font-medium text-white">{value}</dd>
                    </div>
                  ))}
                </dl>
              )}

              {activeTab === 'biografia' && (
                <div className="mb-8">
                  {character.biography ? (
                    <p className="whitespace-pre-line text-[15px] leading-relaxed text-zinc-300">
                      {character.biography}
                    </p>
                  ) : (
                    <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-10 text-center">
                      <BookOpen className="mx-auto mb-4 h-9 w-9 text-zinc-600" />
                      <p className="text-sm text-zinc-400">
                        La biografía de este personaje todavía no está cargada.
                      </p>
                    </div>
                  )}

                  {character.description && (
                    <p className="mt-6 text-sm text-zinc-500">
                      {character.description}
                    </p>
                  )}
                </div>
              )}

              {activeTab === 'stats' && (
                <dl className="mb-8 grid grid-cols-2 gap-4">
                  {[
                    ['Nivel máximo', character.level_cap ?? 'Sin definir'],
                    ['Rareza', character.rarity ? formatRarity(character.rarity) : 'Sin definir'],
                  ].map(([label, value]) => (
                    <div
                      key={label}
                      className="rounded-xl border border-white/10 bg-white/[0.03] p-4"
                    >
                      <dt className="mb-1.5 text-[11px] uppercase tracking-wide text-zinc-500">
                        {label}
                      </dt>
                      <dd className="text-sm font-medium text-white">{value}</dd>
                    </div>
                  ))}
                </dl>
              )}

              <button
                type="button"
                onClick={toggleFavorite}
                disabled={isTogglingFavorite}
                className={`flex items-center justify-center gap-2 rounded-xl px-5 py-3 text-sm font-semibold transition-all duration-300 focus:outline-none focus:ring-4 active:scale-95 disabled:cursor-not-allowed disabled:opacity-60 ${
                  isFavorite
                    ? 'bg-rose-600 text-white shadow-[0_0_25px_rgba(225,29,72,0.45)] hover:bg-rose-500 focus:ring-rose-500/30'
                    : 'border border-white/15 bg-transparent text-zinc-300 hover:border-rose-500 hover:bg-rose-500/10 hover:text-white focus:ring-rose-500/30'
                }`}
              >
                {isTogglingFavorite ? (
                  <Loader2 className="h-4 w-4 animate-spin" />
                ) : (
                  <Heart
                    className={`h-4 w-4 ${isFavorite ? 'fill-current' : ''}`}
                  />
                )}
                {isFavorite ? 'En favoritos' : 'Guardar como favorito'}
              </button>
            </div>
          </div>
        )}
      </main>
    </div>
  )
}

export default CharacterDetail

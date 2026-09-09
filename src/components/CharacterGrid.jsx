import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, Heart, Loader2, Search, Users } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { useFavorites } from '../data/useFavorites'
import { getGameById } from '../data/games'
import {
  formatRarity,
  getElementStyle,
  getRarityStyle,
} from '../data/characterStyles'
import ProfileButton from './ProfileButton'

function CharacterPortrait({ character, className }) {
  const { tile } = getElementStyle(character.element)

  // Los iconos oficiales son cuadrados: con object-cover en una caja ancha se
  // recortarian por arriba y por abajo, asi que van contenidos sobre la misma
  // placa de color que usa el respaldo.
  if (character.image_url) {
    return (
      <span className={`flex h-full w-full items-center justify-center bg-gradient-to-br ${tile}`}>
        <img
          src={character.image_url}
          alt={character.name}
          loading="lazy"
          className={`h-full w-auto max-w-full object-contain ${className ?? ''}`}
        />
      </span>
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
  const { t } = useI18n()
  const [error, setError] = useState('')
  const [view, setView] = useState('todos')
  const [term, setTerm] = useState('')
  const favorites = useFavorites('favorite_characters', { gameFilter: gameId })

  useEffect(() => {
    let active = true

    supabase
      .from('characters')
      .select('id, name, image_url, rarity, element, role, path, description')
      .eq('game_id', gameId)
      .order('rarity', { ascending: false })
      .order('name', { ascending: true })
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(t('characters.error.load', { message: loadError.message }))
        } else {
          setCharacters(data)
          setError('')
        }
        setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [gameId, t])

  const showingFavorites = view === 'favoritos'
  // Sin acentos y en minusculas: buscar "yanfei" encuentra a "Yanfei" y
  // "alhacen" encuentra a "Alhacén (Alhaitham)".
  const needle = term
    .trim()
    .normalize('NFD')
    .replace(/\p{Diacritic}/gu, '')
    .toLowerCase()

  const visible = characters.filter((character) => {
    if (showingFavorites && !favorites.favoriteIds.has(character.id)) {
      return false
    }
    if (!needle) {
      return true
    }
    return character.name
      .normalize('NFD')
      .replace(/\p{Diacritic}/gu, '')
      .toLowerCase()
      .includes(needle)
  })

  const TABS = [
    { id: 'todos', label: t('favorites.all'), count: characters.length },
    { id: 'favoritos', label: t('favorites.title'), count: favorites.favoriteIds.size },
  ]

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
            aria-label={t('characters.backToGame')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">
              {t('characters.title')}
            </h1>
            <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>
              {game?.name ?? gameId}
            </p>
          </div>

          {!isLoading && (
            <span className="shrink-0 text-sm text-zinc-500">
              {visible.length}
            </span>
          )}
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

        {favorites.error && (
          <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
            <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{t('favorites.error', { message: favorites.error })}</p>
          </div>
        )}

        <div className="mb-8 flex flex-wrap items-center gap-4">
        <div className="inline-flex gap-1.5 rounded-2xl border border-white/10 bg-white/[0.02] p-1.5">
          {TABS.map((tab) => (
            <button
              key={tab.id}
              type="button"
              onClick={() => setView(tab.id)}
              className={`flex items-center gap-2 rounded-xl px-4 py-2.5 text-sm font-medium transition-all duration-300 focus:outline-none focus:ring-4 focus:ring-blue-500/20 ${
                view === tab.id
                  ? 'bg-white text-black'
                  : 'text-zinc-400 hover:bg-white/5 hover:text-white'
              }`}
            >
              {tab.id === 'favoritos' && (
                <Heart className={`h-4 w-4 ${view === tab.id ? '' : 'text-rose-400'}`} />
              )}
              {tab.label}
              <span
                className={`rounded-full px-2 py-0.5 text-xs ${
                  view === tab.id ? 'bg-black/10 text-black/70' : 'bg-white/5 text-zinc-500'
                }`}
              >
                {tab.count}
              </span>
            </button>
          ))}
        </div>

          <div className="relative min-w-[15rem] flex-1">
            <input
              value={term}
              onChange={(event) => setTerm(event.target.value)}
              placeholder={t('characters.search')}
              className="peer w-full rounded-xl border border-white/10 bg-white/[0.03] py-3 pl-11 pr-4 text-[15px] text-white placeholder:text-zinc-600 transition-all duration-300 hover:border-white/20 focus:border-white/30 focus:bg-white/[0.06] focus:outline-none focus:ring-4 focus:ring-white/5"
            />
            <Search className="pointer-events-none absolute left-3.5 top-1/2 h-[18px] w-[18px] -translate-y-1/2 text-zinc-500 transition-colors duration-300 peer-focus:text-white" />
          </div>
        </div>

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
        ) : visible.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
            {showingFavorites ? (
              <Heart className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
            ) : (
              <Users className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
            )}
            <p className="text-zinc-400">
              {needle
                ? t('characters.noMatches')
                : !showingFavorites
                  ? t('characters.empty')
                  : favorites.userId
                    ? t('favorites.empty')
                    : t('favorites.signedOut')}
            </p>
          </div>
        ) : (
          <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {visible.map((character) => {
              const elementStyle = getElementStyle(character.element)
              const isFavorite = favorites.favoriteIds.has(character.id)

              return (
                <article
                  key={character.id}
                  className="group relative rounded-2xl border border-white/10 bg-[#1a1a1a] transition-all duration-300 hover:-translate-y-1 hover:border-blue-500/40 hover:shadow-[0_0_40px_rgba(0,102,255,0.15)]"
                >
                  {favorites.userId && (
                    <button
                      type="button"
                      onClick={() => favorites.toggle(character.id)}
                      disabled={favorites.pendingId === character.id}
                      aria-pressed={isFavorite}
                      aria-label={t(
                        isFavorite ? 'favorites.remove' : 'favorites.add',
                        { name: character.name },
                      )}
                      title={t(isFavorite ? 'favorites.remove' : 'favorites.add', {
                        name: character.name,
                      })}
                      className={`absolute right-3 top-3 z-10 flex h-10 w-10 items-center justify-center rounded-full border backdrop-blur-md transition-all duration-300 focus:outline-none focus:ring-4 focus:ring-rose-500/30 active:scale-90 disabled:opacity-60 ${
                        isFavorite
                          ? 'border-rose-500/50 bg-rose-500/25 text-rose-200 hover:bg-rose-500/35'
                          : 'border-white/15 bg-black/50 text-zinc-300 hover:border-rose-500/60 hover:bg-rose-500/20 hover:text-white'
                      }`}
                    >
                      {favorites.pendingId === character.id ? (
                        <Loader2 className="h-4 w-4 animate-spin" />
                      ) : (
                        <Heart className={`h-4 w-4 ${isFavorite ? 'fill-current' : ''}`} />
                      )}
                    </button>
                  )}

                  <button
                    type="button"
                    onClick={() =>
                      navigate(`/game/${gameId}/characters/${character.id}`)
                    }
                    className="flex w-full flex-col p-5 text-left focus:outline-none focus-visible:ring-4 focus-visible:ring-blue-500/30"
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

                    <div className="mb-3 flex flex-wrap gap-2">
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
                      {character.path && (
                        <span className="rounded-full bg-white/5 px-2.5 py-1 text-xs font-medium text-zinc-300 ring-1 ring-white/15">
                          {character.path}
                        </span>
                      )}
                    </div>

                    {character.role && (
                      <p className="mb-4 text-sm text-zinc-400">{character.role}</p>
                    )}

                    <span className="mt-auto block w-full rounded-lg bg-white px-3 py-2.5 text-center text-sm font-semibold text-black transition-all duration-300 group-hover:bg-purple-600 group-hover:text-white group-hover:shadow-[0_0_25px_rgba(147,51,234,0.6)]">
                      {t('characters.viewDetails')}
                    </span>
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

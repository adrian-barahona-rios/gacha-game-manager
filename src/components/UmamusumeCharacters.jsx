import { useEffect, useState } from 'react'
import { useParams } from 'react-router-dom'
import { AlertCircle, Heart, Loader2, Search, Users } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { useFavorites } from '../data/useFavorites'
import UmamusumeLayout from './UmamusumeLayout'

function UmamusumeCharacters() {
  const { t } = useI18n()
  const { version } = useParams()
  const [characters, setCharacters] = useState([])
  const [term, setTerm] = useState('')
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')
  const [view, setView] = useState('todos')
  const favorites = useFavorites('favorite_umamusume_characters', { version })

  useEffect(() => {
    let active = true

    supabase
      .from('umamusume_characters')
      .select('id, name, base_character, icon_url, rarity, release_date')
      .eq('version', version)
      .order('name', { ascending: true })
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(t('uma.error.trainees', { message: loadError.message }))
        } else {
          setCharacters(data)
          setError('')
        }
        setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [version, t])

  const showingFavorites = view === 'favoritos'
  const needle = term.trim().toLowerCase()
  const visible = characters.filter((character) => {
    if (showingFavorites && !favorites.favoriteIds.has(character.id)) {
      return false
    }
    if (!needle) {
      return true
    }
    return (
      character.name.toLowerCase().includes(needle) ||
      (character.base_character ?? '').toLowerCase().includes(needle)
    )
  })

  const TABS = [
    { id: 'todos', label: t('favorites.all'), count: characters.length },
    { id: 'favoritos', label: t('favorites.title'), count: favorites.favoriteIds.size },
  ]

  return (
    <UmamusumeLayout
      title={t('uma.menu.characters')}
      subtitle={isLoading ? '' : t('uma.traineeCount', { count: characters.length })}
      current="characters"
    >
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

      <div className="mb-6 flex flex-wrap items-center gap-4">
        <div className="inline-flex gap-1.5 rounded-2xl border border-white/10 bg-white/[0.02] p-1.5">
          {TABS.map((tab) => (
            <button
              key={tab.id}
              type="button"
              onClick={() => setView(tab.id)}
              className={`flex items-center gap-2 rounded-xl px-4 py-2.5 text-sm font-medium transition-all duration-300 focus:outline-none focus:ring-4 focus:ring-amber-500/20 ${
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

        <div className="relative min-w-[16rem] flex-1">
          <input
            value={term}
            onChange={(event) => setTerm(event.target.value)}
            placeholder={t('uma.searchTrainees')}
            className="peer w-full rounded-xl border border-white/10 bg-white/[0.03] py-3 pl-11 pr-4 text-[15px] text-white placeholder:text-zinc-600 transition-all duration-300 hover:border-white/20 focus:border-amber-500/50 focus:bg-white/[0.06] focus:outline-none focus:ring-4 focus:ring-amber-500/10"
          />
          <Search className="pointer-events-none absolute left-3.5 top-1/2 h-[18px] w-[18px] -translate-y-1/2 text-zinc-500 transition-colors duration-300 peer-focus:text-amber-200" />
        </div>
      </div>

      {isLoading ? (
        <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-5">
          {Array.from({ length: 10 }, (_, slot) => (
            <div
              key={slot}
              className="h-52 animate-pulse rounded-2xl border border-white/10 bg-[#1a1a1a]"
            />
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
            {showingFavorites && favorites.favoriteIds.size === 0
              ? favorites.userId
                ? t('favorites.empty')
                : t('favorites.signedOut')
              : characters.length === 0
                ? t('uma.noTrainees')
                : t('uma.noTraineeMatches')}
          </p>
        </div>
      ) : (
        <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-5">
          {visible.map((character) => {
            const isFavorite = favorites.favoriteIds.has(character.id)

            return (
              <article
                key={character.id}
                className="group relative flex flex-col rounded-2xl border border-white/10 bg-[#1a1a1a] p-4 transition-all duration-300 hover:-translate-y-1 hover:border-amber-500/40 hover:shadow-[0_0_35px_rgba(217,164,65,0.18)]"
              >
                {favorites.userId && (
                  <button
                    type="button"
                    onClick={() => favorites.toggle(character.id)}
                    disabled={favorites.pendingId === character.id}
                    aria-pressed={isFavorite}
                    aria-label={t(isFavorite ? 'favorites.remove' : 'favorites.add', {
                      name: character.name,
                    })}
                    title={t(isFavorite ? 'favorites.remove' : 'favorites.add', {
                      name: character.name,
                    })}
                    className={`absolute right-2.5 top-2.5 z-10 flex h-8 w-8 items-center justify-center rounded-full border backdrop-blur-md transition-all duration-300 focus:outline-none focus:ring-4 focus:ring-rose-500/30 active:scale-90 disabled:opacity-60 ${
                      isFavorite
                        ? 'border-rose-500/50 bg-rose-500/25 text-rose-200 hover:bg-rose-500/35'
                        : 'border-white/15 bg-black/50 text-zinc-300 hover:border-rose-500/60 hover:bg-rose-500/20 hover:text-white'
                    }`}
                  >
                    {favorites.pendingId === character.id ? (
                      <Loader2 className="h-3.5 w-3.5 animate-spin" />
                    ) : (
                      <Heart className={`h-3.5 w-3.5 ${isFavorite ? 'fill-current' : ''}`} />
                    )}
                  </button>
                )}

                <div className="mb-4 flex h-28 items-center justify-center overflow-hidden rounded-xl bg-white/[0.04] ring-1 ring-white/10">
                  {character.icon_url ? (
                    <img
                      src={character.icon_url}
                      alt={character.name}
                      loading="lazy"
                      className="h-full w-auto object-contain transition-transform duration-500 group-hover:scale-110"
                    />
                  ) : (
                    <Users className="h-8 w-8 text-zinc-600" />
                  )}
                </div>

                <h2
                  className="mb-1 line-clamp-2 text-sm font-semibold text-white"
                  title={character.name}
                >
                  {character.name}
                </h2>

                {character.base_character && (
                  <p className="mb-3 truncate text-xs text-zinc-500">
                    {character.base_character}
                  </p>
                )}

                <div className="mt-auto flex items-center justify-between gap-2">
                  {character.rarity && (
                    <span className="rounded-full bg-amber-500/15 px-2 py-0.5 text-xs font-medium text-amber-300 ring-1 ring-amber-400/30">
                      {character.rarity}
                    </span>
                  )}
                  {character.release_date && (
                    <span className="text-[11px] text-zinc-600">
                      {character.release_date}
                    </span>
                  )}
                </div>
              </article>
            )
          })}
        </div>
      )}
    </UmamusumeLayout>
  )
}

export default UmamusumeCharacters

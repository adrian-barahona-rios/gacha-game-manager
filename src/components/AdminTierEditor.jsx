import { useEffect, useState } from 'react'
import { AlertCircle, Check, Loader2 } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { TIER_LIST_GAMES, TIER_RATINGS } from '../data/adminConfig'

const selectClasses =
  'w-full rounded-xl border border-white/10 bg-white/[0.03] px-4 py-3 text-[15px] text-white transition-all duration-300 hover:border-white/20 focus:border-white/30 focus:bg-white/[0.06] focus:outline-none focus:ring-4 focus:ring-white/5'

function AdminTierEditor() {
  const { t } = useI18n()
  const [gameId, setGameId] = useState(TIER_LIST_GAMES[0].id)
  const [mode, setMode] = useState(TIER_LIST_GAMES[0].modes[0])
  // Los datos guardan a que juego y modo pertenecen: mientras no coincidan con
  // los seleccionados, la lista sigue cargando. Asi no hace falta un setState
  // sincrono dentro del efecto.
  const [loaded, setLoaded] = useState(null)
  const [savingId, setSavingId] = useState('')
  const [savedId, setSavedId] = useState('')
  const [error, setError] = useState('')

  const game = TIER_LIST_GAMES.find((item) => item.id === gameId)
  const isLoading = loaded?.gameId !== gameId || loaded?.mode !== mode
  const characters = isLoading ? [] : loaded.characters
  const ratings = isLoading ? {} : loaded.ratings

  useEffect(() => {
    let active = true

    Promise.all([
      supabase.from('characters').select('id, name, element, rarity').eq('game_id', gameId).order('name'),
      supabase.from('tier_lists_oficial').select('character_id, rating').eq('game_id', gameId).eq('mode', mode),
    ]).then(([charactersResult, ratingsResult]) => {
      if (!active) {
        return
      }

      if (charactersResult.error || ratingsResult.error) {
        setError(
          t('characters.error.load', {
            message: (charactersResult.error ?? ratingsResult.error).message,
          }),
        )
      } else {
        setLoaded({
          gameId,
          mode,
          characters: charactersResult.data,
          ratings: Object.fromEntries(
            ratingsResult.data.map((row) => [row.character_id, Number(row.rating)]),
          ),
        })
        setError('')
      }
    })

    return () => {
      active = false
    }
  }, [gameId, mode, t])

  const handleChange = async (characterId, value) => {
    setSavingId(characterId)
    setSavedId('')
    setError('')

    // El valor vacio quita la valoracion en lugar de guardar un cero.
    const result =
      value === ''
        ? await supabase
            .from('tier_lists_oficial')
            .delete()
            .eq('game_id', gameId)
            .eq('mode', mode)
            .eq('character_id', characterId)
        : await supabase.from('tier_lists_oficial').upsert(
            {
              game_id: gameId,
              mode,
              character_id: characterId,
              rating: Number(value),
              updated_at: new Date().toISOString(),
            },
            { onConflict: 'game_id,mode,character_id' },
          )

    setSavingId('')

    if (result.error) {
      setError(t('tierlist.error.save', { message: result.error.message }))
      return
    }

    setLoaded((current) => {
      if (!current) {
        return current
      }
      const next = { ...current.ratings }
      if (value === '') {
        delete next[characterId]
      } else {
        next[characterId] = Number(value)
      }
      return { ...current, ratings: next }
    })
    setSavedId(characterId)
  }

  return (
    <div className="space-y-5">
      {error && (
        <div className="flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-[13px] text-red-200">
          <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
          <p>{error}</p>
        </div>
      )}

      <div className="grid gap-4 sm:grid-cols-2">
        <label className="block">
          <span className="mb-2 block text-[13px] font-medium tracking-wide text-zinc-400">
            {t('admin.field.game')}
          </span>
          <select
            value={gameId}
            onChange={(event) => {
              const next = TIER_LIST_GAMES.find((item) => item.id === event.target.value)
              setGameId(next.id)
              setMode(next.modes[0])
            }}
            className={selectClasses}
          >
            {TIER_LIST_GAMES.map((option) => (
              <option key={option.id} value={option.id} className="bg-[#111114]">
                {option.name}
              </option>
            ))}
          </select>
        </label>

        <label className="block">
          <span className="mb-2 block text-[13px] font-medium tracking-wide text-zinc-400">
            {t('tierlist.mode')}
          </span>
          <select
            value={mode}
            onChange={(event) => setMode(event.target.value)}
            disabled={game.modes.length === 1}
            className={`${selectClasses} disabled:cursor-not-allowed disabled:opacity-60`}
          >
            {game.modes.map((option) => (
              <option key={option} value={option} className="bg-[#111114]">
                {option}
              </option>
            ))}
          </select>
        </label>
      </div>

      <p className="text-xs text-zinc-500">{t('admin.tierScale')}</p>

      {isLoading ? (
        <div className="flex items-center justify-center gap-3 py-10 text-sm text-zinc-500">
          <Loader2 className="h-4 w-4 animate-spin" />
          {t('common.loading')}
        </div>
      ) : (
        <ul className="divide-y divide-white/5 overflow-hidden rounded-2xl border border-white/10">
          {characters.map((character) => (
            <li
              key={character.id}
              className="flex items-center gap-4 bg-white/[0.02] px-4 py-3 transition-colors duration-200 hover:bg-white/[0.05]"
            >
              <span className="min-w-0 flex-1">
                <span className="block truncate text-[15px] text-white">{character.name}</span>
                <span className="block truncate text-xs text-zinc-500">
                  {[character.element, character.rarity].filter(Boolean).join(' · ') || character.id}
                </span>
              </span>

              {savingId === character.id && (
                <Loader2 className="h-4 w-4 shrink-0 animate-spin text-zinc-400" />
              )}
              {savedId === character.id && savingId !== character.id && (
                <Check className="h-4 w-4 shrink-0 text-emerald-400" />
              )}

              <select
                value={ratings[character.id] ?? ''}
                onChange={(event) => handleChange(character.id, event.target.value)}
                className="w-28 shrink-0 rounded-lg border border-white/10 bg-white/[0.03] px-3 py-2 text-sm text-white transition-colors duration-200 hover:border-white/25 focus:border-white/40 focus:outline-none focus:ring-4 focus:ring-white/10"
              >
                <option value="" className="bg-[#111114]">
                  —
                </option>
                {TIER_RATINGS.map((rating) => (
                  <option key={rating} value={rating} className="bg-[#111114]">
                    {rating}
                  </option>
                ))}
              </select>
            </li>
          ))}
        </ul>
      )}
    </div>
  )
}

export default AdminTierEditor

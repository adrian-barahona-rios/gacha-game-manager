import { useEffect, useState } from 'react'
import { AlertCircle, Check, Loader2, Save } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { BIOGRAPHY_GAMES } from '../data/adminConfig'

const controlClasses =
  'w-full rounded-xl border border-white/10 bg-white/[0.03] px-4 py-3 text-[15px] text-white placeholder:text-zinc-600 transition-all duration-300 hover:border-white/20 focus:border-white/30 focus:bg-white/[0.06] focus:outline-none focus:ring-4 focus:ring-white/5'

const EMPTY = { mode: 'General', equipment_build: '', stats: '', variations: '', source: '' }

function AdminMetaGuides() {
  const { t } = useI18n()
  const [gameId, setGameId] = useState(BIOGRAPHY_GAMES[0].id)
  const [loaded, setLoaded] = useState(null)
  const [characterId, setCharacterId] = useState('')
  const [form, setForm] = useState(EMPTY)
  const [isSaving, setIsSaving] = useState(false)
  const [isSaved, setIsSaved] = useState(false)
  const [error, setError] = useState('')

  const isLoading = loaded?.gameId !== gameId
  const characters = isLoading ? [] : loaded.characters

  useEffect(() => {
    let active = true

    supabase
      .from('characters')
      .select('id, name')
      .eq('game_id', gameId)
      .order('name')
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(t('characters.error.load', { message: loadError.message }))
        } else {
          setLoaded({ gameId, characters: data })
          setCharacterId(data[0]?.id ?? '')
          setError('')
        }
        setIsSaved(false)
      })

    return () => {
      active = false
    }
  }, [gameId, t])

  // Al elegir personaje se trae su build, si ya existe.
  useEffect(() => {
    if (!characterId) {
      return undefined
    }

    let active = true

    supabase
      .from('character_meta_guides')
      .select('mode, equipment_build, stats, variations, source')
      .eq('character_id', characterId)
      .maybeSingle()
      .then(({ data }) => {
        if (active) {
          setForm(data ? { ...EMPTY, ...data } : EMPTY)
          setIsSaved(false)
        }
      })

    return () => {
      active = false
    }
  }, [characterId])

  const set = (field) => (event) => {
    setForm((current) => ({ ...current, [field]: event.target.value }))
    setIsSaved(false)
    setError('')
  }

  const handleSave = async () => {
    if (!characterId) {
      return
    }

    setIsSaving(true)
    setIsSaved(false)
    setError('')

    const { error: saveError } = await supabase.from('character_meta_guides').upsert(
      {
        game_id: gameId,
        character_id: characterId,
        mode: form.mode.trim() || 'General',
        equipment_build: form.equipment_build.trim() || null,
        stats: form.stats.trim() || null,
        variations: form.variations.trim() || null,
        source: form.source.trim() || null,
        updated_at: new Date().toISOString(),
      },
      { onConflict: 'character_id,mode' },
    )

    setIsSaving(false)

    if (saveError) {
      setError(t('guides.form.error.save', { message: saveError.message }))
      return
    }

    setIsSaved(true)
  }

  const FIELDS = [
    { field: 'equipment_build', labelKey: 'guides.meta.equipment', rows: 6 },
    { field: 'stats', labelKey: 'guides.meta.stats', rows: 5 },
    { field: 'variations', labelKey: 'guides.meta.variations', rows: 5 },
  ]

  return (
    <div className="space-y-5">
      {error && (
        <div className="flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-[13px] text-red-200">
          <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
          <p>{error}</p>
        </div>
      )}

      <div className="grid gap-4 sm:grid-cols-3">
        <label className="block">
          <span className="mb-2 block text-[13px] font-medium tracking-wide text-zinc-400">
            {t('admin.field.game')}
          </span>
          <select
            value={gameId}
            onChange={(event) => setGameId(event.target.value)}
            className={controlClasses}
          >
            {BIOGRAPHY_GAMES.map((game) => (
              <option key={game.id} value={game.id} className="bg-[#111114]">
                {game.name}
              </option>
            ))}
          </select>
        </label>

        <label className="block">
          <span className="mb-2 block text-[13px] font-medium tracking-wide text-zinc-400">
            {t('admin.field.character')}
          </span>
          <select
            value={characterId}
            onChange={(event) => setCharacterId(event.target.value)}
            disabled={isLoading}
            className={`${controlClasses} disabled:cursor-not-allowed disabled:opacity-60`}
          >
            {characters.map((character) => (
              <option key={character.id} value={character.id} className="bg-[#111114]">
                {character.name}
              </option>
            ))}
          </select>
        </label>

        <label className="block">
          <span className="mb-2 block text-[13px] font-medium tracking-wide text-zinc-400">
            {t('tierlist.mode')}
          </span>
          <input type="text" value={form.mode} onChange={set('mode')} className={controlClasses} />
        </label>
      </div>

      {isLoading ? (
        <div className="flex items-center justify-center gap-3 py-10 text-sm text-zinc-500">
          <Loader2 className="h-4 w-4 animate-spin" />
          {t('common.loading')}
        </div>
      ) : (
        <>
          {FIELDS.map((item) => (
            <label key={item.field} className="block">
              <span className="mb-2 block text-[13px] font-medium tracking-wide text-zinc-400">
                {t(item.labelKey)}
              </span>
              <textarea
                rows={item.rows}
                value={form[item.field]}
                onChange={set(item.field)}
                className={`${controlClasses} resize-y leading-7`}
              />
            </label>
          ))}

          <label className="block">
            <span className="mb-2 block text-[13px] font-medium tracking-wide text-zinc-400">
              {t('character.officialSource')}
            </span>
            <input
              type="url"
              value={form.source}
              onChange={set('source')}
              placeholder="https://"
              className={controlClasses}
            />
          </label>

          <div className="flex flex-wrap items-center gap-4">
            <button
              type="button"
              onClick={handleSave}
              disabled={isSaving || !characterId}
              className="flex items-center justify-center gap-2 rounded-xl bg-white px-5 py-3 text-sm font-semibold text-black transition-all duration-300 hover:-translate-y-0.5 hover:bg-amber-500 hover:text-white hover:shadow-[0_0_25px_rgba(245,158,11,0.5)] focus:outline-none focus:ring-4 focus:ring-amber-500/30 active:translate-y-0 active:scale-95 disabled:cursor-not-allowed disabled:opacity-60"
            >
              {isSaving ? <Loader2 className="h-4 w-4 animate-spin" /> : <Save className="h-4 w-4" />}
              {t('admin.saveMetaGuide')}
            </button>

            {isSaved && (
              <span className="flex items-center gap-2 text-sm text-emerald-400">
                <Check className="h-4 w-4" />
                {t('profile.saved')}
              </span>
            )}
          </div>
        </>
      )}
    </div>
  )
}

export default AdminMetaGuides

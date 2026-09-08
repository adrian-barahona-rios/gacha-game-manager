import { useEffect, useState } from 'react'
import { AlertCircle, Check, Loader2, Save } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { BIOGRAPHY_GAMES } from '../data/adminConfig'

const controlClasses =
  'w-full rounded-xl border border-white/10 bg-white/[0.03] px-4 py-3 text-[15px] text-white placeholder:text-zinc-600 transition-all duration-300 hover:border-white/20 focus:border-white/30 focus:bg-white/[0.06] focus:outline-none focus:ring-4 focus:ring-white/5'

function AdminBiographyEditor() {
  const { t } = useI18n()
  const [gameId, setGameId] = useState(BIOGRAPHY_GAMES[0].id)
  // El juego al que pertenece la lista viaja con ella: mientras no coincida con
  // el seleccionado, seguimos cargando. Evita un setState dentro del efecto.
  const [loaded, setLoaded] = useState(null)
  const [characterId, setCharacterId] = useState('')
  const [biographyEs, setBiographyEs] = useState('')
  const [biographyEn, setBiographyEn] = useState('')
  const [isSaving, setIsSaving] = useState(false)
  const [isSaved, setIsSaved] = useState(false)
  const [error, setError] = useState('')

  const isLoading = loaded?.gameId !== gameId
  const characters = isLoading ? [] : loaded.characters

  useEffect(() => {
    let active = true

    supabase
      .from('characters')
      .select('id, name, biography_es, biography_en')
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
          setBiographyEs(data[0]?.biography_es ?? '')
          setBiographyEn(data[0]?.biography_en ?? '')
          setError('')
        }

        setIsSaved(false)
      })

    return () => {
      active = false
    }
  }, [gameId, t])

  const selectCharacter = (id) => {
    const character = characters.find((item) => item.id === id)
    setCharacterId(id)
    setBiographyEs(character?.biography_es ?? '')
    setBiographyEn(character?.biography_en ?? '')
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

    const { error: saveError } = await supabase
      .from('characters')
      .update({
        biography_es: biographyEs.trim() || null,
        biography_en: biographyEn.trim() || null,
      })
      .eq('id', characterId)

    setIsSaving(false)

    if (saveError) {
      setError(t('tierlist.error.save', { message: saveError.message }))
      return
    }

    // Mantiene la lista en memoria al dia para no recargarla entera.
    setLoaded((current) =>
      current
        ? {
            ...current,
            characters: current.characters.map((item) =>
              item.id === characterId
                ? { ...item, biography_es: biographyEs, biography_en: biographyEn }
                : item,
            ),
          }
        : current,
    )
    setIsSaved(true)
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
            onChange={(event) => setGameId(event.target.value)}
            className={controlClasses}
          >
            {BIOGRAPHY_GAMES.map((option) => (
              <option key={option.id} value={option.id} className="bg-[#111114]">
                {option.name}
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
            onChange={(event) => selectCharacter(event.target.value)}
            disabled={isLoading || characters.length === 0}
            className={`${controlClasses} disabled:cursor-not-allowed disabled:opacity-60`}
          >
            {characters.map((character) => (
              <option key={character.id} value={character.id} className="bg-[#111114]">
                {character.name}
              </option>
            ))}
          </select>
        </label>
      </div>

      {isLoading ? (
        <div className="flex items-center justify-center gap-3 py-10 text-sm text-zinc-500">
          <Loader2 className="h-4 w-4 animate-spin" />
          {t('common.loading')}
        </div>
      ) : (
        <>
          <label className="block">
            <span className="mb-2 flex items-baseline justify-between gap-3 text-[13px] font-medium tracking-wide text-zinc-400">
              {t('admin.field.biographyEs')}
              <span className="text-xs text-zinc-600">
                {t('admin.characterCount', { count: biographyEs.length })}
              </span>
            </span>
            <textarea
              rows={14}
              value={biographyEs}
              onChange={(event) => {
                setBiographyEs(event.target.value)
                setIsSaved(false)
              }}
              className={`${controlClasses} resize-y leading-7`}
            />
          </label>

          <label className="block">
            <span className="mb-2 flex items-baseline justify-between gap-3 text-[13px] font-medium tracking-wide text-zinc-400">
              {t('admin.field.biographyEn')}
              <span className="text-xs text-zinc-600">
                {t('admin.characterCount', { count: biographyEn.length })}
              </span>
            </span>
            <textarea
              rows={14}
              value={biographyEn}
              onChange={(event) => {
                setBiographyEn(event.target.value)
                setIsSaved(false)
              }}
              className={`${controlClasses} resize-y leading-7`}
            />
          </label>

          <div className="flex flex-wrap items-center gap-4">
            <button
              type="button"
              onClick={handleSave}
              disabled={isSaving || !characterId}
              className="flex items-center justify-center gap-2 rounded-xl bg-white px-5 py-3 text-sm font-semibold text-black transition-all duration-300 hover:-translate-y-0.5 hover:bg-[#0066ff] hover:text-white hover:shadow-[0_0_25px_rgba(0,102,255,0.6)] focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:translate-y-0 active:scale-95 disabled:cursor-not-allowed disabled:opacity-60"
            >
              {isSaving ? <Loader2 className="h-4 w-4 animate-spin" /> : <Save className="h-4 w-4" />}
              {t('admin.saveBiography')}
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

export default AdminBiographyEditor

import { useState } from 'react'
import { AlertCircle, Check, Loader2, UserPlus } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { ADMIN_GAMES, buildCharacterId, getAdminGame } from '../data/adminConfig'

const EMPTY = {
  name: '',
  element: '',
  rarity: '',
  role: '',
  path: '',
  signature: '',
  description: '',
  biographyEs: '',
  biographyEn: '',
  version: 'global',
  baseCharacter: '',
}

const inputClasses =
  'w-full rounded-xl border border-white/10 bg-white/[0.03] px-4 py-3 text-[15px] text-white placeholder:text-zinc-600 transition-all duration-300 hover:border-white/20 focus:border-white/30 focus:bg-white/[0.06] focus:outline-none focus:ring-4 focus:ring-white/5'

function Field({ label, children }) {
  return (
    <label className="block">
      <span className="mb-2 block text-[13px] font-medium tracking-wide text-zinc-400">
        {label}
      </span>
      {children}
    </label>
  )
}

function AdminCharacterForm() {
  const { t } = useI18n()
  const [gameId, setGameId] = useState(ADMIN_GAMES[0].id)
  const [form, setForm] = useState(EMPTY)
  const [isSaving, setIsSaving] = useState(false)
  const [error, setError] = useState('')
  const [savedId, setSavedId] = useState('')

  const game = getAdminGame(gameId)
  const isUmamusume = game.table === 'umamusume_characters'
  const characterId = buildCharacterId(game.prefix, form.name.trim())

  const set = (key) => (event) => {
    setForm((current) => ({ ...current, [key]: event.target.value }))
    setSavedId('')
    setError('')
  }

  const handleSubmit = async (event) => {
    event.preventDefault()
    setError('')
    setSavedId('')

    if (form.name.trim().length < 2) {
      setError(t('admin.error.name'))
      return
    }

    setIsSaving(true)

    const row = isUmamusume
      ? {
          version: form.version,
          id: characterId,
          name: form.name.trim(),
          base_character: form.baseCharacter.trim() || null,
          rarity: form.rarity || null,
        }
      : {
          id: characterId,
          game_id: gameId,
          name: form.name.trim(),
          rarity: form.rarity || null,
          element: form.element || null,
          level_cap: game.levelCap ?? null,
          role: form.role.trim() || null,
          path: form.path.trim() || null,
          signature: form.signature.trim() || null,
          description: form.description.trim() || null,
          biography_es: form.biographyEs.trim() || null,
          biography_en: form.biographyEn.trim() || null,
        }

    const { error: insertError } = await supabase.from(game.table).insert(row)
    setIsSaving(false)

    if (insertError) {
      setError(
        insertError.code === '23505'
          ? t('admin.error.duplicate', { id: characterId })
          : t('admin.error.insert', { message: insertError.message }),
      )
      return
    }

    setSavedId(characterId)
    setForm(EMPTY)
  }

  return (
    <form onSubmit={handleSubmit} noValidate className="space-y-5">
      {error && (
        <div className="flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-[13px] text-red-200">
          <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
          <p>{error}</p>
        </div>
      )}

      {savedId && (
        <div className="flex items-start gap-3 rounded-xl border border-emerald-500/30 bg-emerald-500/10 px-4 py-3 text-[13px] text-emerald-200">
          <Check className="mt-0.5 h-4 w-4 shrink-0" />
          <p>{t('admin.added', { id: savedId })}</p>
        </div>
      )}

      <Field label={t('admin.field.game')}>
        <select
          value={gameId}
          onChange={(event) => {
            setGameId(event.target.value)
            setForm(EMPTY)
            setSavedId('')
            setError('')
          }}
          className={inputClasses}
        >
          {ADMIN_GAMES.map((option) => (
            <option key={option.id} value={option.id} className="bg-[#111114]">
              {option.name}
            </option>
          ))}
        </select>
      </Field>

      {isUmamusume && (
        <Field label={t('admin.field.version')}>
          <select value={form.version} onChange={set('version')} className={inputClasses}>
            {game.versions.map((version) => (
              <option key={version} value={version} className="bg-[#111114]">
                {t(`uma.version.${version}`)}
              </option>
            ))}
          </select>
        </Field>
      )}

      <Field label={t('admin.field.name')}>
        <input
          type="text"
          value={form.name}
          onChange={set('name')}
          placeholder={t('admin.field.namePlaceholder')}
          className={inputClasses}
        />
      </Field>

      {characterId && (
        <p className="-mt-2 text-xs text-zinc-500">
          {t('admin.generatedId')} <code className="text-zinc-300">{characterId}</code>
        </p>
      )}

      {game.elements && (
        <Field label={t(game.elementKey)}>
          <select value={form.element} onChange={set('element')} className={inputClasses}>
            <option value="" className="bg-[#111114]">
              {t('admin.field.none')}
            </option>
            {game.elements.map((element) => (
              <option key={element} value={element} className="bg-[#111114]">
                {element}
              </option>
            ))}
          </select>
        </Field>
      )}

      {game.rarities && (
        <Field label={t('admin.field.rarity')}>
          <select value={form.rarity} onChange={set('rarity')} className={inputClasses}>
            <option value="" className="bg-[#111114]">
              {t('admin.field.none')}
            </option>
            {game.rarities.map((rarity) => (
              <option key={rarity} value={rarity} className="bg-[#111114]">
                {rarity}
              </option>
            ))}
          </select>
        </Field>
      )}

      {game.baseCharacter && (
        <Field label={t('admin.field.baseCharacter')}>
          <input
            type="text"
            value={form.baseCharacter}
            onChange={set('baseCharacter')}
            className={inputClasses}
          />
        </Field>
      )}

      {game.roleKey && (
        <Field label={t(game.roleKey)}>
          <input type="text" value={form.role} onChange={set('role')} className={inputClasses} />
        </Field>
      )}

      {game.pathKey && (
        <Field label={t(game.pathKey)}>
          <input type="text" value={form.path} onChange={set('path')} className={inputClasses} />
        </Field>
      )}

      {game.signatureKey && (
        <Field label={t(game.signatureKey)}>
          <input
            type="text"
            value={form.signature}
            onChange={set('signature')}
            className={inputClasses}
          />
        </Field>
      )}

      {!isUmamusume && (
        <>
          <Field label={t('admin.field.description')}>
            <input
              type="text"
              value={form.description}
              onChange={set('description')}
              className={inputClasses}
            />
          </Field>

          <Field label={t('admin.field.biographyEs')}>
            <textarea
              rows={7}
              value={form.biographyEs}
              onChange={set('biographyEs')}
              className={`${inputClasses} resize-y leading-7`}
            />
          </Field>

          <Field label={t('admin.field.biographyEn')}>
            <textarea
              rows={7}
              value={form.biographyEn}
              onChange={set('biographyEn')}
              className={`${inputClasses} resize-y leading-7`}
            />
          </Field>
        </>
      )}

      <button
        type="submit"
        disabled={isSaving}
        className="flex items-center justify-center gap-2 rounded-xl bg-white px-5 py-3 text-sm font-semibold text-black transition-all duration-300 hover:-translate-y-0.5 hover:bg-emerald-500 hover:text-white hover:shadow-[0_0_25px_rgba(16,185,129,0.55)] focus:outline-none focus:ring-4 focus:ring-emerald-500/30 active:translate-y-0 active:scale-95 disabled:cursor-not-allowed disabled:opacity-60"
      >
        {isSaving ? (
          <Loader2 className="h-4 w-4 animate-spin" />
        ) : (
          <UserPlus className="h-4 w-4" />
        )}
        {t('admin.addCharacter')}
      </button>
    </form>
  )
}

export default AdminCharacterForm

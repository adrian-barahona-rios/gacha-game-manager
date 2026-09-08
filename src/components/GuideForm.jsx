import { useEffect, useState } from 'react'
import { useNavigate, useParams, useSearchParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, Loader2, Save, Trash2 } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { BIOGRAPHY_GAMES } from '../data/adminConfig'

const controlClasses =
  'w-full rounded-xl border border-white/10 bg-white/[0.03] px-4 py-3 text-[15px] text-white placeholder:text-zinc-600 transition-all duration-300 hover:border-white/20 focus:border-white/30 focus:bg-white/[0.06] focus:outline-none focus:ring-4 focus:ring-white/5'

function GuideForm() {
  const { t } = useI18n()
  const navigate = useNavigate()
  const { guideId } = useParams()
  const [searchParams] = useSearchParams()
  const isEditing = Boolean(guideId)

  const [form, setForm] = useState(() => ({
    gameId: searchParams.get('game') ?? BIOGRAPHY_GAMES[0].id,
    characterId: searchParams.get('character') ?? '',
    title: '',
    content: '',
  }))
  const [isReady, setIsReady] = useState(!isEditing)
  const [characters, setCharacters] = useState(null)
  const [isSaving, setIsSaving] = useState(false)
  const [error, setError] = useState('')

  const charactersLoading = characters?.gameId !== form.gameId
  const options = charactersLoading ? [] : characters.rows

  useEffect(() => {
    if (!isEditing) {
      return undefined
    }

    let active = true

    supabase
      .from('user_guides')
      .select('game_id, character_id, title, content')
      .eq('id', guideId)
      .maybeSingle()
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError || !data) {
          setError(t('guides.form.notFound'))
        } else {
          setForm({
            gameId: data.game_id,
            characterId: data.character_id,
            title: data.title,
            content: data.content,
          })
        }
        setIsReady(true)
      })

    return () => {
      active = false
    }
  }, [guideId, isEditing, t])

  useEffect(() => {
    let active = true

    supabase
      .from('characters')
      .select('id, name')
      .eq('game_id', form.gameId)
      .order('name')
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(t('characters.error.load', { message: loadError.message }))
        } else {
          setCharacters({ gameId: form.gameId, rows: data })
        }
      })

    return () => {
      active = false
    }
  }, [form.gameId, t])

  const set = (field) => (event) => {
    setForm((current) => ({ ...current, [field]: event.target.value }))
    setError('')
  }

  const handleSubmit = async (event) => {
    event.preventDefault()
    setError('')

    if (!form.characterId) {
      setError(t('guides.form.error.character'))
      return
    }
    if (form.title.trim().length < 3) {
      setError(t('guides.form.error.title'))
      return
    }
    if (form.content.trim().length < 10) {
      setError(t('guides.form.error.content'))
      return
    }

    setIsSaving(true)

    let result
    if (isEditing) {
      result = await supabase
        .from('user_guides')
        .update({
          game_id: form.gameId,
          character_id: form.characterId,
          title: form.title.trim(),
          content: form.content.trim(),
        })
        .eq('id', guideId)
        .select('id')
        .maybeSingle()
    } else {
      const { data: session } = await supabase.auth.getSession()
      if (!session.session) {
        setIsSaving(false)
        navigate('/login')
        return
      }
      result = await supabase
        .from('user_guides')
        .insert({
          user_id: session.session.user.id,
          game_id: form.gameId,
          character_id: form.characterId,
          title: form.title.trim(),
          content: form.content.trim(),
        })
        .select('id')
        .maybeSingle()
    }

    setIsSaving(false)

    if (result.error) {
      setError(t('guides.form.error.save', { message: result.error.message }))
      return
    }

    navigate(`/profile/my-guides/${result.data?.id ?? guideId}`, { replace: true })
  }

  const handleDelete = async () => {
    setIsSaving(true)
    const { error: deleteError } = await supabase.from('user_guides').delete().eq('id', guideId)
    setIsSaving(false)

    if (deleteError) {
      setError(t('guides.form.error.save', { message: deleteError.message }))
      return
    }

    navigate('/profile/my-guides', { replace: true })
  }

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <div className="pointer-events-none fixed inset-0" aria-hidden="true">
        <div className="absolute inset-0 bg-[linear-gradient(to_right,rgba(255,255,255,0.035)_1px,transparent_1px),linear-gradient(to_bottom,rgba(255,255,255,0.035)_1px,transparent_1px)] bg-[size:64px_64px] [mask-image:radial-gradient(ellipse_at_center,black_10%,transparent_70%)]" />
      </div>

      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-3xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(-1)}
            aria-label={t('common.back')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <h1 className="min-w-0 flex-1 truncate text-lg font-semibold tracking-tight text-white sm:text-xl">
            {t(isEditing ? 'guides.form.editTitle' : 'guides.form.newTitle')}
          </h1>
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-3xl px-4 py-10 sm:px-6 sm:py-14">
        {!isReady ? (
          <div className="flex items-center justify-center gap-3 py-10 text-sm text-zinc-500">
            <Loader2 className="h-4 w-4 animate-spin" />
            {t('common.loading')}
          </div>
        ) : (
          <form onSubmit={handleSubmit} noValidate className="space-y-5">
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
                <select value={form.gameId} onChange={set('gameId')} className={controlClasses}>
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
                  value={form.characterId}
                  onChange={set('characterId')}
                  disabled={charactersLoading}
                  className={`${controlClasses} disabled:cursor-not-allowed disabled:opacity-60`}
                >
                  <option value="" className="bg-[#111114]">
                    {t('guides.form.pickCharacter')}
                  </option>
                  {options.map((character) => (
                    <option key={character.id} value={character.id} className="bg-[#111114]">
                      {character.name}
                    </option>
                  ))}
                </select>
              </label>
            </div>

            <label className="block">
              <span className="mb-2 block text-[13px] font-medium tracking-wide text-zinc-400">
                {t('guides.form.title')}
              </span>
              <input
                type="text"
                value={form.title}
                onChange={set('title')}
                placeholder={t('guides.form.titlePlaceholder')}
                className={controlClasses}
              />
            </label>

            <label className="block">
              <span className="mb-2 flex items-baseline justify-between gap-3 text-[13px] font-medium tracking-wide text-zinc-400">
                {t('guides.form.content')}
                <span className="text-xs text-zinc-600">
                  {t('admin.characterCount', { count: form.content.length })}
                </span>
              </span>
              <textarea
                rows={16}
                value={form.content}
                onChange={set('content')}
                placeholder={t('guides.form.contentPlaceholder')}
                className={`${controlClasses} resize-y leading-7`}
              />
            </label>

            <div className="flex flex-wrap items-center gap-3">
              <button
                type="submit"
                disabled={isSaving}
                className="flex items-center justify-center gap-2 rounded-xl bg-white px-5 py-3 text-sm font-semibold text-black transition-all duration-300 hover:-translate-y-0.5 hover:bg-[#0066ff] hover:text-white hover:shadow-[0_0_25px_rgba(0,102,255,0.6)] focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:translate-y-0 active:scale-95 disabled:cursor-not-allowed disabled:opacity-60"
              >
                {isSaving ? <Loader2 className="h-4 w-4 animate-spin" /> : <Save className="h-4 w-4" />}
                {t('guides.form.save')}
              </button>

              {isEditing && (
                <button
                  type="button"
                  onClick={handleDelete}
                  disabled={isSaving}
                  className="flex items-center justify-center gap-2 rounded-xl border border-white/15 bg-transparent px-5 py-3 text-sm font-semibold text-zinc-300 transition-all duration-300 hover:border-red-500 hover:bg-red-500/15 hover:text-white focus:outline-none focus:ring-4 focus:ring-red-500/30 active:scale-95 disabled:cursor-not-allowed disabled:opacity-60"
                >
                  <Trash2 className="h-4 w-4" />
                  {t('guides.form.delete')}
                </button>
              )}
            </div>
          </form>
        )}
      </main>
    </div>
  )
}

export default GuideForm

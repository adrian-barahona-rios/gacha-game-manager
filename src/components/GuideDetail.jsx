import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, Loader2, Pencil } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'

function GuideDetail() {
  const { t, activeLanguage } = useI18n()
  const navigate = useNavigate()
  const { guideId } = useParams()
  const [loaded, setLoaded] = useState(null)
  const [error, setError] = useState('')

  const isLoading = loaded?.guideId !== guideId
  const guide = isLoading ? null : loaded.guide

  useEffect(() => {
    let active = true

    supabase
      .from('user_guides')
      .select('id, title, content, game_id, character_id, updated_at, characters (name)')
      .eq('id', guideId)
      .maybeSingle()
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(t('guides.mine.error', { message: loadError.message }))
        } else {
          setLoaded({ guideId, guide: data })
          setError('')
        }
      })

    return () => {
      active = false
    }
  }, [guideId, t])

  const game = guide ? getGameById(guide.game_id) : null
  const paragraphs = guide
    ? guide.content
        .split(/\n+/)
        .map((paragraph) => paragraph.trim())
        .filter(Boolean)
    : []

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <div className="pointer-events-none fixed inset-0" aria-hidden="true">
        <div className="absolute inset-0 bg-[linear-gradient(to_right,rgba(255,255,255,0.035)_1px,transparent_1px),linear-gradient(to_bottom,rgba(255,255,255,0.035)_1px,transparent_1px)] bg-[size:64px_64px] [mask-image:radial-gradient(ellipse_at_center,black_10%,transparent_70%)]" />
      </div>

      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-3xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate('/profile/my-guides')}
            aria-label={t('common.back')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">
              {guide?.title ?? t('guides.mine.title')}
            </h1>
            {guide && (
              <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>
                {[guide.characters?.name, game?.name].filter(Boolean).join(' · ')}
              </p>
            )}
          </div>

          {guide && (
            <button
              type="button"
              onClick={() => navigate(`/profile/my-guides/${guide.id}/edit`)}
              className="flex shrink-0 items-center gap-2 rounded-lg bg-white px-3 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:bg-[#0066ff] hover:text-white focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:scale-95 sm:px-4"
            >
              <Pencil className="h-4 w-4" />
              <span className="hidden sm:inline">{t('guides.detail.edit')}</span>
            </button>
          )}
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-3xl px-4 py-10 sm:px-6 sm:py-14">
        {error && (
          <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
            <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{error}</p>
          </div>
        )}

        {isLoading ? (
          <div className="flex items-center justify-center gap-3 py-10 text-sm text-zinc-500">
            <Loader2 className="h-4 w-4 animate-spin" />
            {t('common.loading')}
          </div>
        ) : !guide ? (
          <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
            <p className="text-zinc-400">{t('guides.form.notFound')}</p>
          </div>
        ) : (
          <article className="rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
            <p className="mb-6 text-xs text-zinc-600">
              {t('guides.detail.updated', {
                date: new Date(guide.updated_at).toLocaleDateString(
                  activeLanguage === 'en' ? 'en-GB' : 'es-ES',
                  { day: 'numeric', month: 'long', year: 'numeric' },
                ),
              })}
            </p>

            <div className="space-y-5">
              {paragraphs.map((paragraph, index) => (
                <p key={index} className="text-[15px] leading-7 text-zinc-300">
                  {paragraph}
                </p>
              ))}
            </div>
          </article>
        )}
      </main>
    </div>
  )
}

export default GuideDetail

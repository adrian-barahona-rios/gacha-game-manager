import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { AlertCircle, ArrowLeft, BookOpen, Loader2, NotebookPen, Plus } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'

function formatDate(value, language) {
  try {
    return new Date(value).toLocaleDateString(language === 'en' ? 'en-GB' : 'es-ES', {
      day: 'numeric',
      month: 'short',
      year: 'numeric',
    })
  } catch {
    return ''
  }
}

// Sirve para las dos pantallas: la pagina /profile/my-guides con todas las
// guias, y la seccion central de la pagina de guias de un personaje. Con
// `characterId` la lista se acota a ese personaje.
function MyGuides({ gameId, characterId, embedded }) {
  const { t, activeLanguage } = useI18n()
  const navigate = useNavigate()
  const [loaded, setLoaded] = useState(null)
  const [error, setError] = useState('')

  const key = characterId ?? 'todas'
  const isLoading = loaded?.key !== key
  const guides = isLoading ? [] : loaded.guides

  useEffect(() => {
    let active = true

    let query = supabase
      .from('user_guides')
      .select('id, title, content, game_id, character_id, updated_at, characters (name)')
      .order('updated_at', { ascending: false })

    if (characterId) {
      query = query.eq('character_id', characterId)
    }

    query.then(({ data, error: loadError }) => {
      if (!active) {
        return
      }
      if (loadError) {
        setError(t('guides.mine.error', { message: loadError.message }))
      } else {
        setLoaded({ key, guides: data })
        setError('')
      }
    })

    return () => {
      active = false
    }
  }, [characterId, key, t])

  const newGuideHref = characterId
    ? `/profile/my-guides/new?game=${gameId}&character=${characterId}`
    : '/profile/my-guides/new'

  const list = (
    <>
      {error && (
        <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-[13px] text-red-200">
          <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
          <p>{error}</p>
        </div>
      )}

      {isLoading ? (
        <div className="flex items-center justify-center gap-3 py-10 text-sm text-zinc-500">
          <Loader2 className="h-4 w-4 animate-spin" />
          {t('common.loading')}
        </div>
      ) : guides.length === 0 ? (
        <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-10 text-center">
          <NotebookPen className="mx-auto mb-4 h-9 w-9 text-zinc-600" />
          <p className="mb-5 text-sm text-zinc-400">{t('guides.mine.empty')}</p>
          <button
            type="button"
            onClick={() => navigate(newGuideHref)}
            className="inline-flex items-center gap-2 rounded-lg bg-white px-4 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:bg-[#0066ff] hover:text-white active:scale-95"
          >
            <Plus className="h-4 w-4" />
            {t('guides.mine.create')}
          </button>
        </div>
      ) : (
        <ul className="space-y-3">
          {guides.map((guide) => {
            const game = getGameById(guide.game_id)

            return (
              <li key={guide.id}>
                <button
                  type="button"
                  onClick={() => navigate(`/profile/my-guides/${guide.id}`)}
                  className="flex w-full items-center gap-4 rounded-2xl border border-white/10 bg-white/[0.03] p-4 text-left transition-all duration-300 hover:-translate-y-0.5 hover:border-white/25 hover:bg-white/[0.06] focus:outline-none focus:ring-4 focus:ring-white/10"
                >
                  <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-gradient-to-b from-white/15 to-white/[0.03] ring-1 ring-white/10">
                    <BookOpen className="h-5 w-5 text-white" />
                  </span>

                  <span className="min-w-0 flex-1">
                    <span className="block truncate text-[15px] font-medium text-white">
                      {guide.title}
                    </span>
                    <span className="mt-0.5 block truncate text-xs text-zinc-500">
                      {[guide.characters?.name, game?.name, formatDate(guide.updated_at, activeLanguage)]
                        .filter(Boolean)
                        .join(' · ')}
                    </span>
                  </span>
                </button>
              </li>
            )
          })}
        </ul>
      )}
    </>
  )

  if (embedded) {
    return (
      <section className="rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
        <div className="mb-6 flex flex-wrap items-start justify-between gap-4">
          <div>
            <h2 className="mb-1.5 flex items-center gap-2.5 text-lg font-semibold tracking-tight text-white">
              <NotebookPen className="h-5 w-5 text-[#0066ff]" />
              {t('guides.mine.title')}
            </h2>
            <p className="text-sm text-zinc-500">{t('guides.mine.subtitle')}</p>
          </div>

          <button
            type="button"
            onClick={() => navigate(newGuideHref)}
            className="flex shrink-0 items-center gap-2 rounded-xl bg-white px-4 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:-translate-y-0.5 hover:bg-[#0066ff] hover:text-white hover:shadow-[0_0_25px_rgba(0,102,255,0.6)] focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:translate-y-0 active:scale-95"
          >
            <Plus className="h-4 w-4" />
            {t('guides.mine.create')}
          </button>
        </div>

        {list}
      </section>
    )
  }

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <div className="pointer-events-none fixed inset-0" aria-hidden="true">
        <div className="absolute inset-0 bg-[linear-gradient(to_right,rgba(255,255,255,0.035)_1px,transparent_1px),linear-gradient(to_bottom,rgba(255,255,255,0.035)_1px,transparent_1px)] bg-[size:64px_64px] [mask-image:radial-gradient(ellipse_at_center,black_10%,transparent_70%)]" />
        <div className="absolute -top-40 right-[10%] h-[30rem] w-[30rem] animate-pulse rounded-full bg-blue-600/12 blur-[130px] [animation-duration:11s]" />
      </div>

      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-4xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate('/profile')}
            aria-label={t('friends.backToProfile')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">
              {t('guides.mine.title')}
            </h1>
            <p className="truncate text-xs text-zinc-500 sm:text-sm">
              {t('guides.mine.subtitle')}
            </p>
          </div>

          <button
            type="button"
            onClick={() => navigate(newGuideHref)}
            className="flex shrink-0 items-center gap-2 rounded-lg bg-white px-3 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:bg-[#0066ff] hover:text-white focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:scale-95 sm:px-4"
          >
            <Plus className="h-4 w-4" />
            <span className="hidden sm:inline">{t('guides.mine.create')}</span>
          </button>
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-4xl px-4 py-10 sm:px-6 sm:py-14">{list}</main>
    </div>
  )
}

export default MyGuides

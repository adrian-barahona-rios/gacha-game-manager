import { useEffect, useState } from 'react'
import { AlertCircle, ExternalLink, Loader2, PlayCircle } from 'lucide-react'
import { useI18n } from '../i18n/useI18n'

// Traduce el error de la funcion serverless a un mensaje util.
const ERROR_KEYS = {
  missing_api_key: 'guides.video.error.key',
  missing_query: 'guides.video.error.query',
  youtube_error: 'guides.video.error.youtube',
  fetch_failed: 'guides.video.error.network',
  not_found: 'guides.video.error.notFound',
}

function YouTubeGuidesSection({ query }) {
  const { t, activeLanguage } = useI18n()
  const [loaded, setLoaded] = useState(null)

  const key = `${query}|${activeLanguage}`
  const isLoading = loaded?.key !== key
  const result = loaded?.key === key ? loaded : null

  useEffect(() => {
    if (!query) {
      return undefined
    }

    let active = true
    const url = `/api/youtube-search?query=${encodeURIComponent(query)}&lang=${activeLanguage}`

    fetch(url)
      .then(async (response) => {
        // En `npm run dev` no existe la funcion serverless: Vite devuelve el
        // index.html, no JSON. Se detecta aqui para dar un aviso claro.
        const type = response.headers.get('content-type') ?? ''
        if (!type.includes('application/json')) {
          return { ok: false, body: { error: 'not_found' } }
        }
        return { ok: response.ok, body: await response.json() }
      })
      .then(({ ok, body }) => {
        if (!active) {
          return
        }
        setLoaded(
          ok
            ? { key, videos: body.videos, window: body.window, error: null }
            : { key, videos: [], window: null, error: body.error ?? 'youtube_error' },
        )
      })
      .catch(() => {
        if (active) {
          setLoaded({ key, videos: [], window: null, error: 'fetch_failed' })
        }
      })

    return () => {
      active = false
    }
  }, [query, activeLanguage, key])

  return (
    <section className="rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
      <h2 className="mb-1.5 flex items-center gap-2.5 text-lg font-semibold tracking-tight text-white">
        <PlayCircle className="h-5 w-5 text-red-500" />
        {t('guides.video.title')}
      </h2>
      <p className="mb-6 text-sm text-zinc-500">
        {result?.window === 'all' ? t('guides.video.subtitleAll') : t('guides.video.subtitle')}
      </p>

      {isLoading ? (
        <div className="flex items-center justify-center gap-3 py-10 text-sm text-zinc-500">
          <Loader2 className="h-4 w-4 animate-spin" />
          {t('common.loading')}
        </div>
      ) : result.error ? (
        <div className="flex items-start gap-3 rounded-xl border border-amber-500/30 bg-amber-500/10 px-4 py-3 text-[13px] text-amber-200">
          <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
          <p>{t(ERROR_KEYS[result.error] ?? 'guides.video.error.youtube')}</p>
        </div>
      ) : result.videos.length === 0 ? (
        <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-10 text-center">
          <PlayCircle className="mx-auto mb-4 h-9 w-9 text-zinc-600" />
          <p className="text-sm text-zinc-400">{t('guides.video.empty')}</p>
        </div>
      ) : (
        <div className="grid gap-6 sm:grid-cols-2">
          {result.videos.map((video) => (
            <article key={video.id} className="flex flex-col">
              <div className="mb-3 aspect-video overflow-hidden rounded-xl border border-white/10 bg-black">
                <iframe
                  src={`https://www.youtube-nocookie.com/embed/${video.id}`}
                  title={video.title}
                  loading="lazy"
                  allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                  allowFullScreen
                  referrerPolicy="strict-origin-when-cross-origin"
                  className="h-full w-full"
                />
              </div>

              <h3 className="mb-1 line-clamp-2 text-sm font-medium text-white" title={video.title}>
                {video.title}
              </h3>
              <p className="mb-2 truncate text-xs text-zinc-500">{video.channel}</p>

              <a
                href={`https://www.youtube.com/watch?v=${video.id}`}
                target="_blank"
                rel="noreferrer"
                className="mt-auto inline-flex items-center gap-2 text-xs text-zinc-500 transition-colors duration-300 hover:text-white"
              >
                <ExternalLink className="h-3.5 w-3.5" />
                {t('guides.video.openOnYouTube')}
              </a>
            </article>
          ))}
        </div>
      )}
    </section>
  )
}

export default YouTubeGuidesSection

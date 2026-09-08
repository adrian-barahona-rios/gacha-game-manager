// Funcion serverless de Vercel: GET /api/youtube-search?query=...&lang=es
//
// La clave se lee de process.env.YOUTUBE_API_KEY y nunca sale de aqui. El
// nombre NO lleva el prefijo VITE_ a proposito: Vite incrusta el valor de
// cualquier variable VITE_* en el JavaScript que descarga el navegador, asi
// que una clave con ese prefijo seria publica.

const YOUTUBE_ENDPOINT = 'https://www.googleapis.com/youtube/v3/search'
const WEEK_MS = 7 * 24 * 60 * 60 * 1000
const MAX_RESULTS = 8

function buildUrl(key, query, lang, publishedAfter) {
  const url = new URL(YOUTUBE_ENDPOINT)
  url.searchParams.set('key', key)
  url.searchParams.set('part', 'snippet')
  url.searchParams.set('type', 'video')
  url.searchParams.set('q', query)
  url.searchParams.set('maxResults', String(MAX_RESULTS))
  url.searchParams.set('order', 'relevance')
  url.searchParams.set('safeSearch', 'moderate')
  // Solo videos que se puedan incrustar: la seccion los muestra en un iframe.
  url.searchParams.set('videoEmbeddable', 'true')
  url.searchParams.set('relevanceLanguage', lang)
  if (publishedAfter) {
    url.searchParams.set('publishedAfter', publishedAfter)
  }
  return url
}

function toVideos(payload) {
  return (payload.items ?? [])
    .filter((item) => item.id?.videoId)
    .map((item) => ({
      id: item.id.videoId,
      title: item.snippet.title,
      channel: item.snippet.channelTitle,
      publishedAt: item.snippet.publishedAt,
      thumbnail: item.snippet.thumbnails?.medium?.url ?? null,
    }))
}

export default async function handler(request, response) {
  const key = process.env.YOUTUBE_API_KEY

  if (!key) {
    response.status(500).json({ error: 'missing_api_key' })
    return
  }

  const query = String(request.query.query ?? '').trim()

  if (!query) {
    response.status(400).json({ error: 'missing_query' })
    return
  }

  const lang = request.query.lang === 'en' ? 'en' : 'es'

  try {
    const since = new Date(Date.now() - WEEK_MS).toISOString()
    let search = await fetch(buildUrl(key, query, lang, since))
    let payload = await search.json()

    if (!search.ok) {
      response
        .status(search.status)
        .json({ error: 'youtube_error', detail: payload.error?.message ?? null })
      return
    }

    let videos = toVideos(payload)
    let window = 'week'

    // Un personaje poco popular puede no tener nada de la ultima semana. En
    // ese caso se repite la busqueda sin limite de fecha y se avisa de ello,
    // que es mejor que devolver una seccion vacia.
    if (videos.length === 0) {
      search = await fetch(buildUrl(key, query, lang, null))
      payload = await search.json()
      if (search.ok) {
        videos = toVideos(payload)
        window = 'all'
      }
    }

    // Una hora en la cache de Vercel: la cuota diaria de YouTube es limitada.
    response.setHeader('Cache-Control', 's-maxage=3600, stale-while-revalidate=86400')
    response.status(200).json({ videos, window, query, lang })
  } catch (error) {
    response.status(502).json({ error: 'fetch_failed', detail: error.message })
  }
}

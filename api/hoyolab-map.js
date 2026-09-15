// Funcion serverless de Vercel: puente con el mapa interactivo de HoYoLAB.
//
//   GET /api/hoyolab-map?type=info&map=2&lang=es
//   GET /api/hoyolab-map?type=tree&map=2&lang=es
//   GET /api/hoyolab-map?type=points&map=2&category=1&lang=es
//   GET /api/hoyolab-map?type=point&map=2&point=105841&lang=es
//   GET /api/hoyolab-map?type=areas&map=2&lang=es     (regiones)
//   GET /api/hoyolab-map?type=anchors&map=2&lang=es   (zonas de cada region)
//
// La API de HoYoLAB es publica (no pide cuenta ni clave), pero solo deja que
// la llame el navegador desde act.hoyolab.com. Por eso la app no puede pedirla
// directamente y pasa por aqui. De paso se recorta la respuesta: la lista de
// puntos sin recortar pesa varios megas y la app solo necesita id, filtro y
// coordenadas.
//
// Las imagenes del mapa no pasan por aqui: se cargan directamente del CDN de
// HoYoverse, que si lo permite.

const API = 'https://sg-public-api-static.hoyolab.com/common/map_user/ys_obc'

// Mapas de Genshin con imagenes propias. El 10 (Archipielago Manzana Dorada)
// era de un evento y ya no tiene mapa.
const MAPS = new Set([2, 7, 9, 34, 36, 37, 40])

const LANGS = { es: 'es-es', en: 'en-us' }

function hoyolabUrl(path, params) {
  const url = new URL(`${API}/${path}`)
  for (const [key, value] of Object.entries(params)) {
    url.searchParams.set(key, String(value))
  }
  url.searchParams.set('app_sn', 'ys_obc')
  return url
}

const toInt = (value) => (/^\d{1,9}$/.test(String(value ?? '')) ? Number(value) : null)

// Solo lo que hace falta para pintar el mapa.
function trimInfo(info) {
  const detail = info.detail_v2 ?? {}
  return {
    id: info.id,
    name: info.name,
    totalSize: detail.total_size,
    padding: detail.padding,
    origin: detail.origin,
    version: detail.map_version,
    minZoom: detail.min_zoom,
    maxZoom: detail.max_zoom,
  }
}

// Grupos de filtros con sus filtros. Los que no tienen ningun punto en este
// mapa se quitan.
function trimTree(tree) {
  return tree
    .map((group) => ({
      id: group.id,
      name: group.name,
      labels: (group.children ?? [])
        .filter((label) => label.point_count > 0)
        .map((label) => ({
          id: label.id,
          name: label.name,
          icon: label.icon,
          count: label.point_count,
        })),
    }))
    .filter((group) => group.labels.length > 0)
}

// [id, filtro, x, y, capa] por punto. La capa (z_level) distingue los puntos
// que estan bajo tierra o en otro piso. Con un decimal sobra: una unidad del
// mapa es un pixel de la imagen a tamano completo.
const round = (value) => Math.round(value * 10) / 10
const trimPoints = (points) =>
  points.map((point) => [point.id, point.label_id, round(point.x_pos), round(point.y_pos), point.z_level ?? 0])

// Recuadro [x1, y1, x2, y2] en coordenadas del mapa, para encuadrar la zona.
const bounds = (item) => [Number(item.l_x), Number(item.l_y), Number(item.r_x), Number(item.r_y)]

// Regiones, cada una con el mapa en el que esta (Enkanomiya o la Sima tienen
// mapa propio). HoYoLAB pone primero la mas nueva; aqui van en el orden del
// juego: las de Teyvat por orden de salida y despues las de mapa propio.
const trimAreas = (list) =>
  list
    .slice()
    .sort((a, b) => Number(a.map_id !== 2) - Number(b.map_id !== 2) || a.id - b.id)
    .map((area) => ({ id: area.id, name: area.name, icon: area.pc_icon_url || null, map: area.map_id, bounds: bounds(area) }))

// Zonas grandes de cada region (Espinadragon, Isla Tsurumi...).
const trimAnchors = (list) =>
  list.map((anchor) => ({ id: Number(anchor.id), name: anchor.name, area: anchor.area_id, bounds: bounds(anchor) }))

function trimPoint(info) {
  return {
    id: info.id,
    label: info.label_id,
    content: info.content ?? '',
    image: info.img || null,
    updatedAt: info.ctime ?? null,
  }
}

export default async function handler(request, response) {
  const type = String(request.query.type ?? '')
  const map = toInt(request.query.map)
  const lang = LANGS[request.query.lang] ?? LANGS.es

  if (!MAPS.has(map)) {
    response.status(400).json({ error: 'invalid_map' })
    return
  }

  let url
  let trim

  if (type === 'info') {
    url = hoyolabUrl('v3/map/info', { map_id: map, lang })
    trim = (data) => trimInfo(data.info)
  } else if (type === 'tree') {
    url = hoyolabUrl('v2/map/label/tree', { map_id: map, lang })
    trim = (data) => trimTree(data.tree ?? [])
  } else if (type === 'points') {
    const category = toInt(request.query.category)
    if (category === null) {
      response.status(400).json({ error: 'invalid_category' })
      return
    }
    // Pidiendo el id de un grupo, HoYoLAB devuelve los puntos de todos sus
    // filtros de una vez.
    url = hoyolabUrl('v3/map/point/list', { map_id: map, label_ids: category, lang })
    trim = (data) => trimPoints(data.point_list ?? [])
  } else if (type === 'point') {
    const point = toInt(request.query.point)
    if (point === null) {
      response.status(400).json({ error: 'invalid_point' })
      return
    }
    url = hoyolabUrl('v1/map/point/info', { map_id: map, point_id: point, lang })
    trim = (data) => trimPoint(data.info)
  } else if (type === 'areas') {
    url = hoyolabUrl('v1/map/get_area_pageLabel', { map_id: map, lang })
    trim = (data) => trimAreas(data.list ?? [])
  } else if (type === 'anchors') {
    url = hoyolabUrl('v1/map/map_anchor/list', { map_id: map, lang })
    trim = (data) => trimAnchors(data.list ?? [])
  } else {
    response.status(400).json({ error: 'invalid_type' })
    return
  }

  try {
    const upstream = await fetch(url, { headers: { 'User-Agent': 'Mozilla/5.0' } })
    const payload = await upstream.json()

    if (!upstream.ok || payload.retcode !== 0 || !payload.data) {
      response
        .status(502)
        .json({ error: 'hoyolab_error', detail: payload.message ?? upstream.status })
      return
    }

    // Una hora en la cache de Vercel: los puntos cambian poco y asi casi
    // ninguna visita llega a HoYoLAB.
    response.setHeader('Cache-Control', 's-maxage=3600, stale-while-revalidate=86400')
    response.status(200).json(trim(payload.data))
  } catch (error) {
    response.status(502).json({ error: 'fetch_failed', detail: error.message })
  }
}

// Apartado de exploracion: que juegos lo tienen y que mapas ensena.
//
// El mapa es el interactivo oficial de HoYoLAB: las imagenes salen de su CDN
// y los puntos de su API, a traves de api/hoyolab-map.js. Los ids son los de
// HoYoLAB, en el orden en el que aparecen en su selector.
export const EXPLORATION_SECTIONS = {
  'genshin-impact': {
    maps: [2, 7, 9, 34, 36, 37, 40],
    // Mapa del que salen las regiones y los filtros de las rutas en video.
    routesMap: 2,
    // Apartados de las rutas en video. Los de tipo "labels" usan un grupo de
    // filtros del mapa de HoYoLAB (su id) y buscan en YouTube el nombre de
    // cada filtro con la coletilla queryKey.
    routeCategories: [
      { id: 'zonas', type: 'areas', labelKey: 'exploration.routes.cat.zones', hintKey: 'exploration.routes.hint.zones', queryKey: 'exploration.routes.query.explore' },
      { id: 'especialidades', type: 'labels', group: 10, labelKey: 'exploration.routes.cat.specialties', hintKey: 'exploration.routes.hint.specialties', queryKey: 'exploration.routes.query.farm' },
      { id: 'enemigos', type: 'labels', group: 50, labelKey: 'exploration.routes.cat.enemies', hintKey: 'exploration.routes.hint.enemies', queryKey: 'exploration.routes.query.farm' },
      { id: 'minerales', type: 'labels', group: 11, labelKey: 'exploration.routes.cat.minerals', hintKey: 'exploration.routes.hint.minerals', queryKey: 'exploration.routes.query.farm' },
      { id: 'coleccionables', type: 'labels', group: 4, labelKey: 'exploration.routes.cat.collectibles', hintKey: 'exploration.routes.hint.collectibles', queryKey: 'exploration.routes.query.locations' },
    ],
    // Nombre del juego al principio de cada busqueda de YouTube.
    queryPrefix: 'Genshin Impact',
  },
}

export const hasExploration = (gameId) => Boolean(EXPLORATION_SECTIONS[gameId])

// Base de las imagenes del mapa. Cada pieza es {mapa}/{version}/{x}_{y}_{zoom}
// donde el zoom va como N3, N2... (alejado) o P0, P1... (acercado).
export const TILE_BASE = 'https://act-webstatic.hoyoverse.com/map_manage/map/'

// Por encima de este numero de puntos a la vista no se pintan: con miles de
// iconos a la vez el mapa va a tirones. Se pide acercarse.
export const MAX_VISIBLE_POINTS = 1500

// Llamada a api/hoyolab-map.js. Lanza Error('no_api') cuando la funcion no
// existe (en local con "vite" a secas la ruta /api devuelve el index.html).
export async function fetchHoyolabMap(params) {
  const res = await fetch(`/api/hoyolab-map?${new URLSearchParams(params)}`)
  if (!res.headers.get('content-type')?.includes('application/json')) {
    throw new Error('no_api')
  }
  const data = await res.json()
  if (!res.ok) throw new Error(data.error ?? 'error')
  return data
}

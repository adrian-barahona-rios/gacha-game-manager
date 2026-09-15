import { useEffect, useMemo, useRef, useState } from 'react'
import L from 'leaflet'
import 'leaflet/dist/leaflet.css'
import { AlertCircle, Check, ChevronDown, Loader2, MapPin, Search, SlidersHorizontal, X } from 'lucide-react'
import { useI18n } from '../i18n/useI18n'
import { EXPLORATION_SECTIONS, MAX_VISIBLE_POINTS, TILE_BASE, fetchHoyolabMap as pedir } from '../data/exploration'

const clave = (mapId) => `exploracion:${mapId}:filtros`

function leerFiltros(mapId) {
  try {
    return new Set(JSON.parse(localStorage.getItem(clave(mapId)) ?? '[]'))
  } catch {
    return new Set()
  }
}

function guardarFiltros(mapId, filtros) {
  try {
    localStorage.setItem(clave(mapId), JSON.stringify([...filtros]))
  } catch {
    // Sin almacenamiento (modo privado): los filtros duran lo que la visita.
  }
}

const sinAcentos = (texto) =>
  texto
    .normalize('NFD')
    .replace(/\p{Diacritic}/gu, '')
    .toLowerCase()

const escapar = (texto) =>
  String(texto).replace(/[&<>"']/g, (c) => `&#${c.charCodeAt(0)};`)

// Mismo sistema de coordenadas que el mapa de HoYoLAB: un punto (x, y) esta
// en el pixel (x + origen x, y + origen y) de la imagen a tamano completo, y
// cada nivel de zoom duplica la escala.
function crearCrs(origin) {
  const [ox, oy] = origin
  return L.Util.extend({}, L.CRS.Simple, {
    projection: {
      project: (latlng) => new L.Point(latlng.lng + ox, latlng.lat + oy),
      unproject: (point) => new L.LatLng(point.y - oy, point.x - ox),
    },
    transformation: new L.Transformation(1, 0, 1, 0),
    infinite: true,
  })
}

const PiezaMapa = L.TileLayer.extend({
  getTileUrl(coords) {
    const { mapa, version } = this.options
    const zoom = `${coords.z < 0 ? 'N' : 'P'}${Math.abs(coords.z)}`
    return `${TILE_BASE}${mapa}/${version}/${coords.x}_${coords.y}_${zoom}.webp`
  },
})

// Mapa interactivo oficial de HoYoLAB con los filtros al lado. Solo se
// pintan los puntos que caen dentro de la vista, y se van anadiendo y
// quitando al moverse.
//
// enfoque llega desde las rutas en video ("Ver en el mapa"): { map, label,
// bounds }. Abre ese mapa, activa el filtro y encuadra la zona. Solo se lee al
// montar: para cambiarlo, el padre vuelve a montar el componente con otra key.
function InteractiveMap({ gameId, enfoque = null }) {
  const { t, activeLanguage } = useI18n()
  const section = EXPLORATION_SECTIONS[gameId]
  const lang = activeLanguage === 'en' ? 'en' : 'es'

  const [mapas, setMapas] = useState([])
  const [mapId, setMapId] = useState(() => (section.maps.includes(enfoque?.map) ? enfoque.map : section.maps[0]))
  const [arbol, setArbol] = useState(null)
  const [filtros, setFiltros] = useState(() => {
    const inicial = leerFiltros(mapId)
    if (enfoque?.label) {
      inicial.add(enfoque.label)
      guardarFiltros(mapId, inicial)
    }
    return inicial
  })
  const [puntos, setPuntos] = useState({})
  const [error, setError] = useState('')
  const [termino, setTermino] = useState('')
  const [abiertos, setAbiertos] = useState(() => new Set())
  const [panelMovil, setPanelMovil] = useState(false)
  const [demasiados, setDemasiados] = useState(0)
  const [elegido, setElegido] = useState(null)

  const contenedorRef = useRef(null)
  const mapaRef = useRef(null)
  const marcadoresRef = useRef(new Map())
  const enfoqueRef = useRef(enfoque)

  const info = mapas.find((mapa) => mapa.id === mapId) ?? null

  const errorDe = (err) => t(err.message === 'no_api' ? 'exploration.error.noApi' : 'exploration.error.load')

  // Nombres y medidas de todos los mapas.
  useEffect(() => {
    let active = true
    Promise.all(section.maps.map((id) => pedir({ type: 'info', map: id, lang })))
      .then((lista) => active && setMapas(lista))
      .catch((err) => active && setError(errorDe(err)))
    return () => {
      active = false
    }
    // errorDe solo traduce: no hace falta repetir la carga si cambia.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [section, lang])

  // Filtros del mapa elegido.
  useEffect(() => {
    let active = true
    pedir({ type: 'tree', map: mapId, lang })
      .then((grupos) => active && setArbol(grupos))
      .catch((err) => active && setError(errorDe(err)))
    return () => {
      active = false
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [mapId, lang])

  const filtrosPorId = useMemo(() => {
    const porId = new Map()
    for (const grupo of arbol ?? []) {
      for (const filtro of grupo.labels) porId.set(filtro.id, { ...filtro, grupo })
    }
    return porId
  }, [arbol])

  // Puntos de los grupos que tienen algun filtro activo. Se piden por grupo
  // y se guardan: activar otro filtro del mismo grupo ya no hace otra
  // peticion.
  const gruposNecesarios = [...new Set([...filtros].map((id) => filtrosPorId.get(id)?.grupo.id).filter(Boolean))]
  const pendientes = gruposNecesarios.filter((id) => !puntos[`${mapId}:${id}`]).join(',')

  useEffect(() => {
    if (!pendientes) return undefined
    let active = true
    Promise.all(
      pendientes.split(',').map((grupo) =>
        pedir({ type: 'points', map: mapId, category: grupo, lang }).then((lista) => [`${mapId}:${grupo}`, lista]),
      ),
    )
      .then((pares) => active && setPuntos((previos) => ({ ...previos, ...Object.fromEntries(pares) })))
      .catch((err) => active && setError(errorDe(err)))
    return () => {
      active = false
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [pendientes, mapId])

  // Crea el mapa cuando ya se conocen sus medidas.
  useEffect(() => {
    if (!info || !contenedorRef.current) return undefined
    const [ox, oy] = info.origin
    const [ancho, alto] = info.totalSize
    const [px, py] = info.padding
    const aLatLng = (x, y) => L.latLng(y - oy, x - ox)

    // Se deja alejar tres niveles mas que las imagenes mas pequenas: si no,
    // Teyvat no cabe entero en la pantalla, sobre todo en el movil.
    const zoomMinimo = info.minZoom - 3
    const mapa = L.map(contenedorRef.current, {
      crs: crearCrs(info.origin),
      minZoom: zoomMinimo,
      maxZoom: info.maxZoom + 1,
      zoomSnap: 0.25,
      zoomDelta: 0.5,
      wheelPxPerZoomLevel: 120,
      attributionControl: false,
      zoomControl: false,
    })
    L.control.zoom({ position: 'bottomright', zoomInTitle: t('exploration.zoomIn'), zoomOutTitle: t('exploration.zoomOut') }).addTo(mapa)
    L.control.attribution({ position: 'bottomright', prefix: false }).addAttribution('© HoYoverse · HoYoLAB').addTo(mapa)

    new PiezaMapa('', {
      mapa: info.id,
      version: info.version,
      bounds: L.latLngBounds(aLatLng(0, 0), aLatLng(ancho, alto)),
      minNativeZoom: info.minZoom,
      maxNativeZoom: info.maxZoom,
      minZoom: zoomMinimo,
      maxZoom: info.maxZoom + 1,
      noWrap: true,
      keepBuffer: 4,
    }).addTo(mapa)

    // El dibujo ocupa el total menos el margen de cada lado.
    const dibujo = L.latLngBounds(aLatLng(px, py), aLatLng(ancho - px, alto - py))
    mapa.fitBounds(dibujo)
    mapa.setMaxBounds(dibujo.pad(0.25))

    // Zona pedida desde las rutas en video: bounds es [x1, y1, x2, y2].
    const zona = enfoqueRef.current
    if (zona?.bounds && zona.map === info.id) {
      const [x1, y1, x2, y2] = zona.bounds
      mapa.fitBounds(L.latLngBounds([y1, x1], [y2, x2]), { padding: [24, 24] })
    }

    mapaRef.current = mapa
    const marcadores = marcadoresRef.current
    return () => {
      marcadores.clear()
      mapaRef.current = null
      mapa.remove()
    }
    // t solo pone los titulos de los botones de zoom.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [info])

  // Pinta los puntos de los filtros activos que caen en la vista.
  useEffect(() => {
    const mapa = mapaRef.current
    if (!mapa) return undefined

    const iconos = new Map()
    const iconoDe = (filtro) => {
      if (!iconos.has(filtro.id)) {
        iconos.set(
          filtro.id,
          L.divIcon({
            className: 'flex items-center justify-center rounded-full border-2 border-white/80 bg-[#1b2530] shadow-[0_2px_6px_rgba(0,0,0,0.6)]',
            html: filtro.icon ? `<img src="${escapar(filtro.icon)}" alt="" class="h-[22px] w-[22px] object-contain" />` : '',
            iconSize: [30, 30],
            iconAnchor: [15, 15],
          }),
        )
      }
      return iconos.get(filtro.id)
    }

    const candidatos = gruposNecesarios.flatMap((grupo) =>
      (puntos[`${mapId}:${grupo}`] ?? []).filter((punto) => filtros.has(punto[1])),
    )

    // Filtro pedido desde las rutas en video: en cuanto llegan sus puntos se
    // encuadran, una sola vez.
    const pedido = enfoqueRef.current
    if (pedido?.label && pedido.map === mapId && !pedido.bounds) {
      const suyos = candidatos.filter((punto) => punto[1] === pedido.label)
      if (suyos.length > 0) {
        enfoqueRef.current = null
        mapa.fitBounds(
          L.latLngBounds(suyos.map(([, , x, y]) => [y, x])),
          { padding: [48, 48], maxZoom: info.maxZoom - 1 },
        )
      }
    }

    const actualizar = () => {
      const vista = mapa.getBounds().pad(0.2)
      const visibles = candidatos.filter(([, , x, y]) => vista.contains([y, x]))
      const marcadores = marcadoresRef.current
      const pintar = visibles.length > MAX_VISIBLE_POINTS ? [] : visibles
      const quedan = new Set(pintar.map((punto) => punto[0]))

      for (const [id, marcador] of marcadores) {
        if (!quedan.has(id)) {
          marcador.remove()
          marcadores.delete(id)
        }
      }
      for (const [id, filtroId, x, y] of pintar) {
        if (marcadores.has(id)) continue
        const filtro = filtrosPorId.get(filtroId)
        if (!filtro) continue
        const marcador = L.marker([y, x], { icon: iconoDe(filtro), riseOnHover: true, keyboard: false })
        marcador.on('click', () => setElegido({ id, filtroId }))
        marcador.addTo(mapa)
        marcadores.set(id, marcador)
      }
      setDemasiados(visibles.length > MAX_VISIBLE_POINTS ? visibles.length : 0)
    }

    actualizar()
    mapa.on('moveend', actualizar)
    return () => {
      mapa.off('moveend', actualizar)
    }
    // gruposNecesarios sale de filtros y filtrosPorId, que ya estan.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [info, filtros, puntos, filtrosPorId])

  // Ficha del punto pulsado: foto y texto que haya subido la comunidad.
  const [detalle, setDetalle] = useState(null)
  useEffect(() => {
    if (!elegido) return undefined
    let active = true
    pedir({ type: 'point', map: mapId, point: elegido.id, lang })
      .then((data) => active && setDetalle(data))
      .catch(() => active && setDetalle({ id: elegido.id, error: true }))
    return () => {
      active = false
    }
  }, [elegido, mapId, lang])

  const cambiarMapa = (id) => {
    if (id === mapId) return
    setMapId(id)
    setArbol(null)
    setFiltros(leerFiltros(id))
    setElegido(null)
    setDetalle(null)
    setDemasiados(0)
  }

  const cambiarFiltros = (cambio) => {
    setFiltros((previos) => {
      const nuevos = cambio(new Set(previos))
      guardarFiltros(mapId, nuevos)
      return nuevos
    })
  }

  const alternar = (id) =>
    cambiarFiltros((set) => {
      if (set.has(id)) set.delete(id)
      else set.add(id)
      return set
    })

  const alternarGrupo = (grupo, activar) =>
    cambiarFiltros((set) => {
      for (const filtro of grupo.labels) {
        if (activar) set.add(filtro.id)
        else set.delete(filtro.id)
      }
      return set
    })

  const aguja = sinAcentos(termino.trim())
  const gruposVisibles = (arbol ?? [])
    .map((grupo) => ({
      ...grupo,
      labels: aguja ? grupo.labels.filter((filtro) => sinAcentos(filtro.name).includes(aguja)) : grupo.labels,
    }))
    .filter((grupo) => grupo.labels.length > 0)

  const cargandoPuntos = pendientes !== ''
  const filtroElegido = elegido ? filtrosPorId.get(elegido.filtroId) : null
  const detalleListo = detalle && elegido && detalle.id === elegido.id

  const panel = (
    <div className="flex h-full flex-col">
      <div className="space-y-3 border-b border-white/10 p-4">
        <label className="block">
          <span className="mb-1 block text-[11px] font-semibold uppercase tracking-wide text-zinc-500">
            {t('exploration.region')}
          </span>
          <select
            value={mapId}
            onChange={(event) => cambiarMapa(Number(event.target.value))}
            className="w-full rounded-lg border border-white/10 bg-[#101014] px-3 py-2 text-sm text-white focus:border-white/30 focus:outline-none"
          >
            {section.maps.map((id) => (
              <option key={id} value={id}>
                {mapas.find((mapa) => mapa.id === id)?.name ?? '…'}
              </option>
            ))}
          </select>
        </label>

        <div className="relative">
          <input
            value={termino}
            onChange={(event) => setTermino(event.target.value)}
            placeholder={t('exploration.search')}
            className="peer w-full rounded-lg border border-white/10 bg-white/[0.03] py-2 pl-9 pr-3 text-sm text-white placeholder:text-zinc-600 focus:border-white/30 focus:outline-none"
          />
          <Search className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-zinc-500 peer-focus:text-white" />
        </div>

        <div className="flex items-center justify-between text-xs text-zinc-500">
          <span>{t('exploration.activeFilters', { count: filtros.size })}</span>
          {filtros.size > 0 && (
            <button
              type="button"
              onClick={() => cambiarFiltros(() => new Set())}
              className="rounded px-1.5 py-0.5 text-zinc-300 hover:bg-white/10 hover:text-white"
            >
              {t('exploration.clear')}
            </button>
          )}
        </div>
      </div>

      <div className="min-h-0 flex-1 overflow-y-auto p-2">
        {!arbol ? (
          <div className="flex items-center justify-center gap-2 py-10 text-sm text-zinc-500">
            <Loader2 className="h-4 w-4 animate-spin" />
            {t('common.loading')}
          </div>
        ) : gruposVisibles.length === 0 ? (
          <p className="px-2 py-8 text-center text-sm text-zinc-500">{t('exploration.noFilters')}</p>
        ) : (
          gruposVisibles.map((grupo) => {
            const abierto = Boolean(aguja) || abiertos.has(grupo.id)
            const activos = grupo.labels.filter((filtro) => filtros.has(filtro.id)).length
            return (
              <section key={grupo.id} className="mb-1">
                <div className="flex items-center gap-1">
                  <button
                    type="button"
                    aria-expanded={abierto}
                    onClick={() =>
                      setAbiertos((previos) => {
                        const nuevos = new Set(previos)
                        if (nuevos.has(grupo.id)) nuevos.delete(grupo.id)
                        else nuevos.add(grupo.id)
                        return nuevos
                      })
                    }
                    className="flex min-w-0 flex-1 items-center gap-2 rounded-lg px-2 py-2 text-left text-sm font-medium text-zinc-200 hover:bg-white/5"
                  >
                    <ChevronDown className={`h-4 w-4 shrink-0 text-zinc-500 transition-transform ${abierto ? '' : '-rotate-90'}`} />
                    <span className="truncate">{grupo.name}</span>
                    {activos > 0 && (
                      <span className="rounded-full bg-[#7aa7ff]/20 px-1.5 text-[11px] text-[#aecbff]">{activos}</span>
                    )}
                  </button>
                  {abierto && (
                    <button
                      type="button"
                      onClick={() => alternarGrupo(grupo, activos < grupo.labels.length)}
                      className="shrink-0 rounded px-2 py-1 text-[11px] text-zinc-400 hover:bg-white/10 hover:text-white"
                    >
                      {activos < grupo.labels.length ? t('exploration.all') : t('exploration.none')}
                    </button>
                  )}
                </div>

                {abierto && (
                  <ul className="grid grid-cols-2 gap-1 px-1 pb-2 pt-1">
                    {grupo.labels.map((filtro) => {
                      const activo = filtros.has(filtro.id)
                      return (
                        <li key={filtro.id}>
                          <button
                            type="button"
                            aria-pressed={activo}
                            onClick={() => alternar(filtro.id)}
                            title={filtro.name}
                            className={`flex w-full items-center gap-2 rounded-lg border px-1.5 py-1.5 text-left transition-colors ${
                              activo
                                ? 'border-[#7aa7ff]/50 bg-[#7aa7ff]/15'
                                : 'border-transparent bg-white/[0.03] hover:bg-white/[0.07]'
                            }`}
                          >
                            <span className="relative flex h-7 w-7 shrink-0 items-center justify-center rounded-md bg-black/40">
                              {filtro.icon && <img src={filtro.icon} alt="" loading="lazy" className="h-6 w-6 object-contain" />}
                              {activo && (
                                <Check className="absolute -right-1 -top-1 h-3.5 w-3.5 rounded-full bg-[#7aa7ff] p-0.5 text-black" />
                              )}
                            </span>
                            <span className="min-w-0">
                              <span className="block truncate text-[12px] leading-tight text-zinc-200">{filtro.name}</span>
                              <span className="block text-[10px] text-zinc-500">{filtro.count}</span>
                            </span>
                          </button>
                        </li>
                      )
                    })}
                  </ul>
                )}
              </section>
            )
          })
        )}
      </div>
    </div>
  )

  return (
    <div className="relative flex min-h-0 flex-1 overflow-hidden rounded-2xl border border-white/10">
      <aside className="hidden w-80 shrink-0 border-r border-white/10 bg-[#0b0b0f] lg:block">{panel}</aside>

      {panelMovil && (
        <div className="absolute inset-0 z-[1200] flex lg:hidden">
          <aside className="relative w-[85%] max-w-sm border-r border-white/10 bg-[#0b0b0f]">
            <button
              type="button"
              onClick={() => setPanelMovil(false)}
              aria-label={t('common.close')}
              className="absolute right-2 top-2 z-10 rounded-lg p-1.5 text-zinc-400 hover:bg-white/10 hover:text-white"
            >
              <X className="h-4 w-4" />
            </button>
            {panel}
          </aside>
          <button
            type="button"
            aria-label={t('common.close')}
            onClick={() => setPanelMovil(false)}
            className="flex-1 bg-black/50"
          />
        </div>
      )}

      <div className="relative min-w-0 flex-1 bg-[#0d1820]">
        {/* El fondo va en style: la hoja de estilos de Leaflet pone uno gris que
            gana a la clase de Tailwind. */}
        <div ref={contenedorRef} className="absolute inset-0" style={{ background: '#0d1820' }} />

        {error && (
          <div className="absolute inset-x-4 top-4 z-[1100] flex items-start gap-3 rounded-xl border border-red-500/30 bg-[#1a0b0d]/95 px-4 py-3 text-sm text-red-200">
            <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{error}</p>
          </div>
        )}

        {!info && !error && (
          <div className="absolute inset-0 z-[1000] flex items-center justify-center gap-2 text-sm text-zinc-400">
            <Loader2 className="h-5 w-5 animate-spin" />
            {t('common.loading')}
          </div>
        )}

        <div className="pointer-events-none absolute left-3 top-3 z-[1000] flex flex-wrap gap-2">
          <button
            type="button"
            onClick={() => setPanelMovil(true)}
            className="pointer-events-auto flex items-center gap-2 rounded-lg border border-white/15 bg-black/75 px-3 py-2 text-sm text-white backdrop-blur hover:bg-black/90 lg:hidden"
          >
            <SlidersHorizontal className="h-4 w-4" />
            {t('exploration.filters')}
            {filtros.size > 0 && <span className="rounded-full bg-[#7aa7ff] px-1.5 text-[11px] text-black">{filtros.size}</span>}
          </button>
          {cargandoPuntos && (
            <span className="flex items-center gap-2 rounded-lg border border-white/15 bg-black/75 px-3 py-2 text-xs text-zinc-300 backdrop-blur">
              <Loader2 className="h-3.5 w-3.5 animate-spin" />
              {t('exploration.loadingPoints')}
            </span>
          )}
          {demasiados > 0 && (
            <span className="rounded-lg border border-amber-400/30 bg-black/80 px-3 py-2 text-xs text-amber-200 backdrop-blur">
              {t('exploration.tooMany', { count: demasiados })}
            </span>
          )}
          {filtros.size === 0 && info && (
            <span className="hidden rounded-lg border border-white/15 bg-black/75 px-3 py-2 text-xs text-zinc-300 backdrop-blur lg:block">
              {t('exploration.pickHint')}
            </span>
          )}
        </div>

        {elegido && filtroElegido && (
          <div className="absolute bottom-3 left-3 z-[1100] w-[min(22rem,calc(100%-4.5rem))] rounded-xl border border-white/15 bg-[#0b0b0f]/95 p-3 shadow-2xl backdrop-blur">
            <div className="flex items-start gap-3">
              <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-white/5">
                {filtroElegido.icon ? (
                  <img src={filtroElegido.icon} alt="" className="h-8 w-8 object-contain" />
                ) : (
                  <MapPin className="h-5 w-5 text-zinc-500" />
                )}
              </span>
              <div className="min-w-0 flex-1">
                <p className="text-sm font-semibold leading-snug text-white">{filtroElegido.name}</p>
                {filtroElegido.grupo.name !== filtroElegido.name && (
                  <p className="text-xs text-zinc-500">{filtroElegido.grupo.name}</p>
                )}
              </div>
              <button
                type="button"
                onClick={() => setElegido(null)}
                aria-label={t('common.close')}
                className="rounded-lg p-1 text-zinc-400 hover:bg-white/10 hover:text-white"
              >
                <X className="h-4 w-4" />
              </button>
            </div>

            {!detalleListo ? (
              <div className="mt-3 flex items-center gap-2 text-xs text-zinc-500">
                <Loader2 className="h-3.5 w-3.5 animate-spin" />
                {t('common.loading')}
              </div>
            ) : (
              <>
                {detalle.image && (
                  <a href={detalle.image} target="_blank" rel="noreferrer" className="mt-3 block">
                    <img src={detalle.image} alt="" loading="lazy" className="max-h-48 w-full rounded-lg object-cover" />
                  </a>
                )}
                {detalle.content && (
                  <p className="mt-3 whitespace-pre-wrap text-[13px] leading-relaxed text-zinc-300">{detalle.content}</p>
                )}
                {!detalle.image && !detalle.content && (
                  <p className="mt-3 text-xs text-zinc-500">{t('exploration.noDetails')}</p>
                )}
              </>
            )}
          </div>
        )}
      </div>
    </div>
  )
}

export default InteractiveMap

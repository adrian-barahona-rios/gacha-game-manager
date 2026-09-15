import { useEffect, useRef, useState } from 'react'
import { AlertCircle, Compass, Loader2, MapPinned, Search } from 'lucide-react'
import { useI18n } from '../i18n/useI18n'
import { EXPLORATION_SECTIONS, fetchHoyolabMap } from '../data/exploration'
import YouTubeGuidesSection from './YouTubeGuidesSection'

const sinAcentos = (texto) =>
  texto
    .normalize('NFD')
    .replace(/\p{Diacritic}/gu, '')
    .toLowerCase()

function Opcion({ icono, nombre, activo, onClick }) {
  return (
    <button
      type="button"
      aria-pressed={activo}
      onClick={onClick}
      title={nombre}
      className={`flex w-full items-center gap-2.5 rounded-xl border px-2.5 py-2 text-left transition-colors ${
        activo ? 'border-[#7aa7ff]/50 bg-[#7aa7ff]/15' : 'border-white/10 bg-white/[0.03] hover:bg-white/[0.07]'
      }`}
    >
      <span className="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-black/40">
        {icono ? (
          <img src={icono} alt="" loading="lazy" className="h-7 w-7 object-contain" />
        ) : (
          <Compass className="h-4 w-4 text-zinc-500" />
        )}
      </span>
      <span className="min-w-0 truncate text-[13px] text-zinc-200">{nombre}</span>
    </button>
  )
}

// Rutas en video: guias de YouTube para explorar cada zona del mapa y rutas
// para farmear especialidades, botin de enemigos y minerales. Los nombres e
// iconos salen del mapa de HoYoLAB, asi que son los oficiales y se actualizan
// solos cuando sale una region nueva.
function ExplorationRoutes({ gameId, onViewOnMap }) {
  const { t, activeLanguage } = useI18n()
  const section = EXPLORATION_SECTIONS[gameId]
  const lang = activeLanguage === 'en' ? 'en' : 'es'

  const [datos, setDatos] = useState(null)
  const [error, setError] = useState('')
  const [categoriaId, setCategoriaId] = useState(section.routeCategories[0].id)
  const [regionId, setRegionId] = useState(null)
  const [elegido, setElegido] = useState(null)
  const [termino, setTermino] = useState('')
  const resultadoRef = useRef(null)

  useEffect(() => {
    let active = true
    const map = section.routesMap
    Promise.all([
      fetchHoyolabMap({ type: 'areas', map, lang }),
      fetchHoyolabMap({ type: 'anchors', map, lang }),
      fetchHoyolabMap({ type: 'tree', map, lang }),
    ])
      .then(([regiones, zonas, arbol]) => {
        if (!active) return
        setDatos({ lang, regiones, zonas, arbol })
        setError('')
      })
      .catch((err) => {
        if (active) setError(t(err.message === 'no_api' ? 'exploration.error.noApi' : 'exploration.error.load'))
      })
    return () => {
      active = false
    }
  }, [section, lang, t])

  // Al cambiar de idioma los nombres cambian: lo elegido se descarta.
  const listos = datos?.lang === lang ? datos : null
  const categoria = section.routeCategories.find((item) => item.id === categoriaId)
  const categorias = section.routeCategories.filter(
    (item) => item.type === 'areas' || listos?.arbol.some((grupo) => grupo.id === item.group),
  )

  // En pantallas estrechas los videos quedan debajo de la lista: se baja
  // hasta ellos para que se vea que ha pasado algo. Al elegir una region no,
  // porque justo debajo salen sus zonas.
  const elegir = (opcion, bajar = true) => {
    setElegido({ ...opcion, lang })
    if (bajar && window.matchMedia('(max-width: 1279px)').matches) {
      requestAnimationFrame(() => resultadoRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' }))
    }
  }
  const elegidoActual = elegido?.lang === lang ? elegido : null

  const cambiarCategoria = (id) => {
    setCategoriaId(id)
    setTermino('')
  }

  const aguja = sinAcentos(termino.trim())
  const region = listos?.regiones.find((item) => item.id === regionId) ?? null
  const zonasRegion = region ? listos.zonas.filter((zona) => zona.area === region.id) : []
  const filtros =
    categoria.type === 'labels'
      ? (listos?.arbol.find((grupo) => grupo.id === categoria.group)?.labels ?? []).filter(
          (filtro) => !aguja || sinAcentos(filtro.name).includes(aguja),
        )
      : []

  const consulta = elegidoActual
    ? [section.queryPrefix, ...elegidoActual.terminos, t(elegidoActual.queryKey)].join(' ')
    : ''

  return (
    <div className="min-h-0 flex-1 overflow-y-auto pb-6">
      <p className="mb-5 max-w-3xl text-sm text-zinc-400">{t('exploration.routes.intro')}</p>

      <div className="mb-5 flex flex-wrap gap-2">
        {categorias.map((item) => (
          <button
            key={item.id}
            type="button"
            aria-pressed={item.id === categoriaId}
            onClick={() => cambiarCategoria(item.id)}
            className={`rounded-full px-3.5 py-1.5 text-sm transition-colors ${
              item.id === categoriaId
                ? 'bg-white font-medium text-black'
                : 'bg-white/5 text-zinc-300 ring-1 ring-white/15 hover:bg-white/10 hover:text-white'
            }`}
          >
            {t(item.labelKey)}
          </button>
        ))}
      </div>

      {error && (
        <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
          <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
          <p>{error}</p>
        </div>
      )}

      <div className="grid gap-6 xl:grid-cols-[minmax(0,26rem)_minmax(0,1fr)]">
        <section className="rounded-2xl border border-white/10 bg-white/[0.02] p-4">
          <p className="mb-3 text-xs text-zinc-500">{t(categoria.hintKey)}</p>

          {!listos ? (
            !error && (
              <div className="flex items-center justify-center gap-2 py-10 text-sm text-zinc-500">
                <Loader2 className="h-4 w-4 animate-spin" />
                {t('common.loading')}
              </div>
            )
          ) : categoria.type === 'areas' ? (
            <>
              <ul className="grid grid-cols-2 gap-2">
                {listos.regiones.map((item) => (
                  <li key={item.id}>
                    <Opcion
                      icono={item.icon}
                      nombre={item.name}
                      activo={item.id === regionId}
                      onClick={() => {
                        setRegionId(item.id)
                        elegir({
                          clave: `region-${item.id}`,
                          nombre: item.name,
                          icono: item.icon,
                          terminos: [item.name],
                          queryKey: categoria.queryKey,
                          mapa: { map: item.map, bounds: item.bounds },
                        }, false)
                      }}
                    />
                  </li>
                ))}
              </ul>

              {region && zonasRegion.length > 0 && (
                <div className="mt-4 border-t border-white/10 pt-4">
                  <p className="mb-2 text-[11px] font-semibold uppercase tracking-wide text-zinc-500">
                    {t('exploration.routes.zonesOf', { region: region.name })}
                  </p>
                  <div className="flex flex-wrap gap-1.5">
                    {[{ id: null, name: t('exploration.routes.wholeRegion') }, ...zonasRegion].map((zona) => {
                      const clave = zona.id ? `zona-${zona.id}` : `region-${region.id}`
                      return (
                        <button
                          key={clave}
                          type="button"
                          aria-pressed={elegidoActual?.clave === clave}
                          onClick={() =>
                            elegir(
                              zona.id
                                ? {
                                    clave,
                                    nombre: zona.name,
                                    icono: region.icon,
                                    contexto: region.name,
                                    terminos: [region.name, zona.name],
                                    queryKey: categoria.queryKey,
                                    mapa: { map: region.map, bounds: zona.bounds },
                                  }
                                : {
                                    clave,
                                    nombre: region.name,
                                    icono: region.icon,
                                    terminos: [region.name],
                                    queryKey: categoria.queryKey,
                                    mapa: { map: region.map, bounds: region.bounds },
                                  },
                            )
                          }
                          className={`rounded-lg px-2.5 py-1 text-[13px] transition-colors ${
                            elegidoActual?.clave === clave
                              ? 'bg-[#7aa7ff]/20 text-[#cfe0ff] ring-1 ring-[#7aa7ff]/50'
                              : 'bg-white/5 text-zinc-300 ring-1 ring-white/10 hover:bg-white/10'
                          }`}
                        >
                          {zona.name}
                        </button>
                      )
                    })}
                  </div>
                </div>
              )}
            </>
          ) : (
            <>
              <div className="relative mb-3">
                <input
                  value={termino}
                  onChange={(event) => setTermino(event.target.value)}
                  placeholder={t('exploration.search')}
                  className="peer w-full rounded-lg border border-white/10 bg-white/[0.03] py-2 pl-9 pr-3 text-sm text-white placeholder:text-zinc-600 focus:border-white/30 focus:outline-none"
                />
                <Search className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-zinc-500 peer-focus:text-white" />
              </div>
              {filtros.length === 0 ? (
                <p className="py-8 text-center text-sm text-zinc-500">{t('exploration.noFilters')}</p>
              ) : (
                <ul className="grid max-h-[32rem] grid-cols-2 gap-2 overflow-y-auto pr-1">
                  {filtros.map((filtro) => (
                    <li key={filtro.id}>
                      <Opcion
                        icono={filtro.icon}
                        nombre={filtro.name}
                        activo={elegidoActual?.clave === `filtro-${filtro.id}`}
                        onClick={() =>
                          elegir({
                            clave: `filtro-${filtro.id}`,
                            nombre: filtro.name,
                            icono: filtro.icon,
                            contexto: t(categoria.labelKey),
                            terminos: [filtro.name],
                            queryKey: categoria.queryKey,
                            mapa: { map: section.routesMap, label: filtro.id },
                          })
                        }
                      />
                    </li>
                  ))}
                </ul>
              )}
            </>
          )}
        </section>

        <div ref={resultadoRef} className="min-w-0 scroll-mt-4">
          {!elegidoActual ? (
            <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
              <MapPinned className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
              <p className="text-zinc-400">{t('exploration.routes.pick')}</p>
            </div>
          ) : (
            <div className="space-y-4">
              <div className="flex flex-wrap items-center gap-3 rounded-2xl border border-white/10 bg-white/[0.03] p-4">
                <span className="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-black/40">
                  {elegidoActual.icono ? (
                    <img src={elegidoActual.icono} alt="" className="h-9 w-9 object-contain" />
                  ) : (
                    <Compass className="h-5 w-5 text-zinc-500" />
                  )}
                </span>
                <div className="min-w-0 flex-1">
                  <h2 className="text-lg font-semibold leading-snug tracking-tight text-white">{elegidoActual.nombre}</h2>
                  {elegidoActual.contexto && <p className="text-xs text-zinc-500">{elegidoActual.contexto}</p>}
                </div>
                <button
                  type="button"
                  onClick={() => onViewOnMap(elegidoActual.mapa)}
                  className="flex items-center gap-2 rounded-lg bg-white px-3 py-2 text-sm font-semibold text-black transition-all duration-300 hover:bg-[#0066ff] hover:text-white active:scale-95"
                >
                  <MapPinned className="h-4 w-4" />
                  {t('exploration.routes.viewOnMap')}
                </button>
              </div>

              <YouTubeGuidesSection
                key={consulta}
                query={consulta}
                recent={false}
                subtitleKey="exploration.routes.subtitle"
                emptyKey="exploration.routes.empty"
              />
            </div>
          )}
        </div>
      </div>
    </div>
  )
}

export default ExplorationRoutes

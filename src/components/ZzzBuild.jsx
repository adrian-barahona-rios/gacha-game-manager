import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { Bot, Disc3, Loader2, Star, Swords, Users } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'

// Referencias sin ficha en la app: "nombre:...".
const SIN_FICHA = 'nombre:'
const tieneFicha = (id) => typeof id === 'string' && !id.startsWith(SIN_FICHA)

function Titulo({ children }) {
  return <h4 className="mb-3 text-[11px] font-semibold uppercase tracking-wide text-zinc-500">{children}</h4>
}

// Ficha pequena con icono: amplificador, disco, agente o bangbu.
function Ficha({ dato, id, detalle, destacado, Icono, onClick }) {
  const nombre = dato?.name ?? (id ?? '').replace(SIN_FICHA, '')
  const contenido = (
    <>
      <span className="flex h-11 w-11 shrink-0 items-center justify-center overflow-hidden rounded-lg bg-black/40 p-0.5">
        {dato?.image_url ? (
          <img src={dato.image_url} alt="" loading="lazy" className="h-full w-full object-contain" />
        ) : (
          <Icono className="h-5 w-5 text-zinc-600" />
        )}
      </span>
      <span className="min-w-0">
        <span className="block text-sm font-medium leading-snug text-white">{nombre}</span>
        {detalle && <span className="block text-xs text-zinc-500">{detalle}</span>}
      </span>
    </>
  )
  const clases = `flex w-full items-center gap-3 rounded-xl border p-2 text-left ${
    destacado ? 'border-amber-400/40 bg-amber-500/10' : 'border-white/10 bg-white/[0.03]'
  }`
  if (!dato || !onClick) return <div className={clases}>{contenido}</div>
  return (
    <button type="button" onClick={onClick} className={`${clases} transition-all duration-300 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/15`}>
      {contenido}
    </button>
  )
}

const Estrellas = ({ cuantas, de = 5 }) => (
  <span className="flex items-center gap-0.5" aria-label={`${cuantas}/${de}`}>
    {Array.from({ length: de }, (_, i) => (
      <Star key={i} className={`h-3.5 w-3.5 ${i < cuantas ? 'fill-amber-300 text-amber-300' : 'text-zinc-700'}`} />
    ))}
  </span>
)

// Build de un agente de Zenless (guias de Game8), con iconos y enlaces.
function ZzzBuild({ build, gameId }) {
  const { t } = useI18n()
  const navigate = useNavigate()

  const builds = build.builds ?? []
  const equipos = build.equipos ?? []
  const idsAmp = builds.flatMap((b) => [...(b.amplificadores?.ideales ?? []), ...(b.amplificadores?.alternativas ?? [])])
  const idsDiscos = [...builds.flatMap((b) => (b.discos ?? []).map((d) => d.conjunto)), ...(build.opcionesDiscos ?? []).flatMap((o) => o.conjuntos.map((c) => c.conjunto))]
  const idsPjs = [...equipos.flatMap((e) => e.miembros.map((m) => m.personaje)), ...(build.alternativos ?? []).map((a) => a.personaje)]
  const idsBangbus = equipos.flatMap((e) => [e.bangbu, ...(e.bangbusAlternativos ?? [])])
  const unicos = (l) => [...new Set(l.filter(tieneFicha))].join(',')
  const clave = [unicos(idsAmp), unicos(idsDiscos), unicos(idsPjs), unicos(idsBangbus)].join('|')

  const [datos, setDatos] = useState(null)

  useEffect(() => {
    let active = true
    const [amp, discos, pjs, bangbus] = clave.split('|').map((l) => l.split(',').filter(Boolean))
    const pedir = (tabla, ids, columnas) => (ids.length ? supabase.from(tabla).select(columnas).in('id', ids) : { data: [] })
    Promise.all([
      pedir('weapons', amp, 'id, name, image_url, rarity'),
      pedir('drive_discs', discos, 'id, name, image_url'),
      pedir('characters', pjs, 'id, name, image_url'),
      pedir('bangboos', bangbus, 'id, name, icon_url'),
    ]).then(([a, d, c, b]) => {
      if (!active) return
      const mapa = (lista) => Object.fromEntries((lista ?? []).map((x) => [x.id, x]))
      setDatos({
        amp: mapa(a.data),
        discos: mapa(d.data),
        pjs: mapa(c.data),
        bangbus: mapa((b.data ?? []).map((x) => ({ ...x, image_url: x.icon_url }))),
      })
    })
    return () => {
      active = false
    }
  }, [clave])

  if (!datos) {
    return (
      <div className="flex items-center gap-2 text-sm text-zinc-500">
        <Loader2 className="h-4 w-4 animate-spin" />
        {t('common.loading')}
      </div>
    )
  }

  const piezas = (n) => (n ? t('build.zzz.pieces', { count: n }) : null)
  const disco = (c, i) => (
    <Ficha
      key={`${c.conjunto}-${i}`}
      id={c.conjunto}
      dato={datos.discos[c.conjunto]}
      detalle={piezas(c.piezas)}
      Icono={Disc3}
      onClick={() => navigate(`/game/${gameId}/discs#${c.conjunto}`)}
    />
  )
  const agente = (id, detalle, key) => (
    <Ficha key={key} id={id} dato={datos.pjs[id]} detalle={detalle} Icono={Users} onClick={() => navigate(`/game/${gameId}/characters/${id}`)} />
  )
  const bangbu = (id, key, destacado) => (
    <Ficha key={key} id={id} dato={datos.bangbus[id]} destacado={destacado} Icono={Bot} onClick={() => navigate(`/game/${gameId}/bangboos/${id}`)} />
  )

  return (
    <div className="space-y-8">
      {builds.map((b, n) => (
        <div key={n} className="space-y-6">
          {builds.length > 1 && <h3 className="text-base font-semibold text-white">{b.nombre}</h3>}

          <div>
            <Titulo>{t('build.zzz.engines')}</Titulo>
            <div className="grid gap-2 sm:grid-cols-2">
              {[...(b.amplificadores?.ideales ?? []).map((id) => [id, true]), ...(b.amplificadores?.alternativas ?? []).map((id) => [id, false])].map(([id, ideal], i) => (
                <Ficha
                  key={`${id}-${i}`}
                  id={id}
                  dato={datos.amp[id]}
                  detalle={datos.amp[id]?.rarity ? t('build.zzz.grade', { grade: datos.amp[id].rarity }) : null}
                  destacado={ideal}
                  Icono={Swords}
                  onClick={() => navigate(`/game/${gameId}/weapons/${id}`)}
                />
              ))}
            </div>
          </div>

          {(b.discos ?? []).length > 0 && (
            <div>
              <Titulo>{t('build.zzz.discs')}</Titulo>
              <div className="grid gap-2 sm:grid-cols-2">{b.discos.map(disco)}</div>
            </div>
          )}

          <div>
            <Titulo>{t('build.mainStats')}</Titulo>
            <dl className="grid gap-2 sm:grid-cols-3">
              {['4', '5', '6'].map((ranura) => (
                <div key={ranura} className="rounded-xl border border-white/10 bg-white/[0.03] px-3.5 py-2.5">
                  <dt className="text-[11px] uppercase tracking-wide text-zinc-500">{t('discs.slot', { slot: ranura })}</dt>
                  <dd className="text-sm text-zinc-200">{(b.principales?.[ranura] ?? []).join(' · ') || '—'}</dd>
                </div>
              ))}
            </dl>
          </div>

          {(b.secundarias ?? []).length > 0 && (
            <div>
              <Titulo>{t('build.subStats')}</Titulo>
              <div className="flex flex-wrap gap-2">
                {b.secundarias.map((stat) => (
                  <span key={stat} className="rounded-lg bg-white/5 px-3 py-1 text-sm text-zinc-200 ring-1 ring-white/15">{stat}</span>
                ))}
              </div>
            </div>
          )}
        </div>
      ))}

      {(build.opcionesDiscos ?? []).length > 1 && (
        <div>
          <Titulo>{t('build.zzz.discOptions')}</Titulo>
          <ul className="space-y-2">
            {build.opcionesDiscos.map((o, i) => (
              <li key={i} className="rounded-xl border border-white/10 bg-black/20 p-2.5">
                {o.valoracion && (
                  <div className="mb-2 flex items-center gap-2 text-xs text-zinc-400">
                    <Estrellas cuantas={o.valoracion} de={3} />
                    {i === 0 && <span>{t('build.zzz.bestOption')}</span>}
                  </div>
                )}
                <div className="grid gap-2 sm:grid-cols-2">{o.conjuntos.map(disco)}</div>
              </li>
            ))}
          </ul>
        </div>
      )}

      {equipos.length > 0 && (
        <div>
          <Titulo>{t('build.zzz.teams')}</Titulo>
          <ul className="space-y-3">
            {equipos.map((e, i) => (
              <li key={`${e.nombre}-${i}`} className="rounded-2xl border border-white/10 bg-black/20 p-3">
                <p className="mb-2.5 text-sm font-semibold text-white">{e.nombre}</p>
                <div className="grid gap-2 sm:grid-cols-2 lg:grid-cols-4">
                  {e.miembros.map((m, k) =>
                    m.personaje ? (
                      agente(m.personaje, m.rol, `${m.personaje}-${k}`)
                    ) : (
                      <div key={`hueco-${k}`} className="flex items-center gap-3 rounded-xl border border-dashed border-white/15 p-2 text-sm text-zinc-400">
                        <span className="flex h-11 w-11 items-center justify-center rounded-lg bg-black/40"><Users className="h-5 w-5 text-zinc-600" /></span>
                        {t('build.zzz.anyAgent', { role: m.rol ?? '' })}
                      </div>
                    ),
                  )}
                  {e.bangbu && bangbu(e.bangbu, 'bangbu', true)}
                </div>
                {(e.bangbusAlternativos ?? []).length > 0 && (
                  <div className="mt-2.5">
                    <p className="mb-1.5 text-[11px] text-zinc-500">{t('build.zzz.altBangboos')}</p>
                    <div className="grid gap-2 sm:grid-cols-2 lg:grid-cols-4">
                      {e.bangbusAlternativos.map((id, k) => bangbu(id, `${id}-${k}`, false))}
                    </div>
                  </div>
                )}
              </li>
            ))}
          </ul>
        </div>
      )}

      {(build.alternativos ?? []).length > 0 && (
        <div>
          <Titulo>{t('build.zzz.alternatives')}</Titulo>
          <div className="grid gap-2 sm:grid-cols-2">
            {build.alternativos.map((a, i) => agente(a.personaje, a.tipo, `${a.personaje}-${i}`))}
          </div>
        </div>
      )}

      {(build.prioridad ?? []).length > 0 && (
        <div>
          <Titulo>{t('build.zzz.skillPriority')}</Titulo>
          <ul className="grid gap-2 sm:grid-cols-2">
            {[...build.prioridad]
              .sort((a, b) => b.estrellas - a.estrellas)
              .map((p) => (
                <li key={p.habilidad} className="flex items-center justify-between gap-3 rounded-xl border border-white/10 bg-white/[0.03] px-3.5 py-2.5">
                  <span className="text-sm text-zinc-200">{p.habilidad}</span>
                  <Estrellas cuantas={p.estrellas} />
                </li>
              ))}
          </ul>
        </div>
      )}

      <p className="text-xs text-zinc-500">{t('build.sourceZzz')}</p>
    </div>
  )
}

export default ZzzBuild

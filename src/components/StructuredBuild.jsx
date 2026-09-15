import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { Gem, Loader2, Swords } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'

// Stats principales de cada pieza, en el orden del juego.
const PIEZAS_HSR = [
  { campo: 'torso', labelKey: 'build.slot.body' },
  { campo: 'piernas', labelKey: 'build.slot.feet' },
  { campo: 'esfera', labelKey: 'build.slot.sphere' },
  { campo: 'cuerda', labelKey: 'build.slot.rope' },
]
const PIEZAS_GI = [
  { campo: 'arenas', labelKey: 'build.slot.sands' },
  { campo: 'caliz', labelKey: 'build.slot.goblet' },
  { campo: 'tiara', labelKey: 'build.slot.circlet' },
]

function Titulo({ children }) {
  return (
    <h4 className="mb-3 text-[11px] font-semibold uppercase tracking-wide text-zinc-500">
      {children}
    </h4>
  )
}

function Ficha({ imagen, nombre, detalle, destacado, onClick, Icono }) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={`flex w-full items-center gap-3 rounded-xl border p-2.5 text-left transition-all duration-300 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/15 ${
        destacado ? 'border-amber-400/40 bg-amber-500/10' : 'border-white/10 bg-white/[0.03]'
      }`}
    >
      <span className="flex h-12 w-12 shrink-0 items-center justify-center rounded-lg bg-black/40 p-1">
        {imagen ? (
          <img src={imagen} alt="" loading="lazy" className="h-full w-full object-contain" />
        ) : (
          <Icono className="h-5 w-5 text-zinc-600" />
        )}
      </span>
      <span className="min-w-0">
        <span className="block text-sm font-medium leading-snug text-white">{nombre}</span>
        {detalle && <span className="block text-xs text-zinc-500">{detalle}</span>}
      </span>
    </button>
  )
}

function StatsPorPieza({ piezas, principales, t }) {
  return (
    <div>
      <Titulo>{t('build.mainStats')}</Titulo>
      <dl className="grid gap-2 sm:grid-cols-2">
        {piezas.map((pieza) => (
          <div key={pieza.campo} className="rounded-xl border border-white/10 bg-white/[0.03] px-3.5 py-2.5">
            <dt className="text-[11px] uppercase tracking-wide text-zinc-500">{t(pieza.labelKey)}</dt>
            <dd className="text-sm text-zinc-200">{(principales[pieza.campo] ?? []).join(' · ')}</dd>
          </div>
        ))}
      </dl>
    </div>
  )
}

// Build con iconos a partir de la columna build de character_meta_guides.
// Honkai: conos, reliquias, ornamentos y stats por pieza.
// Genshin: armas, conjuntos de artefactos (4 piezas o 2+2) y stats por pieza.
// Las armas enlazan a su ficha y los conjuntos a su tarjeta.
function StructuredBuild({ build, gameId }) {
  const { t } = useI18n()
  const navigate = useNavigate()

  const esGenshin = Boolean(build.armas)
  const armasBuild = esGenshin ? build.armas : build.conos
  const idsArmas = [...(armasBuild?.ideales ?? []), ...(armasBuild?.alternativas ?? [])]
  const idsConjuntos = esGenshin
    ? [...(build.artefactos ?? []), ...(build.artefactosAlternativos ?? [])].flatMap((o) => o.conjuntos ?? [])
    : [...(build.reliquias ?? []), ...(build.ornamentos ?? [])]
  const clave = `${idsArmas.join(',')}|${idsConjuntos.join(',')}`

  const [datos, setDatos] = useState(null)

  useEffect(() => {
    let active = true
    const [armas, conjuntos] = clave.split('|').map((lista) => lista.split(',').filter(Boolean))
    Promise.all([
      armas.length
        ? supabase.from('weapons').select('id, name, image_url, rarity').in('id', armas)
        : { data: [] },
      conjuntos.length
        ? supabase.from('relic_sets').select('id, name, image_url').in('id', conjuntos)
        : { data: [] },
    ]).then(([a, c]) => {
      if (!active) return
      setDatos(Object.fromEntries([...(a.data ?? []), ...(c.data ?? [])].map((x) => [x.id, x])))
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

  const armas = (ids, destacado) =>
    ids.filter((id) => datos[id]).map((id) => (
      <Ficha
        key={id}
        imagen={datos[id].image_url}
        nombre={datos[id].name}
        detalle={datos[id].rarity ? `${datos[id].rarity}★` : null}
        destacado={destacado}
        Icono={Swords}
        onClick={() => navigate(`/game/${gameId}/weapons/${id}`)}
      />
    ))
  const conjunto = (id, detalle) =>
    datos[id] ? (
      <Ficha
        key={id}
        imagen={datos[id].image_url}
        nombre={datos[id].name}
        detalle={detalle}
        Icono={Gem}
        onClick={() => navigate(`/game/${gameId}/relics#${id}`)}
      />
    ) : null

  const ideales = armas(armasBuild?.ideales ?? [], true)
  const alternativas = armas(armasBuild?.alternativas ?? [], false)
  const bloqueArmas = (ideales.length > 0 || alternativas.length > 0) && (
    <div>
      <Titulo>{t(esGenshin ? 'build.weapons' : 'build.lightCones')}</Titulo>
      <div className="grid gap-2 sm:grid-cols-2">
        {ideales}
        {alternativas}
      </div>
    </div>
  )

  // Opcion de artefactos de Genshin: un conjunto de 4 piezas o dos de 2.
  const opcionArtefactos = (opcion, index) => (
    <div
      key={`${opcion.conjuntos.join('+')}-${index}`}
      className={opcion.piezas === '2+2' ? 'grid gap-2 rounded-xl border border-dashed border-white/10 p-2 sm:col-span-2 sm:grid-cols-2' : ''}
    >
      {opcion.conjuntos.map((id) => conjunto(id, t(opcion.piezas === '4' ? 'build.pieces4' : 'build.pieces2')))}
    </div>
  )

  return (
    <div className="space-y-6">
      {esGenshin && build.rol && (
        <p className="inline-flex rounded-full bg-white/5 px-3 py-1 text-xs text-zinc-300 ring-1 ring-white/15">
          {t('build.role', { role: build.rol })}
        </p>
      )}

      {bloqueArmas}

      {esGenshin ? (
        <>
          {(build.artefactos ?? []).length > 0 && (
            <div>
              <Titulo>{t('build.artifacts')}</Titulo>
              <div className="grid gap-2 sm:grid-cols-2">{build.artefactos.map(opcionArtefactos)}</div>
            </div>
          )}
          {(build.artefactosAlternativos ?? []).length > 0 && (
            <div>
              <Titulo>{t('build.artifactsAlt')}</Titulo>
              <div className="grid gap-2 sm:grid-cols-2">{build.artefactosAlternativos.map(opcionArtefactos)}</div>
            </div>
          )}
          {build.principales && <StatsPorPieza piezas={PIEZAS_GI} principales={build.principales} t={t} />}
        </>
      ) : (
        <>
          {(build.reliquias ?? []).length > 0 && (
            <div>
              <Titulo>{t('build.relics')}</Titulo>
              <div className="grid gap-2 sm:grid-cols-2">{build.reliquias.map((id) => conjunto(id))}</div>
            </div>
          )}
          {(build.ornamentos ?? []).length > 0 && (
            <div>
              <Titulo>{t('build.ornaments')}</Titulo>
              <div className="grid gap-2 sm:grid-cols-2">{build.ornamentos.map((id) => conjunto(id))}</div>
            </div>
          )}
          {build.principales && <StatsPorPieza piezas={PIEZAS_HSR} principales={build.principales} t={t} />}
        </>
      )}

      {(build.secundarias ?? []).length > 0 && (
        <div>
          <Titulo>{t('build.subStats')}</Titulo>
          <div className="flex flex-wrap gap-2">
            {build.secundarias.map((stat) => (
              <span key={stat} className="rounded-lg bg-white/5 px-3 py-1 text-sm text-zinc-200 ring-1 ring-white/15">
                {stat}
              </span>
            ))}
          </div>
        </div>
      )}

      <p className="text-xs text-zinc-500">{t(esGenshin ? 'build.sourceGi' : 'build.source')}</p>
    </div>
  )
}

export default StructuredBuild

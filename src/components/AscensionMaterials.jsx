import { useI18n } from '../i18n/useI18n'

// Materiales de subida de limite de nivel, del 20 al 80. Lo comparten la ficha
// de los conos de luz y la de los personajes: los dos guardan la columna
// ascension con la misma forma (desde, hasta, creditos y materiales).
//
// "creditos" es la moneda que se gasta en cada juego: creditos en Honkai, Mora
// en Genshin y Deniques en Zenless.
const CURRENCY_KEYS = {
  'genshin-impact': 'weapons.mora',
  'zenless-zone-zero': 'weapons.denny',
}

function Material({ material }) {
  return (
    <span
      title={material.nombre}
      className="flex max-w-full items-center gap-1.5 rounded-lg bg-white/5 py-1 pl-1 pr-2.5 text-sm text-zinc-300"
    >
      <img src={material.icono} alt="" loading="lazy" className="h-7 w-7 shrink-0 object-contain" />
      <span className="min-w-0 leading-snug">{material.nombre}</span>
      <span className="shrink-0 font-semibold text-white">×{material.cantidad}</span>
    </span>
  )
}

function Creditos({ amount, gameId }) {
  const { t } = useI18n()
  return (
    <span className="rounded-lg bg-amber-500/10 px-2.5 py-1.5 text-sm text-amber-200">
      {t(CURRENCY_KEYS[gameId] ?? 'weapons.credits', { amount: amount.toLocaleString('es-ES') })}
    </span>
  )
}

function AscensionMaterials({ ascension, gameId }) {
  const { t } = useI18n()
  const tramos = Array.isArray(ascension) ? ascension : []

  // Suma de todos los tramos, que es lo que de verdad se quiere saber antes de
  // ponerse a farmear: cuanto cuesta llevarlo del 1 al 80.
  const total = tramos.reduce(
    (acumulado, tramo) => {
      acumulado.creditos += tramo.creditos ?? 0
      for (const material of tramo.materiales ?? []) {
        const previo = acumulado.mapa.get(material.nombre)
        if (previo) {
          previo.cantidad += material.cantidad
        } else {
          acumulado.mapa.set(material.nombre, { ...material })
        }
      }
      return acumulado
    },
    { creditos: 0, mapa: new Map() },
  )
  const totalMateriales = [...total.mapa.values()].sort((a, b) => b.cantidad - a.cantidad)

  if (tramos.length === 0) {
    return null
  }

  return (
    <>
      <p className="mb-4 text-sm text-zinc-500">
        {t('weapons.ascensionHint', { from: tramos[0].desde, to: tramos.at(-1).hasta })}
      </p>

      <div className="space-y-3">
        {tramos.map((tramo) => (
          <div
            key={`${tramo.desde}-${tramo.hasta}`}
            className="flex flex-col gap-3 rounded-xl border border-white/10 bg-black/30 p-3.5 sm:flex-row sm:items-center"
          >
            <span className="flex shrink-0 items-center gap-1.5 text-sm font-semibold text-white sm:w-28">
              {tramo.desde}
              <span className="text-zinc-600">→</span>
              {tramo.hasta}
            </span>

            <div className="flex flex-1 flex-wrap items-center gap-2.5">
              {tramo.materiales?.map((material) => (
                <Material key={material.nombre} material={material} />
              ))}
              {tramo.creditos > 0 && <Creditos amount={tramo.creditos} gameId={gameId} />}
            </div>
          </div>
        ))}
      </div>

      {total.creditos > 0 && (
        <div className="mt-4 rounded-xl border border-white/10 bg-white/[0.03] p-3.5">
          <p className="mb-2.5 text-sm font-semibold text-white">
            {t('weapons.ascensionTotal', { to: tramos.at(-1).hasta })}
          </p>
          <div className="flex flex-wrap items-center gap-2.5">
            {totalMateriales.map((material) => (
              <Material key={material.nombre} material={material} />
            ))}
            <Creditos amount={total.creditos} gameId={gameId} />
          </div>
        </div>
      )}
    </>
  )
}

export default AscensionMaterials

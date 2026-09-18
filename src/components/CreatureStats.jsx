import { useI18n } from '../i18n/useI18n'

// Las estadisticas base de una criatura de Aniimo: PV, ATQ, RUPT., DEF F.,
// DEF M. y REGEN., mas la suma que la wiki llama "Atributos". Van sobre 100,
// que es la escala que usa el juego.
const MAXIMO = 100

function CreatureStats({ stats }) {
  const { t } = useI18n()
  const valores = Array.isArray(stats?.valores) ? stats.valores.filter((x) => x && x.campo) : []
  if (valores.length === 0) return null

  return (
    <section className="mb-8 rounded-2xl border border-white/10 bg-white/[0.02] p-4">
      <h3 className="mb-4 flex items-baseline justify-between gap-3 text-base font-semibold text-white">
        {t('character.stats')}
        {stats.total != null && (
          <span className="text-sm font-normal text-zinc-500">
            {t('character.statsTotal', { value: stats.total })}
          </span>
        )}
      </h3>
      <dl className="space-y-3">
        {valores.map((stat) => (
          <div key={stat.campo} className="flex items-center gap-3">
            <dt className="w-20 shrink-0 text-[11px] uppercase tracking-wide text-zinc-500">{stat.campo}</dt>
            <dd className="flex min-w-0 flex-1 items-center gap-3">
              <span className="h-1.5 min-w-0 flex-1 overflow-hidden rounded-full bg-white/10">
                <span
                  className="block h-full rounded-full bg-white/70"
                  style={{ width: `${Math.min(100, Math.round(((stat.valor ?? 0) / MAXIMO) * 100))}%` }}
                />
              </span>
              <span className="w-9 shrink-0 text-right text-sm font-medium text-white">{stat.valor ?? 0}</span>
            </dd>
          </div>
        ))}
      </dl>
    </section>
  )
}

export default CreatureStats

import { useState } from 'react'
import { BatteryCharging, ChevronDown, Hammer, HeartPulse, Sparkles, Swords } from 'lucide-react'
import { useI18n } from '../i18n/useI18n'
import { getElementChip } from '../data/characterStyles'

const ICONS = { Swords, Hammer, Sparkles, HeartPulse, BatteryCharging }

// Ficha de un rol: qué hace, qué stats le importan, cuántos llevar en el
// equipo y qué criaturas lo juegan. Se despliega para ver el detalle.
function RoleCard({ role, creatures, onOpenCreature, defaultOpen = false }) {
  const { t } = useI18n()
  const [abierta, setAbierta] = useState(defaultOpen)
  const Icon = ICONS[role.icon] ?? Swords

  const funciones = t(`roles.${role.id}.functions`).split('\n').filter(Boolean)
  const ejemplos = creatures.slice(0, 6)

  return (
    <article className="rounded-2xl border border-white/10 bg-white/[0.02]">
      <button
        type="button"
        onClick={() => setAbierta((x) => !x)}
        aria-expanded={abierta}
        className="flex w-full items-center gap-4 p-4 text-left focus:outline-none focus:ring-4 focus:ring-white/15 sm:p-5"
      >
        <span className={`flex h-11 w-11 shrink-0 items-center justify-center rounded-xl ring-1 ${role.chip}`}>
          <Icon className="h-5 w-5" />
        </span>

        <span className="min-w-0 flex-1">
          <span className="flex flex-wrap items-baseline gap-x-3 gap-y-1">
            <span className="text-base font-semibold text-white">{t(`roles.${role.id}.name`)}</span>
            <span className="text-xs text-zinc-500">
              {t(creatures.length === 1 ? 'roles.count' : 'roles.countPlural', { count: creatures.length })}
            </span>
          </span>
          <span className="mt-0.5 block text-sm leading-snug text-zinc-400">{t(`roles.${role.id}.specialty`)}</span>
        </span>

        <ChevronDown className={`h-4 w-4 shrink-0 text-zinc-500 transition-transform ${abierta ? 'rotate-180' : ''}`} />
      </button>

      {abierta && (
        <div className="border-t border-white/5 p-4 sm:p-5">
          <p className="mb-4 text-sm leading-relaxed text-zinc-300">{t(`roles.${role.id}.job`)}</p>

          <div className="mb-4 grid gap-4 sm:grid-cols-2">
            <section>
              <h4 className="mb-2 text-[11px] font-semibold uppercase tracking-wide text-zinc-500">
                {t('roles.inBattle')}
              </h4>
              <ul className="space-y-1.5">
                {funciones.map((linea) => (
                  <li key={linea} className="flex gap-2 text-[13px] leading-relaxed text-zinc-400">
                    <span aria-hidden="true" className="text-zinc-600">
                      •
                    </span>
                    {linea}
                  </li>
                ))}
              </ul>
            </section>

            <section className="space-y-3">
              <div>
                <h4 className="mb-1 text-[11px] font-semibold uppercase tracking-wide text-zinc-500">
                  {t('roles.priorityStats')}
                </h4>
                <p className="text-[13px] leading-relaxed text-zinc-400">{t(`roles.${role.id}.stats`)}</p>
              </div>
              <div>
                <h4 className="mb-1 text-[11px] font-semibold uppercase tracking-wide text-zinc-500">
                  {t('roles.inTeam')}
                </h4>
                <p className="text-[13px] leading-relaxed text-zinc-400">{t(`roles.${role.id}.team`)}</p>
              </div>
              <div>
                <h4 className="mb-1 text-[11px] font-semibold uppercase tracking-wide text-zinc-500">
                  {t('roles.mistake')}
                </h4>
                <p className="text-[13px] leading-relaxed text-zinc-400">{t(`roles.${role.id}.mistake`)}</p>
              </div>
            </section>
          </div>

          {ejemplos.length > 0 && (
            <section>
              <h4 className="mb-2 text-[11px] font-semibold uppercase tracking-wide text-zinc-500">
                {t('roles.examples')}
              </h4>
              <ul className="grid grid-cols-3 gap-2 sm:grid-cols-6">
                {ejemplos.map((criatura) => (
                  <li key={criatura.id}>
                    <button
                      type="button"
                      onClick={() => onOpenCreature(criatura.id)}
                      className="group flex w-full flex-col items-center gap-1 rounded-xl border border-white/10 bg-white/[0.03] p-2 transition hover:-translate-y-0.5 hover:border-white/25 hover:bg-white/[0.07] focus:outline-none focus:ring-4 focus:ring-white/15"
                    >
                      <span className="flex aspect-square w-full items-center justify-center overflow-hidden rounded-lg bg-black/30">
                        {criatura.image_url ? (
                          <img
                            src={criatura.image_url}
                            alt=""
                            loading="lazy"
                            className="h-full w-full object-contain transition-transform duration-300 group-hover:scale-105"
                          />
                        ) : (
                          <span className="text-sm font-bold text-white/70">{criatura.name.charAt(0)}</span>
                        )}
                      </span>
                      <span className="line-clamp-2 text-center text-[11px] font-medium leading-tight text-zinc-200">
                        {criatura.name}
                      </span>
                      {criatura.element && (
                        <span
                          className={`rounded-md bg-white/[0.03] px-1.5 py-0.5 text-[10px] font-medium ring-1 ${getElementChip(criatura.element)}`}
                        >
                          {criatura.element}
                        </span>
                      )}
                    </button>
                  </li>
                ))}
              </ul>
            </section>
          )}
        </div>
      )}
    </article>
  )
}

export default RoleCard

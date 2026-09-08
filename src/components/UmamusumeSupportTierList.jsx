import { useState } from 'react'
import { useParams } from 'react-router-dom'
import { AlertCircle, Info, ListOrdered } from 'lucide-react'
import { useSupportCards } from '../data/useSupportCards'
import { useI18n } from '../i18n/useI18n'
import UmamusumeLayout from './UmamusumeLayout'
import { SupportCard } from './UmamusumeSupportCards'

const BONUS_ORDER = ['Speed', 'Stamina', 'Power', 'Guts', 'Wit', 'Pal', 'Group']

const TIER_ORDER = ['S+', 'S', 'A', 'B', 'C', 'D']

const TIER_STYLES = {
  'S+': 'border-rose-500/40 bg-rose-500/10 text-rose-300',
  S: 'border-amber-500/40 bg-amber-500/10 text-amber-300',
  A: 'border-lime-500/40 bg-lime-500/10 text-lime-300',
  B: 'border-sky-500/40 bg-sky-500/10 text-sky-300',
  C: 'border-indigo-500/40 bg-indigo-500/10 text-indigo-300',
  D: 'border-zinc-500/40 bg-zinc-500/10 text-zinc-300',
}

// Cuando aun no hay tiers cargados, agrupar por rareza es la mejor aproximacion.
const RARITY_RANK = { SSR: 0, SR: 1, R: 2 }

const GROUP_STYLES = {
  SSR: 'border-amber-500/40 bg-amber-500/10 text-amber-300',
  SR: 'border-purple-500/40 bg-purple-500/10 text-purple-300',
  R: 'border-sky-500/40 bg-sky-500/10 text-sky-300',
}

function UmamusumeSupportTierList() {
  const { t } = useI18n()
  const { version } = useParams()
  const { cards, isLoading, error } = useSupportCards(version)
  const [bonus, setBonus] = useState('Speed')

  const bonuses = BONUS_ORDER.filter((b) => cards.some((c) => c.bonus === b))
  const forType = cards.filter((card) => card.bonus === bonus)
  const hasTiers = forType.some((card) => card.tier)
  const sinTier = forType.filter((card) => !card.tier)

  // Con tiers cargados agrupamos por tier; sin ellos, por rareza.
  const groups = hasTiers
    ? TIER_ORDER.filter((t) => forType.some((c) => c.tier === t)).map((tier) => ({
        key: tier,
        label: tier,
        style: TIER_STYLES[tier],
        items: forType.filter((c) => c.tier === tier),
      }))
    : ['SSR', 'SR', 'R']
        .filter((r) => forType.some((c) => c.rarity === r))
        .sort((a, b) => RARITY_RANK[a] - RARITY_RANK[b])
        .map((r) => ({
          key: r,
          label: r,
          style: GROUP_STYLES[r],
          items: forType.filter((c) => c.rarity === r),
        }))

  if (hasTiers && sinTier.length > 0) {
    groups.push({
      key: 'sin-tier',
      label: '—',
      style: 'border-white/10 bg-white/[0.02] text-zinc-500',
      items: sinTier,
    })
  }

  return (
    <UmamusumeLayout
      title={t('uma.menu.supportTierList')}
      subtitle={isLoading ? '' : `${cards.length} cartas`}
      current="tierlist-support"
    >
      {error && (
        <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
          <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
          <p>{error}</p>
        </div>
      )}

      {!isLoading && cards.length > 0 && (
        <div className="mb-8 flex items-start gap-3 rounded-xl border border-white/10 bg-white/[0.03] px-4 py-3 text-sm text-zinc-400">
          <Info className="mt-0.5 h-4 w-4 shrink-0 text-zinc-500" />
          {hasTiers ? (
            <p>
              {t('uma.tierSource')}
            </p>
          ) : (
            <p>
              {t('uma.noTiers')}
            </p>
          )}
        </div>
      )}

      <p className="mb-3 text-sm font-medium text-zinc-400">{t('uma.cardCategory')}</p>

      <div className="mb-8 flex flex-wrap gap-2">
        {bonuses.map((option) => (
          <button
            key={option}
            type="button"
            onClick={() => setBonus(option)}
            className={`rounded-lg px-4 py-2.5 text-sm font-medium transition-all duration-300 focus:outline-none focus:ring-4 focus:ring-amber-500/30 ${
              bonus === option
                ? 'bg-white text-black'
                : 'border border-white/10 text-zinc-400 hover:border-white/25 hover:text-white'
            }`}
          >
            {option}
          </button>
        ))}
      </div>

      {isLoading ? (
        <div className="space-y-4">
          {[0, 1, 2].map((slot) => (
            <div
              key={slot}
              className="h-44 animate-pulse rounded-2xl border border-white/10 bg-[#1a1a1a]"
            />
          ))}
        </div>
      ) : groups.length === 0 ? (
        <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
          <ListOrdered className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
          <p className="text-zinc-400">
            {t('uma.noCardsOfType')}
          </p>
        </div>
      ) : (
        <div className="space-y-4">
          {groups.map((group) => (
            <section
              key={group.key}
              className={`flex flex-col gap-4 rounded-2xl border p-4 sm:flex-row sm:items-start sm:p-5 ${group.style}`}
            >
              <div className="flex shrink-0 items-center gap-3 sm:w-24 sm:flex-col sm:items-start">
                <span className="text-3xl font-bold tracking-tight">
                  {group.label}
                </span>
                <span className="text-xs uppercase tracking-wide opacity-70">
                  {group.items.length}
                </span>
              </div>

              <div className="grid flex-1 grid-cols-2 gap-3 sm:grid-cols-4 lg:grid-cols-6">
                {group.items.map((card) => (
                  <SupportCard key={card.id} card={card} />
                ))}
              </div>
            </section>
          ))}
        </div>
      )}
    </UmamusumeLayout>
  )
}

export default UmamusumeSupportTierList

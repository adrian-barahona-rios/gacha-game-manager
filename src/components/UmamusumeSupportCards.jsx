import { useState } from 'react'
import { useParams } from 'react-router-dom'
import { AlertCircle, Layers } from 'lucide-react'
import { useSupportCards } from '../data/useSupportCards'
import { useI18n } from '../i18n/useI18n'
import UmamusumeLayout from './UmamusumeLayout'

const RARITY_STYLES = {
  SSR: 'bg-amber-500/15 text-amber-300 ring-amber-400/30',
  SR: 'bg-purple-500/15 text-purple-300 ring-purple-400/30',
  R: 'bg-sky-500/15 text-sky-300 ring-sky-400/30',
}

const BONUS_ORDER = ['Speed', 'Stamina', 'Power', 'Guts', 'Wit', 'Pal', 'Group']

// Pedir cientos de imagenes de golpe hace que la wiki devuelva 429.
const PAGE_SIZE = 48

// La wiki responde 429 cuando llegan muchas imagenes a la vez, asi que se
// reintenta con una espera aleatoria en lugar de dejar el hueco vacio.
const MAX_RETRIES = 4

export function SupportCard({ card }) {
  const [attempt, setAttempt] = useState(0)
  const [failed, setFailed] = useState(false)

  const handleError = () => {
    if (attempt >= MAX_RETRIES) {
      setFailed(true)
      return
    }
    const wait = 600 * (attempt + 1) + Math.random() * 800
    setTimeout(() => setAttempt((current) => current + 1), wait)
  }

  return (
    <article className="group flex flex-col rounded-2xl border border-white/10 bg-[#1a1a1a] p-3 transition-all duration-300 hover:-translate-y-1 hover:border-amber-500/40 hover:shadow-[0_0_35px_rgba(217,164,65,0.18)]">
      <div className="mb-3 flex h-36 items-center justify-center overflow-hidden rounded-xl bg-white/[0.04] ring-1 ring-white/10">
        {card.icon_url && !failed ? (
          <img
            key={attempt}
            src={card.icon_url}
            alt={card.name}
            loading="lazy"
            onError={handleError}
            className="h-full w-auto object-contain transition-transform duration-500 group-hover:scale-110"
          />
        ) : (
          <Layers className="h-8 w-8 text-zinc-600" />
        )}
      </div>

      <h3 className="mb-1 line-clamp-2 text-xs font-semibold text-white" title={card.name}>
        {card.name}
      </h3>

      <div className="mt-auto flex flex-wrap items-center gap-1.5 pt-2">
        {card.rarity && (
          <span
            className={`rounded-full px-2 py-0.5 text-[11px] font-medium ring-1 ${RARITY_STYLES[card.rarity] ?? 'bg-white/10 text-zinc-300 ring-white/20'}`}
          >
            {card.rarity}
          </span>
        )}
        {card.bonus && (
          <span className="rounded-full bg-white/5 px-2 py-0.5 text-[11px] text-zinc-400 ring-1 ring-white/10">
            {card.bonus}
          </span>
        )}
      </div>
    </article>
  )
}

function UmamusumeSupportCards() {
  const { t } = useI18n()
  const { version } = useParams()
  const { cards, isLoading, error } = useSupportCards(version)
  const [bonus, setBonus] = useState('todos')
  const [rarity, setRarity] = useState('todas')
  const [limit, setLimit] = useState(PAGE_SIZE)

  const bonuses = BONUS_ORDER.filter((b) => cards.some((c) => c.bonus === b))
  const rarities = ['SSR', 'SR', 'R'].filter((r) => cards.some((c) => c.rarity === r))

  const matching = cards.filter(
    (card) =>
      (bonus === 'todos' || card.bonus === bonus) &&
      (rarity === 'todas' || card.rarity === rarity),
  )
  const visible = matching.slice(0, limit)

  const selectClass =
    'rounded-xl border border-white/10 bg-white/[0.03] px-4 py-2.5 text-sm text-white transition-all duration-300 hover:border-white/20 focus:border-amber-500/50 focus:outline-none focus:ring-4 focus:ring-amber-500/10'

  return (
    <UmamusumeLayout
      title={t('uma.menu.supportCards')}
      subtitle={isLoading ? '' : `${cards.length} cartas`}
      current="support-cards"
    >
      {error && (
        <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
          <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
          <p>{error}</p>
        </div>
      )}

      <div className="mb-8 flex flex-wrap items-center gap-4">
        <select
          value={bonus}
          onChange={(event) => {
            setBonus(event.target.value)
            setLimit(PAGE_SIZE)
          }}
          className={selectClass}
          aria-label={t('uma.filterType')}
        >
          <option value="todos" className="bg-[#111114]">
            {t('uma.allTypes')}
          </option>
          {bonuses.map((option) => (
            <option key={option} value={option} className="bg-[#111114]">
              {option}
            </option>
          ))}
        </select>

        <select
          value={rarity}
          onChange={(event) => {
            setRarity(event.target.value)
            setLimit(PAGE_SIZE)
          }}
          className={selectClass}
          aria-label={t('uma.filterRarity')}
        >
          <option value="todas" className="bg-[#111114]">
            {t('uma.allRarities')}
          </option>
          {rarities.map((option) => (
            <option key={option} value={option} className="bg-[#111114]">
              {option}
            </option>
          ))}
        </select>

        {!isLoading && (
          <span className="text-sm text-zinc-500">
            {visible.length} de {matching.length}
          </span>
        )}
      </div>

      {isLoading ? (
        <div className="grid grid-cols-2 gap-4 sm:grid-cols-4 lg:grid-cols-6">
          {Array.from({ length: 12 }, (_, slot) => (
            <div
              key={slot}
              className="h-56 animate-pulse rounded-2xl border border-white/10 bg-[#1a1a1a]"
            />
          ))}
        </div>
      ) : visible.length === 0 ? (
        <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
          <Layers className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
          <p className="text-zinc-400">
            {cards.length === 0
              ? t('uma.noCards')
              : t('uma.noCardMatches')}
          </p>
        </div>
      ) : (
        <>
          <div className="grid grid-cols-2 gap-4 sm:grid-cols-4 lg:grid-cols-6">
            {visible.map((card) => (
              <SupportCard key={card.id} card={card} />
            ))}
          </div>

          {visible.length < matching.length && (
            <button
              type="button"
              onClick={() => setLimit((current) => current + PAGE_SIZE)}
              className="mt-8 w-full rounded-2xl border border-dashed border-white/20 bg-transparent py-6 text-sm font-semibold text-zinc-400 transition-all duration-300 hover:border-amber-500 hover:bg-amber-500/10 hover:text-white focus:outline-none focus:ring-4 focus:ring-amber-500/30 active:scale-[0.99]"
            >
              Cargar más ({matching.length - visible.length} restantes)
            </button>
          )}
        </>
      )}
    </UmamusumeLayout>
  )
}

export default UmamusumeSupportCards

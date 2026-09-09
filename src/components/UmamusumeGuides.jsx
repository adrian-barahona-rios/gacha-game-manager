import { useNavigate, useParams } from 'react-router-dom'
import { ChevronRight, Compass, Sparkles, Star, Trophy } from 'lucide-react'
import { useI18n } from '../i18n/useI18n'
import { getUmamusumeTopics } from '../data/umamusumeGuides'
import UmamusumeLayout from './UmamusumeLayout'

const ICONS = { scenario: Trophy, grades: Star, gameplay: Compass }

function UmamusumeGuides() {
  const { t, activeLanguage } = useI18n()
  const navigate = useNavigate()
  const { version } = useParams()
  const topics = getUmamusumeTopics(version)

  return (
    <UmamusumeLayout title={t('gameGuides.title')} current="guides">
      <section className="mb-8 rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
        <h2 className="mb-2 flex items-center gap-2.5 text-lg font-semibold tracking-tight text-white">
          <Compass className="h-5 w-5 text-amber-300" />
          {t('umaGuides.headline')}
        </h2>
        <p className="text-[15px] leading-7 text-zinc-400">{t('umaGuides.description')}</p>
      </section>

      <div className="grid gap-4 sm:grid-cols-2">
        {topics.map((topic) => {
          const Icon = ICONS[topic.kind] ?? Compass

          return (
            <button
              key={topic.id}
              type="button"
              onClick={() => navigate(`/game/umamusume/${version}/guides/${topic.id}`)}
              className="group flex items-center gap-4 rounded-2xl border border-white/10 bg-[#1a1a1a] p-5 text-left transition-all duration-300 hover:-translate-y-1 hover:border-amber-500/40 hover:shadow-[0_0_35px_rgba(217,164,65,0.18)] focus:outline-none focus:ring-4 focus:ring-amber-500/25"
            >
              <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-gradient-to-b from-white/15 to-white/[0.03] ring-1 ring-white/10">
                <Icon className="h-5 w-5 text-amber-200" />
              </span>

              <span className="min-w-0 flex-1">
                <span className="flex flex-wrap items-center gap-2">
                  <span className="text-[15px] font-semibold text-white">
                    {topic.name[activeLanguage]}
                  </span>
                  {topic.isNew && (
                    <span className="inline-flex items-center gap-1 rounded-full bg-amber-500/15 px-2 py-0.5 text-[10px] font-semibold uppercase tracking-wide text-amber-300 ring-1 ring-amber-400/30">
                      <Sparkles className="h-3 w-3" />
                      {t('umaGuides.latest')}
                    </span>
                  )}
                </span>
                <span className="mt-0.5 block text-xs text-zinc-500">
                  {t(`umaGuides.kind.${topic.kind}`)}
                </span>
              </span>

              <ChevronRight className="h-4 w-4 shrink-0 text-zinc-600 transition-transform duration-300 group-hover:translate-x-1 group-hover:text-white" />
            </button>
          )
        })}
      </div>
    </UmamusumeLayout>
  )
}

export default UmamusumeGuides

import { useNavigate, useParams } from 'react-router-dom'
import { ArrowLeft, Compass } from 'lucide-react'
import { useI18n } from '../i18n/useI18n'
import { getUmamusumeTopic } from '../data/umamusumeGuides'
import UmamusumeLayout from './UmamusumeLayout'
import YouTubeGuidesSection from './YouTubeGuidesSection'

function UmamusumeGuideTopic() {
  const { t, activeLanguage } = useI18n()
  const navigate = useNavigate()
  const { version, topicId } = useParams()
  const topic = getUmamusumeTopic(version, topicId)

  return (
    <UmamusumeLayout
      title={topic ? topic.name[activeLanguage] : t('gameGuides.title')}
      subtitle={topic ? t(`umaGuides.kind.${topic.kind}`) : ''}
      current="guides"
    >
      <button
        type="button"
        onClick={() => navigate(`/game/umamusume/${version}/guides`)}
        className="mb-6 inline-flex items-center gap-2 rounded-lg border border-white/10 bg-white/5 px-3 py-2.5 text-sm font-medium text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
      >
        <ArrowLeft className="h-4 w-4" />
        {t('umaGuides.backToTopics')}
      </button>

      {!topic ? (
        <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
          <Compass className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
          <p className="text-zinc-400">{t('umaGuides.notFound')}</p>
        </div>
      ) : (
        <YouTubeGuidesSection query={topic.query[activeLanguage]} key={activeLanguage} />
      )}
    </UmamusumeLayout>
  )
}

export default UmamusumeGuideTopic

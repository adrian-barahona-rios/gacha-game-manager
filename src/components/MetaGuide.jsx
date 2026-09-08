import { useEffect, useState } from 'react'
import { AlertCircle, ExternalLink, Loader2, Swords } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'

// Los tres campos de la build, en el orden en que se leen.
const BLOCKS = [
  { field: 'equipment_build', labelKey: 'guides.meta.equipment' },
  { field: 'stats', labelKey: 'guides.meta.stats' },
  { field: 'variations', labelKey: 'guides.meta.variations' },
]

function MetaGuide({ characterId }) {
  const { t } = useI18n()
  const [loaded, setLoaded] = useState(null)
  const [error, setError] = useState('')

  const isLoading = loaded?.characterId !== characterId
  const guides = isLoading ? [] : loaded.guides

  useEffect(() => {
    let active = true

    supabase
      .from('character_meta_guides')
      .select('mode, equipment_build, stats, variations, source, updated_at')
      .eq('character_id', characterId)
      .order('mode', { ascending: true })
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(t('guides.meta.error', { message: loadError.message }))
        } else {
          setLoaded({ characterId, guides: data })
          setError('')
        }
      })

    return () => {
      active = false
    }
  }, [characterId, t])

  return (
    <section className="rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
      <h2 className="mb-1.5 flex items-center gap-2.5 text-lg font-semibold tracking-tight text-white">
        <Swords className="h-5 w-5 text-amber-300" />
        {t('guides.meta.title')}
      </h2>
      <p className="mb-6 text-sm text-zinc-500">{t('guides.meta.subtitle')}</p>

      {error && (
        <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-[13px] text-red-200">
          <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
          <p>{error}</p>
        </div>
      )}

      {isLoading ? (
        <div className="flex items-center justify-center gap-3 py-10 text-sm text-zinc-500">
          <Loader2 className="h-4 w-4 animate-spin" />
          {t('common.loading')}
        </div>
      ) : guides.length === 0 ? (
        <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-10 text-center">
          <Swords className="mx-auto mb-4 h-9 w-9 text-zinc-600" />
          <p className="text-sm text-zinc-400">{t('guides.meta.empty')}</p>
        </div>
      ) : (
        <div className="space-y-6">
          {guides.map((guide) => (
            <article
              key={guide.mode}
              className="rounded-2xl border border-white/10 bg-white/[0.02] p-5 sm:p-6"
            >
              <h3 className="mb-5 inline-flex items-center rounded-full bg-amber-500/15 px-3 py-1 text-xs font-semibold uppercase tracking-wide text-amber-300 ring-1 ring-amber-400/30">
                {guide.mode}
              </h3>

              <dl className="space-y-5">
                {BLOCKS.filter((block) => guide[block.field]).map((block) => (
                  <div key={block.field}>
                    <dt className="mb-2 text-[11px] uppercase tracking-wide text-zinc-500">
                      {t(block.labelKey)}
                    </dt>
                    <dd className="whitespace-pre-line text-[15px] leading-7 text-zinc-300">
                      {guide[block.field]}
                    </dd>
                  </div>
                ))}
              </dl>

              {guide.source && (
                <a
                  href={guide.source}
                  target="_blank"
                  rel="noreferrer"
                  className="mt-5 inline-flex items-center gap-2 text-xs text-zinc-500 transition-colors duration-300 hover:text-white"
                >
                  <ExternalLink className="h-3.5 w-3.5" />
                  {t('character.officialSource')}
                </a>
              )}
            </article>
          ))}
        </div>
      )}
    </section>
  )
}

export default MetaGuide

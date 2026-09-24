import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, Loader2, Search, Sparkles } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { getElementChip } from '../data/characterStyles'
import { EFFECT_TYPES, effectStyle } from '../data/aniimoTraits'
import ProfileButton from './ProfileButton'

const sinAcentos = (texto) =>
  (texto ?? '')
    .normalize('NFD')
    .replace(/\p{Diacritic}/gu, '')
    .toLowerCase()

// Catalogo de rasgos: la pasiva de cada criatura, con lo que hace y quien la
// lleva.
function TraitCatalog() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const { t, activeLanguage } = useI18n()
  const game = getGameById(gameId)

  const [rasgos, setRasgos] = useState([])
  const [criaturas, setCriaturas] = useState({})
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')
  const [termino, setTermino] = useState('')
  const [tipo, setTipo] = useState('')

  useEffect(() => {
    let active = true

    Promise.all([
      supabase.from('traits').select('*').eq('game_id', gameId).order('name_es'),
      supabase.from('characters').select('id, name, image_url, element, role').eq('game_id', gameId),
    ]).then(([traits, chars]) => {
      if (!active) return
      const fallo = traits.error ?? chars.error
      if (fallo) {
        setError(t('traits.error.load', { message: fallo.message }))
      } else {
        setError('')
        setRasgos(traits.data ?? [])
        setCriaturas(Object.fromEntries((chars.data ?? []).map((c) => [c.id, c])))
      }
      setIsLoading(false)
    })

    return () => {
      active = false
    }
  }, [gameId, t])

  const tipos = EFFECT_TYPES.filter((item) => rasgos.some((r) => r.effect_type === item.id))
  const aguja = sinAcentos(termino.trim())
  const visibles = rasgos.filter((rasgo) => {
    if (tipo && rasgo.effect_type !== tipo) return false
    if (!aguja) return true
    const nombresCriaturas = (rasgo.creature_ids ?? []).map((id) => criaturas[id]?.name ?? '').join(' ')
    return [rasgo.name_es, rasgo.name_en, rasgo.description_es, rasgo.description_en, nombresCriaturas].some((campo) =>
      sinAcentos(campo).includes(aguja),
    )
  })

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-6xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}`)}
            aria-label={t('characters.backToGame')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">{t('traits.title')}</h1>
            <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>{game?.name ?? gameId}</p>
          </div>

          <ProfileButton />
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-6xl px-4 py-10 sm:px-6 sm:py-14">
        {error && (
          <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
            <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{error}</p>
          </div>
        )}

        <p className="mb-6 max-w-3xl text-sm leading-relaxed text-zinc-400">{t('traits.hint')}</p>

        <div className="mb-4 flex flex-wrap items-center gap-4">
          <div className="relative min-w-[15rem] flex-1">
            <input
              value={termino}
              onChange={(event) => setTermino(event.target.value)}
              placeholder={t('traits.search')}
              className="peer w-full rounded-xl border border-white/10 bg-white/[0.03] py-3 pl-11 pr-4 text-[15px] text-white placeholder:text-zinc-600 transition-all duration-300 hover:border-white/20 focus:border-white/30 focus:bg-white/[0.06] focus:outline-none focus:ring-4 focus:ring-white/5"
            />
            <Search className="pointer-events-none absolute left-3.5 top-1/2 h-[18px] w-[18px] -translate-y-1/2 text-zinc-500 transition-colors duration-300 peer-focus:text-white" />
          </div>
          {!isLoading && (
            <span className="text-sm text-zinc-500">
              {t(visibles.length === 1 ? 'traits.count' : 'traits.countPlural', { count: visibles.length })}
            </span>
          )}
        </div>

        <div className="mb-8 flex flex-wrap gap-2">
          {[{ id: '' }, ...tipos].map((item) => {
            const isActive = tipo === item.id
            return (
              <button
                key={item.id || 'todos'}
                type="button"
                aria-pressed={isActive}
                onClick={() => setTipo(item.id)}
                className={`rounded-full px-3 py-1 text-xs font-medium ring-1 transition-all duration-200 focus:outline-none focus:ring-4 focus:ring-white/15 ${
                  isActive ? 'bg-white text-black ring-white' : `bg-white/[0.03] hover:bg-white/10 ${item.id ? effectStyle(item.id) : 'text-zinc-300 ring-white/15'}`
                }`}
              >
                {item.id ? t(`traits.type.${item.id}`) : t('enemies.all')}
              </button>
            )
          })}
        </div>

        {isLoading ? (
          <div className="flex items-center justify-center gap-2.5 py-20 text-zinc-500">
            <Loader2 className="h-5 w-5 animate-spin" />
            {t('common.loading')}
          </div>
        ) : visibles.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
            <Sparkles className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
            <p className="text-zinc-400">{rasgos.length ? t('weapons.noMatches') : t('traits.empty')}</p>
          </div>
        ) : (
          <ul className="grid gap-3 lg:grid-cols-2">
            {visibles.map((rasgo) => (
              <li key={rasgo.id} className="rounded-2xl border border-white/10 bg-white/[0.02] p-4">
                <div className="mb-2 flex items-start gap-3">
                  <span className="flex h-10 w-10 shrink-0 items-center justify-center overflow-hidden rounded-xl bg-black/40">
                    {rasgo.icon_url ? (
                      <img src={rasgo.icon_url} alt="" loading="lazy" className="h-full w-full object-contain p-1" />
                    ) : (
                      <Sparkles className="h-4 w-4 text-zinc-600" />
                    )}
                  </span>
                  <div className="min-w-0 flex-1">
                    <h2 className="text-sm font-semibold leading-snug text-white">
                      {activeLanguage === 'en' ? rasgo.name_en : rasgo.name_es}
                    </h2>
                    {/* El otro idioma se ensena debajo: los nombres del juego solo
                        estan en ingles en muchas guias. */}
                    <p className="text-[11px] text-zinc-600">
                      {activeLanguage === 'en' ? rasgo.name_es : rasgo.name_en}
                    </p>
                  </div>
                  {rasgo.effect_type && (
                    <span className={`shrink-0 rounded-full px-2 py-0.5 text-[10px] font-semibold uppercase tracking-wide ring-1 ${effectStyle(rasgo.effect_type)}`}>
                      {t(`traits.type.${rasgo.effect_type}`)}
                    </span>
                  )}
                </div>

                <p className="mb-3 text-[13px] leading-relaxed text-zinc-400">
                  {(activeLanguage === 'en' ? rasgo.description_en : rasgo.description_es) ??
                    rasgo.description_es ??
                    rasgo.description_en}
                </p>

                <div className="flex flex-wrap gap-1.5">
                  {(rasgo.creature_ids ?? []).map((id) => {
                    const criatura = criaturas[id]
                    if (!criatura) return null
                    return (
                      <button
                        key={id}
                        type="button"
                        onClick={() => navigate(`/game/${gameId}/characters/${id}`)}
                        className={`flex items-center gap-1.5 rounded-full bg-white/[0.03] py-0.5 pl-0.5 pr-2.5 text-[11px] font-medium ring-1 transition hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/15 ${getElementChip(criatura.element)}`}
                      >
                        <span className="flex h-5 w-5 items-center justify-center overflow-hidden rounded-full bg-black/40">
                          {criatura.image_url && (
                            <img src={criatura.image_url} alt="" loading="lazy" className="h-full w-full object-contain" />
                          )}
                        </span>
                        {criatura.name}
                      </button>
                    )
                  })}
                </div>
              </li>
            ))}
          </ul>
        )}

        <p className="mt-6 text-xs leading-relaxed text-zinc-600">{t('traits.source')}</p>
      </main>
    </div>
  )
}

export default TraitCatalog

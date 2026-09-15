import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, BarChart3, BookOpen, Bot, Gem, Loader2, Sparkles } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { getRarityStyle } from '../data/characterStyles'
import AscensionMaterials from './AscensionMaterials'
import LevelTable from './LevelTable'
import ProfileButton from './ProfileButton'

function Bloque({ icon: Icon, title, children }) {
  return (
    <section className="mb-6 rounded-2xl border border-white/10 bg-white/[0.02] p-5 sm:p-6">
      <h2 className="mb-4 flex items-center gap-2.5 text-lg font-semibold tracking-tight text-white">
        <Icon className="h-5 w-5 text-[#7aa7ff]" />
        {title}
      </h2>
      {children}
    </section>
  )
}

// Ficha de un bangbu: ilustracion, stats por nivel, habilidades con sus
// valores por nivel, materiales de ascension e informacion adicional.
function BangbooDetail() {
  const { gameId, bangbooId } = useParams()
  const navigate = useNavigate()
  const { t } = useI18n()
  const game = getGameById(gameId)

  const [bangboo, setBangboo] = useState(null)
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')
  // Limite de nivel cuyas stats se ven. Por defecto el ultimo.
  const [nivel, setNivel] = useState(null)

  useEffect(() => {
    let active = true
    supabase
      .from('bangboos')
      .select('*')
      .eq('id', bangbooId)
      .maybeSingle()
      .then(({ data, error: loadError }) => {
        if (!active) return
        if (loadError) {
          setError(t('bangboos.error.load', { message: loadError.message }))
        } else {
          setBangboo(data)
          setError(data ? '' : t('bangboos.notFound'))
        }
        setIsLoading(false)
      })
    return () => {
      active = false
    }
  }, [bangbooId, t])

  const niveles = Array.isArray(bangboo?.levels) ? bangboo.levels : []
  const indice = nivel ?? niveles.length - 1
  const actual = niveles[indice]
  const habilidades = Array.isArray(bangboo?.skills) ? bangboo.skills : []
  const informacion = Array.isArray(bangboo?.extra_info) ? bangboo.extra_info : []

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-5xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}/bangboos`)}
            aria-label={t('common.back')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>
          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">
              {bangboo?.name ?? t('bangboos.title')}
            </h1>
            <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>{game?.name ?? gameId}</p>
          </div>
          <ProfileButton />
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-5xl px-4 py-10 sm:px-6 sm:py-14">
        {error && (
          <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
            <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{error}</p>
          </div>
        )}

        {isLoading ? (
          <div className="flex items-center justify-center gap-2.5 py-20 text-zinc-500">
            <Loader2 className="h-5 w-5 animate-spin" />
            {t('common.loading')}
          </div>
        ) : bangboo ? (
          <>
            <section className="mb-6 flex flex-col gap-6 rounded-3xl border border-white/10 bg-gradient-to-br from-white/[0.06] to-white/[0.01] p-5 sm:flex-row sm:p-7">
              <span className="flex h-64 w-full shrink-0 items-center justify-center rounded-2xl bg-black/40 p-3 sm:h-72 sm:w-72">
                {bangboo.image_url || bangboo.icon_url ? (
                  <img src={bangboo.image_url ?? bangboo.icon_url} alt={bangboo.name} className="h-full w-full object-contain" />
                ) : (
                  <Bot className="h-16 w-16 text-zinc-600" />
                )}
              </span>
              <div className="min-w-0 flex-1">
                <h2 className="text-2xl font-bold tracking-tight text-white sm:text-3xl">{bangboo.name}</h2>
                {bangboo.name_en && bangboo.name_en !== bangboo.name && (
                  <p className="mt-1 text-sm text-zinc-500">{bangboo.name_en}</p>
                )}
                <div className="mt-4 flex flex-wrap gap-2">
                  {bangboo.rarity && (
                    <span className={`rounded-full px-3 py-1 text-xs font-semibold ring-1 ${getRarityStyle(bangboo.rarity)}`}>
                      {t('bangboos.gradeValue', { grade: bangboo.rarity })}
                    </span>
                  )}
                  {bangboo.faction && (
                    <span className="flex items-center gap-1.5 rounded-full bg-white/5 px-3 py-1 text-xs text-zinc-300 ring-1 ring-white/15">
                      {bangboo.faction_icon && <img src={bangboo.faction_icon} alt="" className="h-4 w-4 object-contain" />}
                      {bangboo.faction}
                    </span>
                  )}
                  {bangboo.version && (
                    <span className="rounded-full bg-white/5 px-3 py-1 text-xs text-zinc-400 ring-1 ring-white/10">
                      {t('enemies.version', { version: bangboo.version })}
                    </span>
                  )}
                </div>
              </div>
            </section>

            {actual && (
              <Bloque icon={BarChart3} title={t('bangboos.stats')}>
                <div className="mb-4 flex flex-wrap gap-1.5">
                  {niveles.map((n, i) => (
                    <button
                      key={n.nivel}
                      type="button"
                      aria-pressed={i === indice}
                      onClick={() => setNivel(i)}
                      className={`rounded-lg px-2.5 py-1 text-xs font-medium ring-1 transition ${
                        i === indice ? 'bg-white text-black ring-white' : 'bg-white/[0.03] text-zinc-300 ring-white/15 hover:bg-white/10'
                      }`}
                    >
                      {t('bangboos.level', { level: n.nivel })}
                    </button>
                  ))}
                </div>
                <dl className="grid grid-cols-2 gap-3 sm:grid-cols-4">
                  {actual.stats.map((s) => (
                    <div key={s.nombre} className="rounded-xl border border-white/10 bg-black/20 px-3.5 py-2.5">
                      <dt className="text-[11px] uppercase tracking-wide text-zinc-500">{s.nombre}</dt>
                      <dd className="text-sm font-semibold text-white">{s.valor}</dd>
                    </div>
                  ))}
                </dl>
              </Bloque>
            )}

            {habilidades.length > 0 && (
              <Bloque icon={Sparkles} title={t('bangboos.skills')}>
                <ul className="space-y-5">
                  {habilidades.map((h, i) => (
                    <li key={`${h.nombre}-${i}`} className="border-b border-white/5 pb-5 last:border-0 last:pb-0">
                      <div className="mb-2 flex items-center gap-3">
                        {h.icono && <img src={h.icono} alt="" loading="lazy" className="h-9 w-9 rounded-lg bg-black/40 object-contain p-1" />}
                        <div>
                          <h3 className="font-semibold text-white">{h.nombre}</h3>
                          {h.tipo && <p className="text-[11px] uppercase tracking-wide text-[#7aa7ff]">{h.tipo}</p>}
                        </div>
                      </div>
                      <p className="whitespace-pre-wrap text-[14px] leading-relaxed text-zinc-300">{h.descripcion}</p>
                      <LevelTable atributos={h.atributos} />
                    </li>
                  ))}
                </ul>
              </Bloque>
            )}

            {Array.isArray(bangboo.ascension) && bangboo.ascension.length > 0 && (
              <Bloque icon={Gem} title={t('character.tab.ascension')}>
                <AscensionMaterials ascension={bangboo.ascension} gameId={gameId} />
              </Bloque>
            )}

            {informacion.length > 0 && (
              <Bloque icon={BookOpen} title={t('bangboos.extraInfo')}>
                <div className="space-y-4">
                  {informacion.map((x, i) => (
                    <div key={i}>
                      {x.titulo && <h3 className="mb-1 text-sm font-semibold text-white">{x.titulo}</h3>}
                      <p className="whitespace-pre-wrap text-[14px] leading-relaxed text-zinc-400">{x.texto}</p>
                    </div>
                  ))}
                </div>
              </Bloque>
            )}
          </>
        ) : null}
      </main>
    </div>
  )
}

export default BangbooDetail

import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, FileText, Layers, Lightbulb, Loader2, Package, Shield, Skull, Sparkles, Target } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { getElementChip } from '../data/characterStyles'
import { ENEMY_SECTIONS, RANK_STYLES } from '../data/enemies'
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

function ElementChips({ elementos }) {
  return (
    <div className="flex flex-wrap gap-2">
      {elementos.map((elemento) => (
        <span
          key={elemento}
          className={`rounded-lg bg-white/[0.03] px-3 py-1 text-sm font-medium ring-1 ${getElementChip(elemento)}`}
        >
          {elemento}
        </span>
      ))}
    </div>
  )
}

function Resistencias({ lista, t }) {
  return (
    <ul className="flex flex-wrap gap-2">
      {lista.map((r) => (
        <li
          key={r.elemento}
          className={`flex items-center gap-2 rounded-lg bg-white/[0.03] px-3 py-1 text-sm ring-1 ${getElementChip(r.elemento)}`}
        >
          {r.elemento}
          {/* Zenless no da porcentaje: solo se sabe que resiste. */}
          {(r.inmune || r.valor != null) && (
            <span className="font-semibold text-white">{r.inmune ? t('enemies.immune') : `${r.valor}%`}</span>
          )}
        </li>
      ))}
    </ul>
  )
}

function EnemyDetail() {
  const { gameId, enemyId } = useParams()
  const navigate = useNavigate()
  const { t } = useI18n()
  const game = getGameById(gameId)

  const [enemy, setEnemy] = useState(null)
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')

  useEffect(() => {
    let active = true

    supabase
      .from('enemies')
      .select('*')
      .eq('id', enemyId)
      .maybeSingle()
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(t('enemies.error.load', { message: loadError.message }))
        } else {
          setEnemy(data)
          setError(data ? '' : t('enemies.notFound'))
        }
        setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [enemyId, t])

  const debilidades = Array.isArray(enemy?.weaknesses) ? enemy.weaknesses : []
  // En Aniimo no se conocen las debilidades de los jefes: el bloque no se pinta.
  const conDebilidades = ENEMY_SECTIONS[gameId]?.filter !== 'ownElement'
  const resistencias = Array.isArray(enemy?.resistances) ? enemy.resistances : []
  const variantes = Array.isArray(enemy?.variants) ? enemy.variants : []
  const habilidades = Array.isArray(enemy?.skills) ? enemy.skills : []
  const botin = Array.isArray(enemy?.drops) ? enemy.drops : []
  // Genshin guarda consejos de combate en vez de habilidades.
  const soloConsejos = habilidades.length > 0 && habilidades.every((h) => h.tipo === 'consejo')
  // Zenless guarda los informes de la wiki (combate, informe actual...).
  const soloInformes = habilidades.length > 0 && habilidades.every((h) => h.tipo === 'informe')

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-5xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}/enemies`)}
            aria-label={t('common.back')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">
              {enemy?.name ?? t('enemies.title')}
            </h1>
            <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>
              {game?.name ?? gameId}
            </p>
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
        ) : enemy ? (
          <>
            <section className="mb-6 flex flex-col gap-6 rounded-3xl border border-white/10 bg-gradient-to-br from-white/[0.06] to-white/[0.01] p-5 sm:flex-row sm:p-7">
              <span className="flex h-64 w-full shrink-0 items-center justify-center rounded-2xl bg-black/40 p-3 sm:h-72 sm:w-72">
                {enemy.image_url ? (
                  <img
                    src={enemy.image_url}
                    alt={enemy.name}
                    className="h-full w-full object-contain"
                  />
                ) : (
                  <Skull className="h-16 w-16 text-zinc-600" />
                )}
              </span>

              <div className="min-w-0 flex-1">
                <h2 className="text-2xl font-bold tracking-tight text-white sm:text-3xl">
                  {enemy.name}
                </h2>
                {enemy.name_en && enemy.name_en !== enemy.name && (
                  <p className="mt-1 text-sm text-zinc-500">{enemy.name_en}</p>
                )}

                <div className="mt-4 flex flex-wrap gap-2">
                  <span
                    className={`rounded-full px-3 py-1 text-xs font-semibold uppercase tracking-wide ring-1 ${RANK_STYLES[enemy.rank] ?? RANK_STYLES.normal}`}
                  >
                    {t(`enemies.rank.${enemy.rank}`)}
                  </span>
                  {enemy.faction && (
                    <span className="rounded-full bg-white/5 px-3 py-1 text-xs text-zinc-300 ring-1 ring-white/15">
                      {t('enemies.faction', { faction: enemy.faction })}
                    </span>
                  )}
                  {enemy.classification && (
                    <span className="rounded-full bg-white/5 px-3 py-1 text-xs text-zinc-300 ring-1 ring-white/15">
                      {t('enemies.classification', { value: enemy.classification })}
                    </span>
                  )}
                  {enemy.version && (
                    <span className="rounded-full bg-white/5 px-3 py-1 text-xs text-zinc-400 ring-1 ring-white/10">
                      {t('enemies.version', { version: enemy.version })}
                    </span>
                  )}
                </div>

                {enemy.description && (
                  <p className="mt-5 whitespace-pre-wrap text-[15px] leading-relaxed text-zinc-300">
                    {enemy.description}
                  </p>
                )}
              </div>
            </section>

            {conDebilidades && (
              <Bloque icon={Target} title={t('enemies.weaknesses')}>
                {debilidades.length > 0 ? (
                  <ElementChips elementos={debilidades} />
                ) : (
                  <p className="text-sm text-zinc-500">{t('enemies.noWeaknesses')}</p>
                )}
              </Bloque>
            )}

            {resistencias.length > 0 && (
              <Bloque icon={Shield} title={t('enemies.resistances')}>
                <Resistencias lista={resistencias} t={t} />
              </Bloque>
            )}

            {variantes.length > 1 && (
              <Bloque icon={Layers} title={t('enemies.variants')}>
                <p className="mb-4 text-sm text-zinc-400">
                  {t(variantes.some((v) => v.nombre) ? 'enemies.relatedHint' : 'enemies.variantsHint')}
                </p>
                <ul className="space-y-3">
                  {variantes.map((variante, index) => (
                    <li
                      key={index}
                      className="rounded-xl border border-white/10 bg-black/20 p-4"
                    >
                      {variante.nombre ? (
                        // Zenless: cada variante es otra ficha de enemigo.
                        variante.id && variante.id !== enemy.id ? (
                          <button
                            type="button"
                            onClick={() => navigate(`/game/${gameId}/enemies/${variante.id}`)}
                            className="mb-2 text-left text-sm font-semibold text-white underline-offset-4 hover:underline focus:outline-none"
                          >
                            {variante.nombre}
                          </button>
                        ) : (
                          <p className="mb-2 text-sm font-semibold text-white">
                            {variante.nombre}
                            <span className="ml-2 text-[11px] font-normal text-zinc-500">{t('enemies.thisOne')}</span>
                          </p>
                        )
                      ) : (
                        <p className="mb-2 text-[11px] font-semibold uppercase tracking-wide text-zinc-500">
                          {t('enemies.variant', { number: index + 1 })}
                        </p>
                      )}
                      <div className="flex flex-wrap items-center gap-x-4 gap-y-2">
                        <span className="text-xs text-zinc-400">{t('enemies.weakTo')}</span>
                        {(variante.debilidades ?? []).length > 0 ? (
                          <ElementChips elementos={variante.debilidades} />
                        ) : (
                          <span className="text-xs text-zinc-500">{t('enemies.none')}</span>
                        )}
                      </div>
                      {(variante.resistencias ?? []).length > 0 && (
                        <div className="mt-3">
                          <Resistencias lista={variante.resistencias} t={t} />
                        </div>
                      )}
                    </li>
                  ))}
                </ul>
              </Bloque>
            )}

            {botin.length > 0 && (
              <Bloque icon={Package} title={t('enemies.drops')}>
                <ul className="grid gap-2 sm:grid-cols-2 lg:grid-cols-3">
                  {botin.map((item) => (
                    <li
                      key={item.nombre}
                      className="flex items-center gap-3 rounded-xl border border-white/10 bg-black/20 p-2"
                    >
                      <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-white/5">
                        {item.icono && (
                          <img src={item.icono} alt="" loading="lazy" className="h-full w-full object-contain" />
                        )}
                      </span>
                      <span className="min-w-0">
                        <span className="block text-sm leading-snug text-zinc-200">{item.nombre}</span>
                        {item.rareza && (
                          <span className="block text-[11px] text-amber-300/80">{'★'.repeat(item.rareza)}</span>
                        )}
                        {item.cantidad > 0 && <span className="block text-[11px] text-zinc-500">×{item.cantidad}</span>}
                      </span>
                    </li>
                  ))}
                </ul>
              </Bloque>
            )}

            {habilidades.length > 0 && (
              <Bloque
                icon={soloConsejos ? Lightbulb : soloInformes ? FileText : Sparkles}
                title={t(soloConsejos ? 'enemies.tips' : soloInformes ? 'enemies.reports' : 'enemies.skills')}
              >
                <ul className="space-y-4">
                  {habilidades.map((habilidad, index) => (
                    <li key={`${habilidad.nombre}-${index}`} className="border-b border-white/5 pb-4 last:border-0 last:pb-0">
                      <div className="mb-1 flex flex-wrap items-center gap-2">
                        {!soloConsejos && <h3 className="font-semibold text-white">{habilidad.nombre}</h3>}
                        {habilidad.elemento && (
                          <span
                            className={`rounded-md bg-white/[0.03] px-1.5 py-0.5 text-[11px] font-medium ring-1 ${getElementChip(habilidad.elemento)}`}
                          >
                            {habilidad.elemento}
                          </span>
                        )}
                      </div>
                      {habilidad.descripcion && (
                        <p className="whitespace-pre-wrap text-[14px] leading-relaxed text-zinc-400">
                          {habilidad.descripcion}
                        </p>
                      )}
                    </li>
                  ))}
                </ul>
              </Bloque>
            )}
          </>
        ) : null}
      </main>
    </div>
  )
}

export default EnemyDetail

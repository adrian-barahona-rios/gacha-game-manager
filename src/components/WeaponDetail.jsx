import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import {
  AlertCircle,
  ArrowLeft,
  ArrowUpNarrowWide,
  Loader2,
  Package,
  Sparkles,
  Swords,
  Users,
} from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { WEAPON_SECTIONS, getCategoryStyle } from '../data/weapons'
import AscensionMaterials from './AscensionMaterials'
import ProfileButton from './ProfileButton'

const RARITY_STYLES = {
  5: 'border-amber-500/50 bg-amber-950',
  4: 'border-purple-500/50 bg-purple-950',
  3: 'border-sky-500/50 bg-sky-950',
  2: 'border-emerald-500/50 bg-emerald-950',
  1: 'border-zinc-500/50 bg-zinc-900',
}

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

function WeaponDetail() {
  const { gameId, weaponId } = useParams()
  const navigate = useNavigate()
  const { t } = useI18n()
  const game = getGameById(gameId)
  const seccion = WEAPON_SECTIONS[gameId]

  const [weapon, setWeapon] = useState(null)
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')
  // Nivel de superposicion o refinamiento que se esta mirando, de 0 a 4.
  const [rank, setRank] = useState(0)

  useEffect(() => {
    let active = true

    supabase
      .from('weapons')
      .select('*')
      .eq('id', weaponId)
      .maybeSingle()
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(t('weapons.error.load', { message: loadError.message }))
        } else {
          setWeapon(data)
          setError(data ? '' : t('weapons.notFound'))
        }
        setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [weaponId, t])

  const niveles = Array.isArray(weapon?.passive_levels) ? weapon.passive_levels : []
  const ascension = Array.isArray(weapon?.ascension) ? weapon.ascension : []

  // La stat secundaria (solo en Genshin) ya viene con su nombre traducido, asi
  // que se pasa tal cual en vez de como clave de traduccion.
  const stats = [
    [t('weapons.stat.hp'), weapon?.base_hp],
    [t('weapons.stat.atk'), weapon?.base_atk],
    [t('weapons.stat.def'), weapon?.base_def],
    [weapon?.sub_stat_name, weapon?.sub_stat_value],
  ].filter(([nombre, valor]) => nombre && valor !== null && valor !== undefined)

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-5xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}/weapons`)}
            aria-label={t('common.back')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">
              {weapon?.name ?? t(seccion?.titleKey ?? 'weapons.title')}
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
        ) : weapon ? (
          <>
            <section
              className={`mb-6 flex flex-col gap-6 rounded-3xl border p-5 sm:flex-row sm:p-7 ${RARITY_STYLES[Number(weapon.rarity)] ?? RARITY_STYLES[1]}`}
            >
              <span className="flex h-48 w-full shrink-0 items-center justify-center rounded-2xl bg-black/40 p-3 sm:w-48">
                {weapon.image_url ? (
                  <img
                    src={weapon.image_url}
                    alt={weapon.name}
                    className="h-full w-auto max-w-full object-contain"
                  />
                ) : (
                  <Swords className="h-12 w-12 text-zinc-600" />
                )}
              </span>

              <div className="min-w-0 flex-1">
                <h2 className="mb-2 text-2xl font-semibold tracking-tight text-white sm:text-3xl">
                  {weapon.name}
                </h2>

                <div className="mb-4 flex flex-wrap items-center gap-2 text-xs">
                  <span className="font-semibold text-amber-300">
                    {'★'.repeat(Number(weapon.rarity) || 1)}
                  </span>
                  {weapon.category && (
                    <span
                      className={`rounded-full bg-black/40 px-2.5 py-1 font-medium ring-1 ${getCategoryStyle(weapon.category)}`}
                    >
                      {weapon.category}
                    </span>
                  )}
                  {weapon.name_en && weapon.name_en !== weapon.name && (
                    <span className="text-zinc-500">{weapon.name_en}</span>
                  )}
                </div>

                {stats.length > 0 && (
                  <div className={`grid gap-3 ${stats.length === 2 ? 'grid-cols-2' : 'grid-cols-3'}`}>
                    {stats.map(([nombre, valor]) => (
                      <div key={nombre} className="rounded-xl bg-black/40 p-3 text-center">
                        <p className="mb-1 text-[11px] uppercase tracking-wide text-zinc-400">
                          {nombre}
                        </p>
                        <p className="text-lg font-semibold text-white">{valor}</p>
                      </div>
                    ))}
                  </div>
                )}
                {stats.length > 0 && (
                  <p className="mt-2 text-[11px] text-zinc-500">{t('weapons.stat.atMaxLevel')}</p>
                )}
              </div>
            </section>

            {niveles.length > 0 && (
              <Bloque icon={Sparkles} title={weapon.passive_name ?? t('weapons.passive')}>
                <div className="mb-4 flex flex-wrap gap-2">
                  {niveles.map((_, index) => (
                    <button
                      key={index}
                      type="button"
                      onClick={() => setRank(index)}
                      aria-pressed={index === rank}
                      className={`rounded-lg px-3.5 py-2 text-sm font-semibold transition-all duration-300 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95 ${
                        index === rank
                          ? 'bg-white text-black'
                          : 'border border-white/15 text-zinc-300 hover:border-white/30 hover:text-white'
                      }`}
                    >
                      {t(seccion?.rankKey ?? 'weapons.rank', { level: index + 1 })}
                    </button>
                  ))}
                </div>

                <p className="whitespace-pre-wrap text-[15px] leading-relaxed text-zinc-300">
                  {niveles[rank]}
                </p>
              </Bloque>
            )}

            <Bloque icon={Package} title={t('weapons.howToGet')}>
              {weapon.how_to_get ? (
                <ul className="space-y-2">
                  {weapon.how_to_get.split(' · ').map((linea) => (
                    <li key={linea} className="flex gap-2.5 text-[15px] leading-relaxed text-zinc-300">
                      <span className="mt-2 h-1.5 w-1.5 shrink-0 rounded-full bg-[#7aa7ff]" />
                      {linea}
                    </li>
                  ))}
                </ul>
              ) : (
                <p className="text-sm text-zinc-500">{t('weapons.howToGetEmpty')}</p>
              )}
            </Bloque>

            {ascension.length > 0 && (
              <Bloque icon={ArrowUpNarrowWide} title={t('weapons.ascension')}>
                <AscensionMaterials ascension={ascension} gameId={gameId} />
              </Bloque>
            )}

            <Bloque icon={Users} title={t('weapons.goodFor')}>
              {weapon.good_for ? (
                <p className="whitespace-pre-wrap text-[15px] leading-relaxed text-zinc-300">
                  {weapon.good_for}
                </p>
              ) : (
                <p className="text-sm text-zinc-500">{t('weapons.goodForEmpty')}</p>
              )}
            </Bloque>

            {weapon.description && (
              <section className="rounded-2xl border border-white/10 bg-white/[0.02] p-5 sm:p-6">
                <p className="whitespace-pre-wrap text-sm italic leading-relaxed text-zinc-400">
                  {weapon.description}
                </p>
              </section>
            )}
          </>
        ) : null}
      </main>
    </div>
  )
}

export default WeaponDetail

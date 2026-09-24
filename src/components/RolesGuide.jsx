import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, Loader2 } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { ROLES } from '../data/aniimoRoles'
import RoleCard from './RoleCard'
import ProfileButton from './ProfileButton'

// Guia de roles: que hace cada uno de los cinco roles del juego, con las
// criaturas que lo juegan sacadas de la propia base de datos.
function RolesGuide() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const { t } = useI18n()
  const game = getGameById(gameId)

  const [criaturas, setCriaturas] = useState([])
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')

  useEffect(() => {
    let active = true

    supabase
      .from('characters')
      .select('id, name, image_url, element, role')
      .eq('game_id', gameId)
      .order('name')
      .then(({ data, error: loadError }) => {
        if (!active) return
        if (loadError) {
          setError(t('roles.error.load', { message: loadError.message }))
        } else {
          setError('')
          setCriaturas(data ?? [])
        }
        setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [gameId, t])

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-5xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}`)}
            aria-label={t('characters.backToGame')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">{t('roles.title')}</h1>
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

        <p className="mb-8 max-w-3xl text-sm leading-relaxed text-zinc-400">{t('roles.hint')}</p>

        {isLoading ? (
          <div className="flex items-center justify-center gap-2.5 py-20 text-zinc-500">
            <Loader2 className="h-5 w-5 animate-spin" />
            {t('common.loading')}
          </div>
        ) : (
          <>
            <div className="mb-10 space-y-3">
              {ROLES.map((role, index) => (
                <RoleCard
                  key={role.id}
                  role={role}
                  defaultOpen={index === 0}
                  creatures={criaturas.filter((c) => c.role === role.value)}
                  onOpenCreature={(id) => navigate(`/game/${gameId}/characters/${id}`)}
                />
              ))}
            </div>

            <section className="rounded-2xl border border-white/10 bg-white/[0.02] p-5">
              <h2 className="mb-1 text-base font-semibold text-white">{t('roles.teamTitle')}</h2>
              <p className="mb-4 text-sm leading-relaxed text-zinc-400">{t('roles.teamHint')}</p>

              <div className="grid gap-3 sm:grid-cols-3">
                {['balanced', 'boss', 'explore'].map((plan) => (
                  <div key={plan} className="rounded-xl border border-white/10 bg-black/20 p-4">
                    <h3 className="mb-1 text-sm font-semibold text-white">{t(`roles.team.${plan}.title`)}</h3>
                    <p className="mb-2 text-[13px] font-medium text-zinc-300">{t(`roles.team.${plan}.slots`)}</p>
                    <p className="text-[13px] leading-relaxed text-zinc-500">{t(`roles.team.${plan}.why`)}</p>
                  </div>
                ))}
              </div>

              <h3 className="mb-2 mt-6 text-sm font-semibold text-white">{t('roles.avoidTitle')}</h3>
              <ul className="space-y-1.5">
                {t('roles.avoid').split('\n').filter(Boolean).map((linea) => (
                  <li key={linea} className="flex gap-2 text-[13px] leading-relaxed text-zinc-400">
                    <span aria-hidden="true" className="text-rose-400/70">
                      ✕
                    </span>
                    {linea}
                  </li>
                ))}
              </ul>
            </section>

            <p className="mt-6 text-xs leading-relaxed text-zinc-600">{t('roles.source')}</p>
          </>
        )}
      </main>
    </div>
  )
}

export default RolesGuide

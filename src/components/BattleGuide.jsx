import { useNavigate, useParams } from 'react-router-dom'
import { ArrowLeft, Gauge, Grid3x3, Keyboard, Shield, Sparkles, Users } from 'lucide-react'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { ROLES } from '../data/aniimoRoles'
import ProfileButton from './ProfileButton'

// Las teclas por defecto en PC. Si el juego las cambia, solo hay que tocar
// aqui y el texto de cada una vive en strings.js.
const KEYS = [
  { key: 'C', id: 'twine' },
  { key: 'Shift', id: 'dodge' },
  { key: 'Q / E', id: 'basic' },
  { key: 'R', id: 'burst' },
  { key: 'T', id: 'mobility' },
  { key: 'Y', id: 'chain' },
  { key: 'Tab', id: 'lock' },
  { key: '1-4', id: 'swap' },
  { key: 'K', id: 'stance' },
]

function Bloque({ icon: Icon, title, children }) {
  return (
    <section className="mb-6 rounded-2xl border border-white/10 bg-white/[0.02] p-5">
      <h2 className="mb-3 flex items-center gap-2.5 text-base font-semibold text-white">
        <Icon className="h-4 w-4 text-zinc-500" />
        {title}
      </h2>
      {children}
    </section>
  )
}

// Parrafos separados por saltos de linea en el texto traducido.
function Texto({ value }) {
  return (
    <>
      {value
        .split('\n')
        .filter(Boolean)
        .map((parrafo) => (
          <p key={parrafo} className="mb-2.5 text-sm leading-relaxed text-zinc-400 last:mb-0">
            {parrafo}
          </p>
        ))}
    </>
  )
}

// Guia de combate: como funciona una pelea, la barra de ruptura, los roles y
// los tipos. Lo que no se sabe con seguridad no esta aqui.
function BattleGuide() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const { t } = useI18n()
  const game = getGameById(gameId)

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-4xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}`)}
            aria-label={t('characters.backToGame')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">{t('battle.title')}</h1>
            <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>{game?.name ?? gameId}</p>
          </div>

          <ProfileButton />
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-4xl px-4 py-10 sm:px-6 sm:py-14">
        <p className="mb-8 max-w-3xl text-sm leading-relaxed text-zinc-400">{t('battle.hint')}</p>

        <Bloque icon={Sparkles} title={t('battle.basics.title')}>
          <Texto value={t('battle.basics.body')} />
        </Bloque>

        <Bloque icon={Gauge} title={t('battle.break.title')}>
          <Texto value={t('battle.break.body')} />
          <ol className="mt-3 space-y-2">
            {t('battle.break.loop')
              .split('\n')
              .filter(Boolean)
              .map((paso, index) => (
                <li key={paso} className="flex gap-3 text-sm leading-relaxed text-zinc-300">
                  <span className="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-white/10 text-[11px] font-semibold text-white">
                    {index + 1}
                  </span>
                  {paso}
                </li>
              ))}
          </ol>
        </Bloque>

        <Bloque icon={Users} title={t('battle.roles.title')}>
          <Texto value={t('battle.roles.body')} />
          <ul className="mt-3 space-y-2">
            {ROLES.map((role) => (
              <li key={role.id} className="flex flex-wrap items-baseline gap-x-3 gap-y-1">
                <span className={`rounded-md px-2 py-0.5 text-xs font-semibold ring-1 ${role.chip}`}>
                  {t(`roles.${role.id}.name`)}
                </span>
                <span className="text-[13px] leading-relaxed text-zinc-400">{t(`roles.${role.id}.specialty`)}</span>
              </li>
            ))}
          </ul>
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}/roles`)}
            className="mt-4 rounded-lg border border-white/15 bg-white/[0.03] px-3.5 py-2 text-sm font-medium text-zinc-200 transition hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/15"
          >
            {t('battle.roles.link')}
          </button>
        </Bloque>

        <Bloque icon={Grid3x3} title={t('battle.types.title')}>
          <Texto value={t('battle.types.body')} />
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}/type-chart`)}
            className="mt-2 rounded-lg border border-white/15 bg-white/[0.03] px-3.5 py-2 text-sm font-medium text-zinc-200 transition hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/15"
          >
            {t('battle.types.link')}
          </button>
        </Bloque>

        <Bloque icon={Shield} title={t('battle.stance.title')}>
          <Texto value={t('battle.stance.body')} />
        </Bloque>

        <Bloque icon={Keyboard} title={t('battle.keys.title')}>
          <p className="mb-3 text-sm leading-relaxed text-zinc-400">{t('battle.keys.body')}</p>
          <dl className="grid gap-2 sm:grid-cols-2">
            {KEYS.map((item) => (
              <div key={item.id} className="flex items-baseline gap-3 rounded-xl border border-white/10 bg-black/20 px-3 py-2">
                <dt className="shrink-0 rounded-md bg-white/10 px-2 py-0.5 font-mono text-[11px] font-semibold text-white">
                  {item.key}
                </dt>
                <dd className="text-[13px] leading-snug text-zinc-400">{t(`battle.keys.${item.id}`)}</dd>
              </div>
            ))}
          </dl>
        </Bloque>

        <p className="text-xs leading-relaxed text-zinc-600">{t('battle.source')}</p>
      </main>
    </div>
  )
}

export default BattleGuide

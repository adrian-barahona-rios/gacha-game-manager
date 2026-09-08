import { useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import {
  ArrowLeft,
  ChevronDown,
  Globe,
  Layers,
  ListOrdered,
  Users,
} from 'lucide-react'
import { useI18n } from '../i18n/useI18n'

const VERSION_KEYS = { global: 'uma.version.global', japan: 'uma.version.japan' }

const MENU = [
  { id: 'version', labelKey: 'uma.menu.changeVersion', icon: Globe, to: '' },
  { id: 'characters', labelKey: 'uma.menu.characters', icon: Users, to: 'characters' },
  { id: 'support-cards', labelKey: 'uma.menu.supportCards', icon: Layers, to: 'support-cards' },
  {
    id: 'tierlist-support',
    labelKey: 'uma.menu.supportTierList',
    icon: ListOrdered,
    to: 'tierlist-support',
  },
]

function UmamusumeLayout({ title, subtitle, current, children }) {
  const { t } = useI18n()
  const { version } = useParams()
  const navigate = useNavigate()
  const [isMenuOpen, setIsMenuOpen] = useState(false)

  const go = (to) => {
    setIsMenuOpen(false)
    navigate(to ? `/game/umamusume/${version}/${to}` : '/game/umamusume')
  }

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <div className="pointer-events-none fixed inset-0" aria-hidden="true">
        <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_50%_0%,rgba(217,164,65,0.14),transparent_60%)]" />
        <div className="absolute inset-x-0 bottom-0 h-[32%] bg-[linear-gradient(to_top,rgba(88,50,22,0.55),transparent)]" />
      </div>

      <header className="sticky top-0 z-30 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-7xl items-center gap-3 px-4 py-4 sm:gap-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate('/game/umamusume')}
            aria-label={t('uma.backToVersions')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">
              {title}
            </h1>
            <p className="truncate text-xs text-amber-200 sm:text-sm">
              {VERSION_KEYS[version] ? t(VERSION_KEYS[version]) : version}
              {subtitle ? ` · ${subtitle}` : ''}
            </p>
          </div>

          <div className="relative shrink-0">
            <button
              type="button"
              onClick={() => setIsMenuOpen((open) => !open)}
              aria-expanded={isMenuOpen}
              aria-haspopup="menu"
              className="flex items-center gap-2 rounded-lg bg-white px-3 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:bg-amber-400 hover:shadow-[0_0_25px_rgba(251,191,36,0.5)] focus:outline-none focus:ring-4 focus:ring-amber-500/30 active:scale-95 sm:px-4"
            >
              <span className="hidden sm:inline">{t('uma.menu.label')}</span>
              <ChevronDown
                className={`h-4 w-4 transition-transform duration-300 ${isMenuOpen ? 'rotate-180' : ''}`}
              />
            </button>

            {isMenuOpen && (
              <>
                <button
                  type="button"
                  aria-label={t('game.closeMenu')}
                  onClick={() => setIsMenuOpen(false)}
                  className="fixed inset-0 z-10 cursor-default"
                />
                <div
                  role="menu"
                  className="absolute right-0 z-20 mt-2 w-60 overflow-hidden rounded-xl border border-white/10 bg-[#0e0e12]/95 p-1.5 shadow-2xl shadow-black/80 backdrop-blur-xl"
                >
                  {MENU.map((item) => {
                    const Icon = item.icon
                    const isCurrent = item.id === current

                    return (
                      <button
                        key={item.id}
                        type="button"
                        role="menuitem"
                        onClick={() => go(item.to)}
                        className={`flex w-full items-center gap-3 rounded-lg px-3 py-2.5 text-left text-sm transition-colors duration-200 ${
                          isCurrent
                            ? 'bg-white/10 font-medium text-white'
                            : 'text-zinc-300 hover:bg-white/5 hover:text-white'
                        }`}
                      >
                        <Icon className="h-4 w-4 shrink-0" />
                        {t(item.labelKey)}
                      </button>
                    )
                  })}
                </div>
              </>
            )}
          </div>
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-7xl px-4 py-10 sm:px-6 sm:py-14">
        {children}
      </main>
    </div>
  )
}

export default UmamusumeLayout

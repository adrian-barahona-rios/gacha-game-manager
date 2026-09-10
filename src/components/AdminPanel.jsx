import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { ArrowLeft, BookOpen, ListOrdered, ShieldCheck, Swords, UserPlus } from 'lucide-react'
import { useI18n } from '../i18n/useI18n'
import AdminBiographyEditor from './AdminBiographyEditor'
import AdminCharacterForm from './AdminCharacterForm'
import AdminMetaGuides from './AdminMetaGuides'
import AdminTierEditor from './AdminTierEditor'
import ProfileButton from './ProfileButton'

const SECTIONS = [
  { id: 'personajes', labelKey: 'admin.tab.characters', icon: UserPlus },
  { id: 'tierlist', labelKey: 'admin.tab.tierLists', icon: ListOrdered },
  { id: 'biografias', labelKey: 'admin.tab.biographies', icon: BookOpen },
  { id: 'guias', labelKey: 'admin.tab.metaGuides', icon: Swords },
]

function AdminPanel() {
  const { t } = useI18n()
  const navigate = useNavigate()
  const [section, setSection] = useState('personajes')

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <div className="pointer-events-none fixed inset-0" aria-hidden="true">
        <div className="absolute -top-40 left-[10%] h-[30rem] w-[30rem] animate-pulse rounded-full bg-emerald-600/10 blur-[130px] [animation-duration:12s]" />
      </div>

      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-5xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate('/dashboard')}
            aria-label={t('game.backToDashboard')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="flex items-center gap-2.5 truncate text-lg font-semibold tracking-tight text-white sm:text-xl">
              <ShieldCheck className="h-5 w-5 shrink-0 text-emerald-400" />
              {t('admin.title')}
            </h1>
            <p className="truncate text-xs text-zinc-500 sm:text-sm">{t('admin.subtitle')}</p>
          </div>
          <ProfileButton />
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-5xl px-4 py-10 sm:px-6 sm:py-14">
        <div className="mb-8 flex flex-wrap gap-2 rounded-2xl border border-white/10 bg-white/[0.02] p-1.5">
          {SECTIONS.map((tab) => {
            const Icon = tab.icon
            const isActive = tab.id === section

            return (
              <button
                key={tab.id}
                type="button"
                onClick={() => setSection(tab.id)}
                className={`flex flex-1 items-center justify-center gap-2 rounded-xl px-4 py-2.5 text-sm font-medium transition-all duration-300 focus:outline-none focus:ring-4 focus:ring-white/10 ${
                  isActive
                    ? 'bg-white text-black'
                    : 'text-zinc-400 hover:bg-white/5 hover:text-white'
                }`}
              >
                <Icon className="h-4 w-4 shrink-0" />
                <span className="truncate">{t(tab.labelKey)}</span>
              </button>
            )
          })}
        </div>

        <section className="rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
          {section === 'personajes' && <AdminCharacterForm />}
          {section === 'tierlist' && <AdminTierEditor />}
          {section === 'biografias' && <AdminBiographyEditor />}
          {section === 'guias' && <AdminMetaGuides />}
        </section>
      </main>
    </div>
  )
}

export default AdminPanel

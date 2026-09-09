import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { User } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'

// Acceso al perfil desde la cabecera de cualquier pantalla de la aplicacion.
// Sin sesion no se dibuja nada: no tiene sentido ofrecer un boton que llevaria
// a una pagina vacia.
function ProfileButton() {
  const { t } = useI18n()
  const navigate = useNavigate()
  const [user, setUser] = useState(null)

  useEffect(() => {
    let active = true

    supabase.auth.getSession().then(({ data }) => {
      if (active) {
        setUser(data.session?.user ?? null)
      }
    })

    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((_event, session) => {
      setUser(session?.user ?? null)
    })

    return () => {
      active = false
      subscription.unsubscribe()
    }
  }, [])

  if (!user) {
    return null
  }

  const displayName =
    user.user_metadata?.username ?? user.email?.split('@')[0] ?? t('dashboard.myProfile')

  return (
    <button
      type="button"
      onClick={() => navigate('/profile')}
      title={t('dashboard.yourProfile')}
      aria-label={t('dashboard.yourProfile')}
      className="ml-auto flex shrink-0 items-center gap-2.5 rounded-full border border-white/10 bg-white/5 py-1.5 pl-1.5 pr-1.5 text-sm text-zinc-300 transition-all duration-300 hover:border-[#0066ff] hover:bg-[#0066ff]/15 hover:text-white hover:shadow-[0_0_20px_rgba(0,102,255,0.3)] focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:scale-95 sm:pr-4"
    >
      <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-white/10">
        <User className="h-4 w-4" />
      </span>
      <span className="hidden max-w-[10rem] truncate sm:inline">{displayName}</span>
    </button>
  )
}

export default ProfileButton

import { useEffect, useState } from 'react'
import { Navigate } from 'react-router-dom'
import { Loader2 } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'

// El rol se comprueba contra la base de datos en cada carga, nunca se guarda en
// el navegador: si alguien deja de ser admin, pierde el acceso al recargar.
// La barrera real esta en las politicas RLS de Supabase (supabase/admin.sql);
// esto solo evita mostrar una pantalla que no serviria de nada.
function AdminGuard({ children }) {
  const { t } = useI18n()
  const [status, setStatus] = useState('checking')

  useEffect(() => {
    let active = true

    supabase.auth.getSession().then(({ data }) => {
      if (!active) {
        return
      }

      if (!data.session) {
        setStatus('denied')
        return
      }

      supabase
        .from('profiles')
        .select('role')
        .eq('id', data.session.user.id)
        .maybeSingle()
        .then(({ data: profile }) => {
          if (active) {
            setStatus(profile?.role === 'admin' ? 'allowed' : 'denied')
          }
        })
    })

    return () => {
      active = false
    }
  }, [])

  if (status === 'checking') {
    return (
      <div className="flex min-h-screen scheme-dark items-center justify-center gap-3 bg-black text-sm text-zinc-500">
        <Loader2 className="h-4 w-4 animate-spin" />
        {t('admin.checking')}
      </div>
    )
  }

  if (status === 'denied') {
    return <Navigate to="/dashboard" replace />
  }

  return children
}

export default AdminGuard

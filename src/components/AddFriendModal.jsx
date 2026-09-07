import { useState } from 'react'
import { AlertCircle, Check, Loader2, Search, UserPlus, X } from 'lucide-react'
import { findProfile, sendFriendRequest } from '../data/friends'

function AddFriendModal({ userId, relations, onClose, onSent }) {
  const [term, setTerm] = useState('')
  const [isSearching, setIsSearching] = useState(false)
  const [error, setError] = useState('')
  const [notice, setNotice] = useState('')

  const handleSubmit = async (event) => {
    event.preventDefault()
    setError('')
    setNotice('')

    if (!term.trim()) {
      setError('Escribe el ID o el nombre de usuario de tu amigo.')
      return
    }

    setIsSearching(true)
    const { profile, error: findError } = await findProfile(term)

    if (findError) {
      setIsSearching(false)
      setError(`No se pudo buscar: ${findError.message}`)
      return
    }

    if (!profile) {
      setIsSearching(false)
      setError('No existe ningún usuario con ese ID o nombre.')
      return
    }

    if (profile.id === userId) {
      setIsSearching(false)
      setError('Ese eres tú.')
      return
    }

    const existing = relations.find((item) => item.profile.id === profile.id)

    if (existing) {
      setIsSearching(false)
      if (existing.status === 'accepted') {
        setNotice(`${profile.username ?? 'Ese usuario'} ya es tu amigo.`)
      } else if (existing.direction === 'outgoing') {
        setNotice('Solicitud enviada. Está esperando respuesta.')
      } else {
        setNotice('Esa persona ya te envió una solicitud: acéptala más abajo.')
      }
      return
    }

    const { error: sendError } = await sendFriendRequest(userId, profile.id)
    setIsSearching(false)

    if (sendError) {
      setError(`No se pudo enviar la solicitud: ${sendError.message}`)
      return
    }

    setNotice(`Solicitud enviada a ${profile.username ?? 'ese usuario'}.`)
    setTerm('')
    onSent()
  }

  return (
    <div className="fixed inset-0 z-40 flex items-center justify-center bg-black/70 px-4 py-10 backdrop-blur-sm">
      <div className="w-full max-w-md rounded-3xl border border-white/10 bg-[#111114] p-6 shadow-2xl shadow-black/80 sm:p-8">
        <div className="mb-6 flex items-start justify-between gap-4">
          <div>
            <h2 className="text-xl font-semibold tracking-tight text-white">
              Buscar amigos
            </h2>
            <p className="mt-1.5 text-sm text-zinc-500">
              Introduce el ID de cuenta o el nombre de usuario.
            </p>
          </div>
          <button
            type="button"
            onClick={onClose}
            aria-label="Cerrar"
            className="shrink-0 rounded-lg p-2 text-zinc-400 transition-colors duration-300 hover:bg-white/10 hover:text-white focus:outline-none focus:ring-2 focus:ring-white/30"
          >
            <X className="h-5 w-5" />
          </button>
        </div>

        {error && (
          <div className="mb-5 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-[13px] text-red-200">
            <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{error}</p>
          </div>
        )}

        {notice && (
          <div className="mb-5 flex items-start gap-3 rounded-xl border border-emerald-500/30 bg-emerald-500/10 px-4 py-3 text-[13px] text-emerald-200">
            <Check className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{notice}</p>
          </div>
        )}

        <form onSubmit={handleSubmit} noValidate>
          <div className="relative">
            <input
              autoFocus
              value={term}
              onChange={(event) => {
                setTerm(event.target.value)
                setError('')
                setNotice('')
              }}
              placeholder="ID de amigo o nombre de usuario"
              className="peer w-full rounded-xl border border-white/10 bg-white/[0.03] py-3.5 pl-11 pr-4 text-[15px] text-white placeholder:text-zinc-600 transition-all duration-300 hover:border-white/20 focus:border-white/30 focus:bg-white/[0.06] focus:outline-none focus:ring-4 focus:ring-white/5"
            />
            <Search className="pointer-events-none absolute left-3.5 top-1/2 h-[18px] w-[18px] -translate-y-1/2 text-zinc-500 transition-colors duration-300 peer-focus:text-white" />
          </div>

          <button
            type="submit"
            disabled={isSearching}
            className="mt-5 flex w-full items-center justify-center gap-2 rounded-xl bg-white py-3 text-sm font-semibold text-black transition-all duration-300 hover:bg-[#0066ff] hover:text-white hover:shadow-[0_0_25px_rgba(0,102,255,0.65)] focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:scale-95 disabled:cursor-not-allowed disabled:opacity-60"
          >
            {isSearching ? (
              <>
                <Loader2 className="h-4 w-4 animate-spin" />
                Buscando…
              </>
            ) : (
              <>
                <UserPlus className="h-4 w-4" />
                Enviar solicitud
              </>
            )}
          </button>
        </form>
      </div>
    </div>
  )
}

export default AddFriendModal

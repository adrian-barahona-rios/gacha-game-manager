import { useNavigate } from 'react-router-dom'
import { Loader2, Plus, User, UserMinus, Users } from 'lucide-react'

function FriendsList({ friends, removingId, onAdd, onRemove }) {
  const navigate = useNavigate()

  return (
    <section className="rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
      <div className="mb-6 flex items-center justify-between gap-4">
        <div>
          <h2 className="text-lg font-semibold tracking-tight text-white">
            Tus amigos
          </h2>
          <p className="mt-1 text-sm text-zinc-500">
            {friends.length} {friends.length === 1 ? 'amigo' : 'amigos'}
          </p>
        </div>

        <button
          type="button"
          onClick={onAdd}
          aria-label="Agregar amigo"
          title="Agregar amigo"
          className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full border border-white/15 bg-transparent text-zinc-300 transition-all duration-300 hover:border-[#0066ff] hover:bg-[#0066ff]/15 hover:text-white hover:shadow-[0_0_20px_rgba(0,102,255,0.3)] focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:scale-95"
        >
          <Plus className="h-5 w-5" />
        </button>
      </div>

      {friends.length === 0 ? (
        <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-10 text-center">
          <Users className="mx-auto mb-4 h-9 w-9 text-zinc-600" />
          <p className="mb-5 text-sm text-zinc-400">
            Todavía no tienes amigos agregados.
          </p>
          <button
            type="button"
            onClick={onAdd}
            className="inline-flex items-center gap-2 rounded-lg bg-white px-4 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:bg-[#0066ff] hover:text-white hover:shadow-[0_0_25px_rgba(0,102,255,0.65)] focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:scale-95"
          >
            <Plus className="h-4 w-4" />
            Buscar amigos
          </button>
        </div>
      ) : (
        <ul className="space-y-3">
          {friends.map((friend) => (
            <li
              key={friend.id}
              className="flex items-center gap-4 rounded-2xl border border-white/10 bg-white/[0.03] p-4 transition-all duration-300 hover:border-white/20 hover:bg-white/[0.06]"
            >
              <button
                type="button"
                onClick={() => navigate(`/profile/friends/${friend.profile.id}`)}
                className="flex min-w-0 flex-1 items-center gap-4 text-left focus:outline-none"
              >
                <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-full bg-gradient-to-b from-white/15 to-white/[0.03] ring-1 ring-white/10">
                  <User className="h-5 w-5 text-white" />
                </span>
                <span className="min-w-0">
                  <span className="block truncate text-[15px] font-medium text-white">
                    {friend.profile.username ?? 'Usuario'}
                  </span>
                  <span className="mt-0.5 block truncate text-xs text-zinc-500">
                    Ver perfil
                  </span>
                </span>
              </button>

              <button
                type="button"
                onClick={() => onRemove(friend.id)}
                disabled={removingId === friend.id}
                aria-label={`Eliminar a ${friend.profile.username ?? 'este amigo'}`}
                title="Eliminar amigo"
                className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg border border-white/10 bg-transparent text-zinc-400 transition-all duration-300 hover:border-red-500 hover:bg-red-500/15 hover:text-white focus:outline-none focus:ring-4 focus:ring-red-500/30 active:scale-95 disabled:opacity-50"
              >
                {removingId === friend.id ? (
                  <Loader2 className="h-4 w-4 animate-spin" />
                ) : (
                  <UserMinus className="h-4 w-4" />
                )}
              </button>
            </li>
          ))}
        </ul>
      )}
    </section>
  )
}

export default FriendsList

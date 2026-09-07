import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import {
  AlertCircle,
  ArrowLeft,
  Gamepad2,
  Loader2,
  User,
  UserMinus,
} from 'lucide-react'
import { supabase } from '../config/supabase'
import { loadFriendships, removeFriendship } from '../data/friends'
import { getGameById } from '../data/games'
import GameArtwork from './GameArtwork'

function FriendProfile() {
  const { friendId } = useParams()
  const navigate = useNavigate()
  const [profile, setProfile] = useState(null)
  const [relation, setRelation] = useState(null)
  const [isLoading, setIsLoading] = useState(true)
  const [isRemoving, setIsRemoving] = useState(false)
  const [error, setError] = useState('')
  const [games, setGames] = useState([])
  const [isLoadingGames, setIsLoadingGames] = useState(true)

  useEffect(() => {
    let active = true

    const load = async () => {
      const { data: session } = await supabase.auth.getSession()

      if (!active) {
        return
      }

      if (!session.session) {
        navigate('/login', { replace: true })
        return
      }

      const { data: found, error: profileError } = await supabase
        .from('profiles')
        .select('id, username, created_at')
        .eq('id', friendId)
        .maybeSingle()

      if (!active) {
        return
      }

      if (profileError) {
        setError(`No se pudo cargar el perfil: ${profileError.message}`)
      } else {
        setProfile(found)
      }

      const result = await loadFriendships(session.session.user.id)

      if (!active) {
        return
      }

      if (!result.error) {
        setRelation(
          result.friends.find((item) => item.profile.id === friendId) ?? null,
        )
      }

      setIsLoading(false)

      // La policy de Supabase decide si esto devuelve algo: si no sois amigos
      // aceptados, llega vacio en lugar de fallar.
      const { data: friendGames } = await supabase
        .from('user_games')
        .select('game_id, game_name')
        .eq('user_id', friendId)
        .order('added_date', { ascending: true })

      if (!active) {
        return
      }

      setGames(
        (friendGames ?? []).map((row) => {
          const fromCatalog = getGameById(row.game_id)
          return { ...fromCatalog, id: row.game_id, name: row.game_name }
        }),
      )
      setIsLoadingGames(false)
    }

    load()

    return () => {
      active = false
    }
  }, [friendId, navigate])

  const handleRemove = async () => {
    if (!relation) {
      return
    }

    setIsRemoving(true)
    const { error: removeError } = await removeFriendship(relation.id)
    setIsRemoving(false)

    if (removeError) {
      setError(`No se pudo eliminar: ${removeError.message}`)
      return
    }

    navigate('/profile/friends', { replace: true })
  }

  return (
    <div className="relative min-h-screen scheme-dark overflow-hidden bg-black">
      <div className="pointer-events-none fixed inset-0" aria-hidden="true">
        <div className="absolute inset-0 bg-[linear-gradient(to_right,rgba(255,255,255,0.035)_1px,transparent_1px),linear-gradient(to_bottom,rgba(255,255,255,0.035)_1px,transparent_1px)] bg-[size:64px_64px] [mask-image:radial-gradient(ellipse_at_center,black_10%,transparent_70%)]" />
        <div className="absolute -top-40 right-[12%] h-[30rem] w-[30rem] animate-pulse rounded-full bg-purple-600/12 blur-[130px] [animation-duration:11s]" />
      </div>

      <header className="relative z-20 border-b-2 border-blue-600/70 bg-[#0a0a0a]/90 backdrop-blur-xl">
        <div className="mx-auto flex max-w-3xl items-center gap-3 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate('/profile/friends')}
            aria-label="Volver a amigos"
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>
          <span className="text-lg font-semibold tracking-tight text-white">
            Perfil de amigo
          </span>
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-3xl px-4 py-10 sm:px-6 sm:py-14">
        {error && (
          <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
            <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{error}</p>
          </div>
        )}

        {isLoading ? (
          <div className="animate-pulse rounded-3xl border border-white/10 bg-[#111114]/80 p-8">
            <div className="mb-4 h-20 w-20 rounded-full bg-white/5" />
            <div className="h-8 w-48 rounded bg-white/5" />
          </div>
        ) : !profile ? (
          <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
            <p className="text-zinc-400">No encontramos ese perfil.</p>
          </div>
        ) : (
          <>
            <section className="mb-6 flex flex-col items-center gap-5 rounded-3xl border border-white/10 bg-[#111114]/80 p-8 text-center backdrop-blur-xl sm:flex-row sm:text-left">
              <div className="flex h-20 w-20 shrink-0 items-center justify-center rounded-full bg-gradient-to-b from-white/15 to-white/[0.03] ring-1 ring-white/10">
                <User className="h-9 w-9 text-white" />
              </div>
              <div className="min-w-0">
                <h1 className="truncate text-2xl font-semibold tracking-tight text-white">
                  {profile.username ?? 'Usuario'}
                </h1>
                <p className="mt-1.5 text-sm text-zinc-500">
                  {relation ? 'Sois amigos' : 'Todavía no sois amigos'}
                </p>
              </div>
            </section>

            <section className="mb-6 rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
              <h2 className="mb-1.5 flex items-center gap-2.5 text-lg font-semibold tracking-tight text-white">
                <Gamepad2 className="h-5 w-5 text-zinc-400" />
                Sus juegos
              </h2>
              <p className="mb-6 text-sm text-zinc-500">
                {isLoadingGames
                  ? 'Cargando…'
                  : `${games.length} ${games.length === 1 ? 'juego' : 'juegos'} en su biblioteca`}
              </p>

              {isLoadingGames ? (
                <div className="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-3">
                  {[0, 1, 2].map((slot) => (
                    <div
                      key={slot}
                      className="animate-pulse rounded-2xl border border-white/10 bg-[#1a1a1a] p-4"
                    >
                      <div className="mb-4 h-28 rounded-xl bg-white/5" />
                      <div className="h-4 w-2/3 rounded bg-white/5" />
                    </div>
                  ))}
                </div>
              ) : games.length === 0 ? (
                <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-10 text-center">
                  <Gamepad2 className="mx-auto mb-4 h-9 w-9 text-zinc-600" />
                  <p className="text-sm text-zinc-400">
                    {relation
                      ? 'Todavía no ha añadido ningún juego.'
                      : 'Solo puedes ver los juegos de tus amigos.'}
                  </p>
                </div>
              ) : (
                <div className="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-3">
                  {games.map((game) => (
                    <article
                      key={game.id}
                      className="group rounded-2xl border border-white/10 bg-[#1a1a1a] p-4 transition-all duration-300 hover:-translate-y-1 hover:border-blue-500/40 hover:shadow-[0_0_35px_rgba(0,102,255,0.15)]"
                    >
                      <div className="mb-4 h-28 overflow-hidden rounded-xl ring-1 ring-white/10">
                        <GameArtwork
                          game={game}
                          fill
                          className="transition-transform duration-500 group-hover:scale-105"
                        />
                      </div>
                      <h3
                        className="truncate text-sm font-semibold text-white"
                        title={game.name}
                      >
                        {game.name}
                      </h3>
                    </article>
                  ))}
                </div>
              )}
            </section>

            {relation && (
              <section className="rounded-3xl border border-white/10 bg-[#111114]/80 p-6 backdrop-blur-xl sm:p-8">
                <h2 className="mb-1.5 text-lg font-semibold tracking-tight text-white">
                  Amistad
                </h2>
                <p className="mb-6 text-sm text-zinc-500">
                  Si la eliminas, tendréis que volver a enviaros una solicitud.
                </p>

                <button
                  type="button"
                  onClick={handleRemove}
                  disabled={isRemoving}
                  className="flex items-center justify-center gap-2 rounded-xl border border-white/15 bg-transparent px-5 py-3 text-sm font-semibold text-zinc-300 transition-all duration-300 hover:border-red-500 hover:bg-red-500/10 hover:text-white focus:outline-none focus:ring-4 focus:ring-red-500/30 active:scale-95 disabled:cursor-not-allowed disabled:opacity-60"
                >
                  {isRemoving ? (
                    <Loader2 className="h-4 w-4 animate-spin" />
                  ) : (
                    <UserMinus className="h-4 w-4" />
                  )}
                  Eliminar amigo
                </button>
              </section>
            )}
          </>
        )}
      </main>
    </div>
  )
}

export default FriendProfile

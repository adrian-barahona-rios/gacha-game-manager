import { useCallback, useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, Check, Loader2 } from 'lucide-react'
import { supabase } from '../config/supabase'
import { getGameById } from '../data/games'
import { getElementStyle } from '../data/characterStyles'

const TIERS = [
  { id: 'S', label: 'S', style: 'border-amber-500/40 bg-amber-500/10 text-amber-300' },
  { id: 'A', label: 'A', style: 'border-lime-500/40 bg-lime-500/10 text-lime-300' },
  { id: 'B', label: 'B', style: 'border-sky-500/40 bg-sky-500/10 text-sky-300' },
  { id: 'C', label: 'C', style: 'border-zinc-500/40 bg-zinc-500/10 text-zinc-300' },
]

function TierListPersonal() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const game = getGameById(gameId)
  const [userId, setUserId] = useState(null)
  const [characters, setCharacters] = useState([])
  const [assignments, setAssignments] = useState({})
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')
  const [savingId, setSavingId] = useState(null)
  const [justSaved, setJustSaved] = useState(false)
  const [dragOverTier, setDragOverTier] = useState(null)
  const [picked, setPicked] = useState(null)

  useEffect(() => {
    let active = true

    supabase.auth.getSession().then(({ data }) => {
      if (!active) {
        return
      }
      if (!data.session) {
        navigate('/login', { replace: true })
        return
      }
      setUserId(data.session.user.id)
    })

    return () => {
      active = false
    }
  }, [navigate])

  const applyData = useCallback(([charactersResult, tiersResult]) => {
    if (charactersResult.error) {
      setError(`No se pudieron cargar los personajes: ${charactersResult.error.message}`)
    } else {
      setCharacters(charactersResult.data)
    }

    if (!tiersResult.error) {
      const next = {}
      tiersResult.data.forEach((row) => {
        next[row.character_id] = row.tier
      })
      setAssignments(next)
    }

    setIsLoading(false)
  }, [])

  useEffect(() => {
    if (!userId) {
      return
    }

    let active = true

    Promise.all([
      supabase
        .from('characters')
        .select('id, name, element, rarity')
        .eq('game_id', gameId)
        .order('name', { ascending: true }),
      supabase
        .from('tier_lists_personal')
        .select('character_id, tier')
        .eq('user_id', userId)
        .eq('game_id', gameId),
    ]).then((results) => {
      if (active) {
        applyData(results)
      }
    })

    return () => {
      active = false
    }
  }, [userId, gameId, applyData])

  const assign = async (characterId, tier) => {
    if (!userId || assignments[characterId] === tier) {
      return
    }

    const previous = assignments[characterId]
    setAssignments((current) => ({ ...current, [characterId]: tier }))
    setSavingId(characterId)

    const { error: saveError } = tier
      ? await supabase.from('tier_lists_personal').upsert(
          {
            user_id: userId,
            game_id: gameId,
            character_id: characterId,
            tier,
            updated_at: new Date().toISOString(),
          },
          { onConflict: 'user_id,game_id,character_id' },
        )
      : await supabase
          .from('tier_lists_personal')
          .delete()
          .eq('user_id', userId)
          .eq('game_id', gameId)
          .eq('character_id', characterId)

    setSavingId(null)

    if (saveError) {
      // Deshacer para que la pantalla no mienta sobre lo que hay guardado.
      setAssignments((current) => ({ ...current, [characterId]: previous }))
      setError(`No se pudo guardar: ${saveError.message}`)
      return
    }

    setError('')
    setJustSaved(true)
    setTimeout(() => setJustSaved(false), 1500)
  }

  const remove = async (characterId) => {
    if (!userId) {
      return
    }

    const previous = assignments[characterId]
    setAssignments((current) => {
      const next = { ...current }
      delete next[characterId]
      return next
    })
    setSavingId(characterId)

    const { error: deleteError } = await supabase
      .from('tier_lists_personal')
      .delete()
      .eq('user_id', userId)
      .eq('game_id', gameId)
      .eq('character_id', characterId)

    setSavingId(null)

    if (deleteError) {
      setAssignments((current) => ({ ...current, [characterId]: previous }))
      setError(`No se pudo quitar: ${deleteError.message}`)
    }
  }

  const handleDrop = (tier) => (event) => {
    event.preventDefault()
    setDragOverTier(null)
    const characterId = event.dataTransfer.getData('text/plain')
    if (characterId) {
      assign(characterId, tier)
    }
  }

  // Pulsar y luego elegir tier: en movil no hay arrastre nativo.
  const handleChipClick = (characterId) => {
    setPicked((current) => (current === characterId ? null : characterId))
  }

  const handleTierClick = (tier) => {
    if (picked) {
      assign(picked, tier)
      setPicked(null)
    }
  }

  const unassigned = characters.filter((character) => !assignments[character.id])

  const chip = (character, inTier) => (
    <button
      key={character.id}
      type="button"
      draggable
      onDragStart={(event) => {
        event.dataTransfer.setData('text/plain', character.id)
        event.dataTransfer.effectAllowed = 'move'
      }}
      onClick={() =>
        inTier ? remove(character.id) : handleChipClick(character.id)
      }
      title={inTier ? 'Pulsa para quitarlo' : 'Arrástralo o pulsa y elige un tier'}
      className={`cursor-grab rounded-lg px-3 py-2 text-sm font-medium ring-1 transition-all duration-300 hover:-translate-y-0.5 active:cursor-grabbing focus:outline-none focus:ring-4 focus:ring-white/20 ${getElementStyle(character.element).badge} ${
        picked === character.id ? 'ring-4 ring-blue-500/50' : ''
      }`}
    >
      {savingId === character.id ? (
        <Loader2 className="inline h-3.5 w-3.5 animate-spin" />
      ) : (
        character.name
      )}
    </button>
  )

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <div className="pointer-events-none fixed inset-0" aria-hidden="true">
        <div className="absolute inset-0 bg-[linear-gradient(to_right,rgba(255,255,255,0.035)_1px,transparent_1px),linear-gradient(to_bottom,rgba(255,255,255,0.035)_1px,transparent_1px)] bg-[size:64px_64px] [mask-image:radial-gradient(ellipse_at_center,black_10%,transparent_70%)]" />
        <div className="absolute -bottom-48 right-[8%] h-[28rem] w-[28rem] animate-pulse rounded-full bg-purple-600/12 blur-[130px] [animation-duration:11s]" />
      </div>

      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-7xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}`)}
            aria-label="Volver al juego"
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">
              Mi tier list
            </h1>
            <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>
              {game?.name ?? gameId}
            </p>
          </div>

          {justSaved && (
            <span className="hidden items-center gap-2 text-sm text-emerald-400 sm:flex">
              <Check className="h-4 w-4" />
              Guardado
            </span>
          )}

          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}/tierlist/official`)}
            className="shrink-0 rounded-lg border border-white/15 px-3 py-2.5 text-sm font-medium text-zinc-300 transition-all duration-300 hover:border-[#0066ff] hover:bg-[#0066ff]/10 hover:text-white focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:scale-95"
          >
            Oficial
          </button>
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-7xl px-4 py-10 sm:px-6 sm:py-14">
        {error && (
          <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
            <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{error}</p>
          </div>
        )}

        <p className="mb-6 text-sm text-zinc-500">
          Arrastra los personajes a un tier, o pulsa uno y luego el tier. Pulsa un
          personaje ya colocado para devolverlo abajo. Se guarda solo.
        </p>

        {isLoading ? (
          <div className="space-y-4">
            {[0, 1, 2, 3].map((slot) => (
              <div
                key={slot}
                className="h-28 animate-pulse rounded-2xl border border-white/10 bg-[#1a1a1a]"
              />
            ))}
          </div>
        ) : (
          <>
            <div className="mb-8 space-y-4">
              {TIERS.map((tier) => {
                const members = characters.filter(
                  (character) => assignments[character.id] === tier.id,
                )

                return (
                  <section
                    key={tier.id}
                    onDragOver={(event) => {
                      event.preventDefault()
                      setDragOverTier(tier.id)
                    }}
                    onDragLeave={() => setDragOverTier(null)}
                    onDrop={handleDrop(tier.id)}
                    onClick={() => handleTierClick(tier.id)}
                    className={`flex flex-col gap-4 rounded-2xl border p-4 transition-all duration-200 sm:flex-row sm:items-start sm:p-5 ${tier.style} ${
                      dragOverTier === tier.id
                        ? 'ring-4 ring-blue-500/40'
                        : picked
                          ? 'cursor-pointer ring-2 ring-white/20'
                          : ''
                    }`}
                  >
                    <div className="flex shrink-0 items-center gap-3 sm:w-20 sm:flex-col sm:items-start">
                      <span className="text-3xl font-bold tracking-tight">
                        {tier.label}
                      </span>
                      <span className="text-xs uppercase tracking-wide opacity-70">
                        {members.length}
                      </span>
                    </div>

                    <div className="flex min-h-[3rem] flex-1 flex-wrap gap-2">
                      {members.length === 0 ? (
                        <span className="self-center text-sm opacity-50">
                          Suelta personajes aquí
                        </span>
                      ) : (
                        members.map((character) => chip(character, true))
                      )}
                    </div>
                  </section>
                )
              })}
            </div>

            <section className="rounded-2xl border border-white/10 bg-[#111114]/80 p-5 backdrop-blur-xl">
              <h2 className="mb-1.5 text-lg font-semibold tracking-tight text-white">
                Sin clasificar
              </h2>
              <p className="mb-5 text-sm text-zinc-500">
                {unassigned.length}{' '}
                {unassigned.length === 1 ? 'personaje' : 'personajes'}
              </p>

              <div className="flex flex-wrap gap-2">
                {unassigned.map((character) => chip(character, false))}
              </div>
            </section>
          </>
        )}
      </main>
    </div>
  )
}

export default TierListPersonal

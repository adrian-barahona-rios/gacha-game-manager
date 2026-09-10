import { useCallback, useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, Check, Loader2 } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { getElementChip, getElementStyle } from '../data/characterStyles'
import ProfileButton from './ProfileButton'

const TIERS = [
  { id: 'S', label: 'S', style: 'border-amber-500/50 bg-amber-950 text-amber-300' },
  { id: 'A', label: 'A', style: 'border-lime-500/50 bg-lime-950 text-lime-300' },
  { id: 'B', label: 'B', style: 'border-sky-500/50 bg-sky-950 text-sky-300' },
  { id: 'C', label: 'C', style: 'border-zinc-500/50 bg-zinc-900 text-zinc-300' },
]

function TierListPersonal() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const game = getGameById(gameId)
  const [userId, setUserId] = useState(null)
  const [characters, setCharacters] = useState([])
  const [assignments, setAssignments] = useState({})
  const [isLoading, setIsLoading] = useState(true)
  const { t } = useI18n()
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
      setError(t('characters.error.load', { message: charactersResult.error.message }))
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
  }, [t])

  useEffect(() => {
    if (!userId) {
      return
    }

    let active = true

    Promise.all([
      supabase
        .from('characters')
        .select('id, name, element, rarity, image_url')
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
      setError(t('tierlist.error.save', { message: saveError.message }))
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
      setError(t('tierlist.error.remove', { message: deleteError.message }))
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
      title={inTier ? t('tierlist.tapToRemove') : t('tierlist.tapToPlace')}
      className={`w-[5.5rem] cursor-grab overflow-hidden rounded-xl border border-white/10 bg-[#141418] ring-1 transition-all duration-300 hover:-translate-y-1 hover:border-white/30 active:cursor-grabbing focus:outline-none focus:ring-4 focus:ring-white/20 sm:w-24 ${getElementChip(character.element)} ${
        picked === character.id ? 'ring-4 ring-blue-500/50' : ''
      }`}
    >
      <span
        className={`flex h-[4.5rem] w-full items-center justify-center bg-gradient-to-br sm:h-20 ${getElementStyle(character.element).tile}`}
      >
        {savingId === character.id ? (
          <Loader2 className="h-5 w-5 animate-spin text-white/80" />
        ) : character.image_url ? (
          <img
            src={character.image_url}
            alt={character.name}
            loading="lazy"
            draggable={false}
            className="h-full w-auto max-w-full object-contain"
          />
        ) : (
          <span className="text-2xl font-bold tracking-tight text-white/85">
            {character.name.charAt(0)}
          </span>
        )}
      </span>

      <span className="block px-1.5 py-1.5 text-center text-[11px] font-semibold leading-tight">
        {character.name}
      </span>
    </button>
  )

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <div className="pointer-events-none fixed inset-0" aria-hidden="true">
        <div className="absolute -bottom-48 right-[8%] h-[28rem] w-[28rem] animate-pulse rounded-full bg-purple-600/12 blur-[130px] [animation-duration:11s]" />
      </div>

      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-7xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}`)}
            aria-label={t('characters.backToGame')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">
              {t('tierlist.personalTitle')}
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
          <ProfileButton />
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
          {t('tierlist.instructions')}
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
                          {t('tierlist.dropHere')}
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
                {t('tierlist.unranked')}
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

import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { ArrowLeft, Loader2 } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import MetaGuide from './MetaGuide'
import MyGuides from './MyGuides'
import YouTubeGuidesSection from './YouTubeGuidesSection'
import ProfileButton from './ProfileButton'

function CharacterGuides() {
  const { t, activeLanguage } = useI18n()
  const navigate = useNavigate()
  const { gameId, characterId } = useParams()
  const game = getGameById(gameId)
  const [loaded, setLoaded] = useState(null)

  const isLoading = loaded?.characterId !== characterId
  const character = isLoading ? null : loaded.character

  useEffect(() => {
    let active = true

    supabase
      .from('characters')
      .select('id, name')
      .eq('id', characterId)
      .maybeSingle()
      .then(({ data }) => {
        if (active) {
          setLoaded({ characterId, character: data })
        }
      })

    return () => {
      active = false
    }
  }, [characterId])

  // La busqueda de YouTube usa el nombre del personaje, el del juego y la
  // palabra "guia" en el idioma activo.
  const query = character
    ? `${character.name} ${game?.name ?? gameId} ${t('guides.video.queryWord')}`
    : ''

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <div className="pointer-events-none fixed inset-0" aria-hidden="true">
        <div className="absolute inset-0 bg-[linear-gradient(to_right,rgba(255,255,255,0.035)_1px,transparent_1px),linear-gradient(to_bottom,rgba(255,255,255,0.035)_1px,transparent_1px)] bg-[size:64px_64px] [mask-image:radial-gradient(ellipse_at_center,black_10%,transparent_70%)]" />
        <div className="absolute -top-40 left-[10%] h-[30rem] w-[30rem] animate-pulse rounded-full bg-amber-600/10 blur-[130px] [animation-duration:12s]" />
      </div>

      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-4xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}/characters/${characterId}`)}
            aria-label={t('common.back')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">
              {t('guides.title')}
            </h1>
            <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>
              {[character?.name, game?.name].filter(Boolean).join(' · ') || characterId}
            </p>
          </div>
          <ProfileButton />
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-4xl space-y-6 px-4 py-10 sm:px-6 sm:py-14">
        {isLoading ? (
          <div className="flex items-center justify-center gap-3 py-10 text-sm text-zinc-500">
            <Loader2 className="h-4 w-4 animate-spin" />
            {t('common.loading')}
          </div>
        ) : (
          <>
            <MetaGuide characterId={characterId} />
            <MyGuides gameId={gameId} characterId={characterId} embedded />
            <YouTubeGuidesSection query={query} key={activeLanguage} />
          </>
        )}
      </main>
    </div>
  )
}

export default CharacterGuides

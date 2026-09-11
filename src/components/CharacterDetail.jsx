import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import {
  AlertCircle,
  ArrowLeft,
  BookOpen,
  ExternalLink,
  Heart,
  Loader2,
} from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import {
  formatRarity,
  getElementStyle,
  getRarityStyle,
} from '../data/characterStyles'
import AscensionMaterials from './AscensionMaterials'
import ProfileButton from './ProfileButton'

const TABS = [
  { id: 'detalles', labelKey: 'character.tab.details' },
  { id: 'biografia', labelKey: 'character.tab.biography' },
  { id: 'stats', labelKey: 'character.tab.stats' },
  { id: 'ascension', labelKey: 'character.tab.ascension' },
]

// Las biografias vienen de las wikis con saltos de linea: los volvemos parrafos.
function splitParagraphs(text) {
  return text
    .split(/\n+/)
    .map((paragraph) => paragraph.trim())
    .filter(Boolean)
}

// Cada juego llama distinto a lo mismo: Via en Star Rail, Especialidad en Zenless.
const PATH_LABELS = {
  'honkai-star-rail': ['character.path.hsr', 'character.signature.hsr'],
  'zenless-zone-zero': ['character.path.zzz', 'character.signature.zzz'],
}

function CharacterDetail() {
  const { gameId, characterId } = useParams()
  const { t, activeLanguage } = useI18n()
  const [activeTab, setActiveTab] = useState('detalles')
  const navigate = useNavigate()
  const game = getGameById(gameId)
  const [character, setCharacter] = useState(null)
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')
  const [userId, setUserId] = useState(null)
  const [isFavorite, setIsFavorite] = useState(false)
  const [isTogglingFavorite, setIsTogglingFavorite] = useState(false)

  useEffect(() => {
    let active = true

    supabase
      .from('characters')
      .select('*')
      .eq('id', characterId)
      .maybeSingle()
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(t('character.error.load', { message: loadError.message }))
        } else {
          setCharacter(data)
        }
        setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [characterId, t])

  useEffect(() => {
    let active = true

    supabase.auth.getSession().then(({ data }) => {
      if (!active || !data.session) {
        return
      }

      const currentId = data.session.user.id
      setUserId(currentId)

      supabase
        .from('favorite_characters')
        .select('character_id')
        .eq('user_id', currentId)
        .eq('character_id', characterId)
        .maybeSingle()
        .then(({ data: favorite }) => {
          if (active) {
            setIsFavorite(Boolean(favorite))
          }
        })
    })

    return () => {
      active = false
    }
  }, [characterId])

  const toggleFavorite = async () => {
    if (!userId) {
      navigate('/login')
      return
    }

    setIsTogglingFavorite(true)

    const { error: favoriteError } = isFavorite
      ? await supabase
          .from('favorite_characters')
          .delete()
          .eq('user_id', userId)
          .eq('character_id', characterId)
      : await supabase
          .from('favorite_characters')
          .insert({ user_id: userId, character_id: characterId })

    setIsTogglingFavorite(false)

    if (favoriteError) {
      setError(t('character.error.favorite', { message: favoriteError.message }))
      return
    }

    setIsFavorite((current) => !current)
    setError('')
  }

  const elementStyle = getElementStyle(character?.element)
  const hasAscension =
    Array.isArray(character?.ascension) && character.ascension.length > 0
  const [pathKey, signatureKey] = PATH_LABELS[gameId] ?? [
    'character.path.default',
    'character.signature.default',
  ]
  const pathLabel = t(pathKey)
  const signatureLabel = t(signatureKey)

  // Cada idioma tiene su propia columna; si falta, se usa la inglesa.
  const biography =
    (activeLanguage === 'es' ? character?.biography_es : character?.biography_en) ??
    character?.biography_en ??
    character?.biography
  const biographySource =
    (activeLanguage === 'es' ? character?.biography_source_es : character?.biography_source_en) ??
    character?.biography_source_en
  const isTranslated = activeLanguage === 'es' && character?.biography_es_translated === true

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <div className="pointer-events-none fixed inset-0" aria-hidden="true">
        <div className="absolute -top-40 right-[10%] h-[30rem] w-[30rem] animate-pulse rounded-full bg-purple-600/12 blur-[130px] [animation-duration:11s]" />
      </div>

      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-5xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}/characters`)}
            className="flex shrink-0 items-center gap-2 rounded-lg border border-white/10 bg-white/5 px-3 py-2.5 text-sm font-medium text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
            {t('common.back')}
          </button>
          <span className={`truncate text-sm ${game?.accent ?? 'text-zinc-500'}`}>
            {game?.name ?? gameId}
          </span>
          <ProfileButton />
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-5xl px-4 py-10 sm:px-6 sm:py-14">
        {error && (
          <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
            <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{error}</p>
          </div>
        )}

        {isLoading ? (
          <div className="grid animate-pulse gap-8 sm:grid-cols-[minmax(0,20rem)_1fr]">
            <div className="h-96 rounded-3xl bg-white/5" />
            <div className="space-y-4">
              <div className="h-9 w-2/3 rounded bg-white/5" />
              <div className="h-5 w-1/3 rounded bg-white/5" />
              <div className="h-32 rounded-2xl bg-white/5" />
            </div>
          </div>
        ) : !character ? (
          <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
            <p className="mb-6 text-zinc-400">
              {t('character.notFound')}
            </p>
            <button
              type="button"
              onClick={() => navigate(`/game/${gameId}/characters`)}
              className="inline-flex items-center gap-2 rounded-lg bg-white px-4 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:bg-[#0066ff] hover:text-white active:scale-95"
            >
              <ArrowLeft className="h-4 w-4" />
              {t('character.viewAll')}
            </button>
          </div>
        ) : (
          <div className="grid gap-8 sm:grid-cols-[minmax(0,20rem)_1fr]">
            <div className="h-96 overflow-hidden rounded-3xl border border-white/10 ring-1 ring-white/5 sm:h-[28rem]">
              {character.image_url ? (
                <span
                  className={`flex h-full w-full items-center justify-center bg-gradient-to-br ${elementStyle.tile}`}
                >
                  <img
                    src={character.image_url}
                    alt={character.name}
                    className="h-full w-auto max-w-full object-contain"
                  />
                </span>
              ) : (
                <span
                  className={`flex h-full w-full items-center justify-center bg-gradient-to-br ${elementStyle.tile}`}
                >
                  <span className="text-8xl font-bold tracking-tight text-white/85">
                    {character.name.charAt(0)}
                  </span>
                </span>
              )}
            </div>

            <div className="min-w-0">
              <h1 className="mb-4 text-3xl font-semibold tracking-tight text-white sm:text-4xl">
                {character.name}
              </h1>

              <div className="mb-7 flex flex-wrap gap-2">
                {character.rarity && (
                  <span
                    className={`rounded-full px-3 py-1 text-sm font-medium ring-1 ${getRarityStyle(character.rarity)}`}
                  >
                    {formatRarity(character.rarity)}
                  </span>
                )}
                {character.element && (
                  <span
                    className={`rounded-full px-3 py-1 text-sm font-medium ring-1 ${elementStyle.badge}`}
                  >
                    {character.element}
                  </span>
                )}
              </div>

              <div className="mb-6 flex gap-1 rounded-xl border border-white/10 bg-white/[0.03] p-1">
                {TABS.filter((tab) => {
                  if (tab.id === 'stats') return Boolean(character.level_cap)
                  if (tab.id === 'ascension') return hasAscension
                  return true
                }).map((tab) => (
                  <button
                    key={tab.id}
                    type="button"
                    onClick={() => setActiveTab(tab.id)}
                    className={`flex-1 rounded-lg px-3 py-2.5 text-sm font-medium transition-all duration-300 focus:outline-none focus:ring-2 focus:ring-white/30 ${
                      activeTab === tab.id
                        ? 'bg-white text-black'
                        : 'text-zinc-400 hover:bg-white/5 hover:text-white'
                    }`}
                  >
                    {t(tab.labelKey)}
                  </button>
                ))}
              </div>

              {activeTab === 'detalles' && (
                <dl className="mb-8 grid grid-cols-2 gap-4">
                  {[
                    [
                      t('character.rarity'),
                      character.rarity ? formatRarity(character.rarity) : t('character.undefined'),
                    ],
                    [t('character.element'), character.element ?? t('character.undefined')],
                    [t('character.role'), character.role ?? t('character.undefined')],
                    [pathLabel, character.path ?? t('character.undefined')],
                    [signatureLabel, character.signature ?? t('character.undefined')],
                    [t('character.game'), game?.name ?? gameId],
                  ].map(([label, value]) => (
                    <div
                      key={label}
                      className="rounded-xl border border-white/10 bg-white/[0.03] p-4"
                    >
                      <dt className="mb-1.5 text-[11px] uppercase tracking-wide text-zinc-500">
                        {label}
                      </dt>
                      <dd className="text-sm font-medium text-white">{value}</dd>
                    </div>
                  ))}
                </dl>
              )}

              {activeTab === 'biografia' && (
                <div className="mb-8">
                  {biography ? (
                    <article className="space-y-5">
                      {splitParagraphs(biography).map((paragraph, index) => (
                        <p
                          key={index}
                          className={`text-[15px] leading-7 ${
                            index === 0
                              ? 'border-l-2 border-white/20 pl-5 text-zinc-200'
                              : 'text-zinc-400'
                          }`}
                        >
                          {paragraph}
                        </p>
                      ))}

                      {isTranslated && (
                        <p className="text-[13px] italic text-zinc-500">
                          {t('character.translatedNotice')}
                        </p>
                      )}

                      {biographySource && (
                        <a
                          href={biographySource}
                          target="_blank"
                          rel="noreferrer"
                          className="inline-flex items-center gap-2 text-xs text-zinc-500 transition hover:text-white"
                        >
                          <ExternalLink className="h-3.5 w-3.5" />
                          {t('character.officialSource')}
                        </a>
                      )}
                    </article>
                  ) : (
                    <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-10 text-center">
                      <BookOpen className="mx-auto mb-4 h-9 w-9 text-zinc-600" />
                      <p className="text-sm text-zinc-400">
                        {t('character.noBiography')}
                      </p>
                    </div>
                  )}

                  {character.description && (
                    <p className="mt-6 text-sm text-zinc-500">
                      {character.description}
                    </p>
                  )}
                </div>
              )}

              {activeTab === 'stats' && (
                <dl className="mb-8 grid grid-cols-2 gap-4">
                  {[
                    [t('character.levelCap'), character.level_cap ?? t('character.undefined')],
                    [
                      t('character.rarity'),
                      character.rarity ? formatRarity(character.rarity) : t('character.undefined'),
                    ],
                  ].map(([label, value]) => (
                    <div
                      key={label}
                      className="rounded-xl border border-white/10 bg-white/[0.03] p-4"
                    >
                      <dt className="mb-1.5 text-[11px] uppercase tracking-wide text-zinc-500">
                        {label}
                      </dt>
                      <dd className="text-sm font-medium text-white">{value}</dd>
                    </div>
                  ))}
                </dl>
              )}

              {activeTab === 'ascension' && hasAscension && (
                <div className="mb-8">
                  <AscensionMaterials ascension={character.ascension} gameId={gameId} />
                </div>
              )}

              <div className="flex flex-wrap gap-3">
              <button
                type="button"
                onClick={toggleFavorite}
                disabled={isTogglingFavorite}
                className={`flex items-center justify-center gap-2 rounded-xl px-5 py-3 text-sm font-semibold transition-all duration-300 focus:outline-none focus:ring-4 active:scale-95 disabled:cursor-not-allowed disabled:opacity-60 ${
                  isFavorite
                    ? 'bg-rose-600 text-white shadow-[0_0_25px_rgba(225,29,72,0.45)] hover:bg-rose-500 focus:ring-rose-500/30'
                    : 'border border-white/15 bg-transparent text-zinc-300 hover:border-rose-500 hover:bg-rose-500/10 hover:text-white focus:ring-rose-500/30'
                }`}
              >
                {isTogglingFavorite ? (
                  <Loader2 className="h-4 w-4 animate-spin" />
                ) : (
                  <Heart
                    className={`h-4 w-4 ${isFavorite ? 'fill-current' : ''}`}
                  />
                )}
                {isFavorite ? t('character.inFavorites') : t('character.addFavorite')}
              </button>

              <button
                type="button"
                onClick={() => navigate(`/game/${gameId}/characters/${characterId}/guides`)}
                className="flex items-center justify-center gap-2 rounded-xl border border-white/15 bg-transparent px-5 py-3 text-sm font-semibold text-zinc-300 transition-all duration-300 hover:border-amber-400 hover:bg-amber-400/10 hover:text-white focus:outline-none focus:ring-4 focus:ring-amber-500/30 active:scale-95"
              >
                <BookOpen className="h-4 w-4" />
                {t('guides.title')}
              </button>
              </div>
            </div>
          </div>
        )}
      </main>
    </div>
  )
}

export default CharacterDetail

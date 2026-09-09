import { useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import {
  ArrowLeft,
  BookOpen,
  ChevronDown,
  Globe,
  Home,
  ListOrdered,
  Users,
} from 'lucide-react'
import GameArtwork from './GameArtwork'
import ProfileButton from './ProfileButton'
import { getGameById, getGameCopy } from '../data/games'
import { getGameModes } from '../data/gameModes'
import { useI18n } from '../i18n/useI18n'

const STARS = [
  'left-[6%] top-[12%] [animation-delay:0s]',
  'left-[14%] top-[38%] [animation-delay:1.1s]',
  'left-[23%] top-[68%] [animation-delay:2.3s]',
  'left-[31%] top-[22%] [animation-delay:0.7s]',
  'left-[42%] top-[52%] [animation-delay:3.1s]',
  'left-[51%] top-[9%] [animation-delay:1.7s]',
  'left-[63%] top-[44%] [animation-delay:2.6s]',
  'left-[71%] top-[76%] [animation-delay:0.4s]',
  'left-[79%] top-[26%] [animation-delay:3.4s]',
  'left-[86%] top-[58%] [animation-delay:1.4s]',
  'left-[93%] top-[15%] [animation-delay:2.9s]',
  'left-[37%] top-[85%] [animation-delay:0.9s]',
]

const SHOOTING_STARS = [
  'left-[8%] top-[6%] [animation-delay:0s]',
  'left-[48%] top-[2%] [animation-delay:3.5s]',
  'left-[68%] top-[18%] [animation-delay:6s]',
]

const FLOATERS = [
  'left-[10%] bottom-[8%] [animation-delay:0s] [animation-duration:13s]',
  'left-[24%] bottom-[4%] [animation-delay:2.4s] [animation-duration:16s]',
  'left-[38%] bottom-[12%] [animation-delay:4.8s] [animation-duration:14s]',
  'left-[52%] bottom-[2%] [animation-delay:1.2s] [animation-duration:18s]',
  'left-[66%] bottom-[10%] [animation-delay:6s] [animation-duration:15s]',
  'left-[80%] bottom-[6%] [animation-delay:3.6s] [animation-duration:17s]',
  'left-[92%] bottom-[14%] [animation-delay:7.2s] [animation-duration:12s]',
]


// --- Cupula de Zenless ---------------------------------------------------
// Radio de la cupula dentro del viewBox de 200x200.
const DOME_R = 92

// Paralelos: a cada altura, el radio horizontal sale del propio circulo. El
// factor de ry los aplana para que se lean como anillos vistos casi de canto.
const DOME_LATITUDES = [-78, -62, -44, -24, -2, 20, 42, 62, 78].map((dy) => ({
  dy,
  rx: Math.sqrt(DOME_R * DOME_R - dy * dy),
}))

// Meridianos: mismo tamano, desfasados en el tiempo. Al ir estrechandose y
// abriendose por turnos, la cupula parece girar sobre si misma.
const DOME_MERIDIANS = [0, 1, 2, 3, 4, 5, 6].map((index) => index * -1.857)

const CONES = [
  'left-[16%] bottom-[13%] h-9 w-7',
  'left-[27%] bottom-[9%] h-7 w-6',
  'left-[63%] bottom-[11%] h-8 w-6',
  'left-[74%] bottom-[7%] h-6 w-5',
  'left-[85%] bottom-[14%] h-9 w-7',
]

function StarRailBackground() {
  return (
    <>
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_50%_0%,rgba(99,102,241,0.22),transparent_60%)]" />
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_80%_90%,rgba(139,92,246,0.16),transparent_55%)]" />

      <div className="absolute left-1/2 top-[14%] h-56 w-56 -translate-x-1/2 animate-drift rounded-full bg-[radial-gradient(circle_at_35%_30%,rgba(255,255,255,0.85),rgba(199,210,254,0.30)_48%,rgba(99,102,241,0.05)_72%)] opacity-30 sm:h-72 sm:w-72" />
      <div className="absolute left-1/2 top-[14%] h-56 w-56 -translate-x-1/2 animate-drift rounded-full opacity-20 ring-1 ring-indigo-200/30 blur-[2px] sm:h-72 sm:w-72" />

      {STARS.map((star) => (
        <span
          key={star}
          className={`absolute h-[3px] w-[3px] animate-twinkle rounded-full bg-white ${star}`}
        />
      ))}

      {SHOOTING_STARS.map((shoot) => (
        <span
          key={shoot}
          className={`absolute h-px w-24 rotate-45 animate-shoot bg-gradient-to-r from-transparent via-white to-transparent ${shoot}`}
        />
      ))}
    </>
  )
}

function GenshinBackground() {
  return (
    <>
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_50%_0%,rgba(14,165,233,0.18),transparent_60%)]" />

      <div className="absolute inset-x-0 top-0 h-[45%] animate-aurora bg-[linear-gradient(100deg,transparent,rgba(45,212,191,0.35),rgba(56,189,248,0.25),transparent)] blur-[70px]" />
      <div className="absolute inset-x-0 top-[8%] h-[38%] animate-aurora bg-[linear-gradient(80deg,transparent,rgba(129,140,248,0.30),rgba(34,211,238,0.20),transparent)] blur-[80px] [animation-delay:5s]" />

      <svg
        className="absolute inset-x-0 bottom-0 h-[38%] w-full"
        viewBox="0 0 1200 300"
        preserveAspectRatio="none"
        aria-hidden="true"
      >
        <polygon points="0,300 180,120 340,300" fill="rgba(15,42,54,0.85)" />
        <polygon points="240,300 470,70 700,300" fill="rgba(11,32,42,0.9)" />
        <polygon points="600,300 820,140 1010,300" fill="rgba(15,42,54,0.8)" />
        <polygon points="900,300 1090,90 1200,300" fill="rgba(9,26,35,0.92)" />
      </svg>

      {FLOATERS.map((floater) => (
        <span
          key={floater}
          className={`absolute h-1.5 w-1.5 animate-rise rounded-full bg-cyan-200/80 shadow-[0_0_10px_rgba(103,232,249,0.8)] ${floater}`}
        />
      ))}
    </>
  )
}

function DxdBackground() {
  return (
    <>
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_50%_50%,rgba(190,18,60,0.16),transparent_62%)]" />

      <div className="absolute left-1/2 top-1/2 h-[26rem] w-[26rem] -translate-x-1/2 -translate-y-1/2 animate-rune rounded-full border border-rose-500/40" />
      <div className="absolute left-1/2 top-1/2 h-[19rem] w-[19rem] -translate-x-1/2 -translate-y-1/2 animate-rune rounded-full border border-dashed border-red-400/40 [animation-delay:1.5s] [animation-duration:12s]" />
      <div className="absolute left-1/2 top-1/2 h-[12rem] w-[12rem] -translate-x-1/2 -translate-y-1/2 animate-rune rounded-full border border-rose-300/30 [animation-delay:3s] [animation-duration:15s]" />

      <div className="absolute inset-x-0 bottom-0 h-52 animate-flicker bg-[linear-gradient(to_top,rgba(220,38,38,0.35),rgba(249,115,22,0.14),transparent)] blur-[30px]" />
      <div className="absolute inset-y-0 left-0 w-32 animate-flicker bg-[linear-gradient(to_right,rgba(190,18,60,0.28),transparent)] blur-[40px] [animation-delay:2s]" />
      <div className="absolute inset-y-0 right-0 w-32 animate-flicker bg-[linear-gradient(to_left,rgba(190,18,60,0.28),transparent)] blur-[40px] [animation-delay:3.5s]" />

      <div className="absolute left-[12%] top-[24%] h-64 w-64 animate-smoke rounded-full bg-rose-900/25 blur-[90px]" />
      <div className="absolute right-[10%] bottom-[18%] h-72 w-72 animate-smoke rounded-full bg-red-950/40 blur-[100px] [animation-delay:9s]" />

      {STARS.slice(0, 8).map((symbol) => (
        <span
          key={symbol}
          className={`absolute h-2 w-2 rotate-45 animate-twinkle bg-rose-400/70 shadow-[0_0_12px_rgba(251,113,133,0.9)] ${symbol}`}
        />
      ))}
    </>
  )
}

function ZzzBackground() {
  return (
    <>
      {/* Cielo polvoriento: claro junto al horizonte y apagado hacia arriba. */}
      <div className="absolute inset-0 bg-[linear-gradient(to_bottom,#171719_0%,#2c2823_32%,#4d453a_50%,#6b6152_60%,#3a352e_64%)]" />
      <div className="absolute inset-x-0 top-[44%] h-[22%] bg-[radial-gradient(ellipse_at_50%_100%,rgba(214,197,166,0.38),transparent_70%)] blur-2xl" />

      {/* La cupula se recorta en el horizonte, como si saliera detras. */}
      <div className="absolute inset-x-0 top-0 h-[62%] overflow-hidden">
        <div className="absolute bottom-[-20%] left-1/2 aspect-square w-[min(128vw,62rem)] -translate-x-1/2">
          <svg viewBox="0 0 200 200" className="h-full w-full" aria-hidden="true">
            <defs>
              <radialGradient id="zzzDomeFill" cx="36%" cy="26%" r="82%">
                <stop offset="0%" stopColor="#40464d" />
                <stop offset="55%" stopColor="#23272c" />
                <stop offset="100%" stopColor="#14171a" />
              </radialGradient>
              <clipPath id="zzzDomeClip">
                <circle cx="100" cy="100" r={DOME_R} />
              </clipPath>
            </defs>

            <circle cx="100" cy="100" r={DOME_R} fill="url(#zzzDomeFill)" />

            <g
              clipPath="url(#zzzDomeClip)"
              fill="none"
              stroke="rgb(186 230 253)"
              strokeOpacity="0.28"
              strokeWidth="0.4"
            >
              {DOME_LATITUDES.map((lat) => (
                <ellipse
                  key={lat.dy}
                  cx="100"
                  cy={100 + lat.dy}
                  rx={lat.rx}
                  ry={lat.rx * 0.17}
                />
              ))}

              {DOME_MERIDIANS.map((delay) => (
                <ellipse
                  key={delay}
                  cx="100"
                  cy="100"
                  rx={DOME_R}
                  ry={DOME_R}
                  className="animate-meridian [transform-box:fill-box] [transform-origin:center]"
                  style={{ animationDelay: `${delay}s` }}
                />
              ))}
            </g>

            {/* Reborde iluminado, lo que mas define la silueta de la cupula. */}
            <circle
              cx="100"
              cy="100"
              r={DOME_R}
              fill="none"
              stroke="rgb(224 242 254)"
              strokeOpacity="0.5"
              strokeWidth="0.7"
            />
          </svg>
        </div>
      </div>

      {/* Halo del borde, por fuera del recorte para que se derrame en el cielo. */}
      <div className="absolute left-1/2 top-[6%] h-[52%] w-[min(128vw,62rem)] -translate-x-1/2 rounded-full bg-[radial-gradient(circle_at_50%_60%,transparent_62%,rgba(186,230,253,0.20)_70%,transparent_76%)] blur-md" />

      {/* Bloques lejanos a la derecha, apenas insinuados. */}
      <div className="absolute bottom-[38%] right-[6%] h-[9%] w-16 bg-[#20211f]/80" />
      <div className="absolute bottom-[38%] right-[14%] h-[6%] w-10 bg-[#1a1b1a]/80" />

      {/* Valla de obra a la altura del horizonte. */}
      <div className="absolute inset-x-0 top-[55%] h-[7%] border-y border-white/15 bg-[repeating-linear-gradient(90deg,rgba(226,232,240,0.14)_0_1px,transparent_1px_10px)]" />

      {/* Asfalto. */}
      <div className="absolute inset-x-0 top-[62%] bottom-0 bg-[linear-gradient(to_bottom,#1d1c1a,#0a0a0b)]" />

      {/* Franja de peligro y farola, del atrezo industrial de la referencia. */}
      <div className="absolute bottom-[19%] left-0 h-5 w-[24%] bg-[repeating-linear-gradient(45deg,rgba(250,204,21,0.55)_0_9px,rgba(0,0,0,0.7)_9px_18px)] opacity-45" />
      <div className="absolute bottom-[19%] right-0 h-5 w-[18%] bg-[repeating-linear-gradient(45deg,rgba(250,204,21,0.55)_0_9px,rgba(0,0,0,0.7)_9px_18px)] opacity-35" />

      <div className="absolute bottom-[18%] right-[22%] h-[26%] w-[3px] bg-gradient-to-t from-transparent via-[#2b2c2a] to-[#3a3b38]" />
      <div className="absolute bottom-[42%] right-[21.4%] h-3 w-3 animate-flicker rounded-full bg-red-500/80 shadow-[0_0_14px_rgba(239,68,68,0.9)]" />

      {CONES.map((cone) => (
        <span
          key={cone}
          className={`absolute bg-gradient-to-b from-orange-400/70 to-orange-800/60 [clip-path:polygon(50%_0,100%_100%,0_100%)] ${cone}`}
        />
      ))}

      {/* Ceniza en suspension. */}
      {FLOATERS.map((floater) => (
        <span
          key={floater}
          className={`absolute h-1 w-1 animate-rise rounded-full bg-amber-100/70 shadow-[0_0_8px_rgba(254,243,199,0.7)] ${floater}`}
        />
      ))}
    </>
  )
}

const SPEED_LINES = [
  'top-[46%] w-40 [animation-delay:0s] [animation-duration:3.4s]',
  'top-[54%] w-56 [animation-delay:0.8s] [animation-duration:4.2s]',
  'top-[62%] w-32 [animation-delay:1.6s] [animation-duration:3s]',
  'top-[70%] w-64 [animation-delay:2.3s] [animation-duration:4.8s]',
  'top-[78%] w-44 [animation-delay:3.1s] [animation-duration:3.8s]',
  'top-[86%] w-52 [animation-delay:1.1s] [animation-duration:4.5s]',
]

const RUNNERS = [
  'bottom-[16%] h-16 [animation-delay:0s] [animation-duration:10s]',
  'bottom-[9%] h-20 [animation-delay:2.5s] [animation-duration:8.5s]',
  'bottom-[24%] h-12 [animation-delay:5.5s] [animation-duration:12s]',
]

function GallopingHorse() {
  return (
    <svg viewBox="0 0 110 60" className="h-full w-auto" aria-hidden="true">
      <g fill="currentColor">
        <ellipse cx="52" cy="28" rx="22" ry="9.5" />
        <path d="M68,22 L86,10 L92,17 L74,29 Z" />
        <path d="M84,7 L100,12 L98,21 L82,17 Z" />
        <path d="M32,22 C20,13 12,13 4,17 C14,20 24,26 31,31 Z" />
        <rect
          x="64"
          y="32"
          width="5"
          height="23"
          rx="2.5"
          transform="rotate(32 66.5 33)"
        />
        <rect
          x="57"
          y="32"
          width="5"
          height="20"
          rx="2.5"
          transform="rotate(14 59.5 33)"
        />
        <rect
          x="40"
          y="32"
          width="5"
          height="23"
          rx="2.5"
          transform="rotate(-36 42.5 33)"
        />
        <rect
          x="46"
          y="32"
          width="5"
          height="20"
          rx="2.5"
          transform="rotate(-14 48.5 33)"
        />
      </g>
    </svg>
  )
}

function UmamusumeBackground() {
  return (
    <>
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_50%_10%,rgba(217,164,65,0.18),transparent_60%)]" />
      <div className="absolute inset-x-0 bottom-0 h-[42%] bg-[linear-gradient(to_top,rgba(88,50,22,0.75),rgba(62,36,16,0.35),transparent)]" />

      <div className="absolute inset-x-0 bottom-[6%] h-px bg-gradient-to-r from-transparent via-amber-100/25 to-transparent" />
      <div className="absolute inset-x-0 bottom-[20%] h-px bg-gradient-to-r from-transparent via-amber-100/20 to-transparent" />
      <div className="absolute inset-x-0 bottom-[34%] h-px bg-gradient-to-r from-transparent via-amber-100/12 to-transparent" />

      {SPEED_LINES.map((line) => (
        <span
          key={line}
          className={`absolute left-0 h-[2px] animate-dash rounded-full bg-gradient-to-r from-transparent via-amber-200/70 to-transparent ${line}`}
        />
      ))}

      {RUNNERS.map((runner) => (
        <span
          key={runner}
          className={`absolute left-0 animate-gallop text-amber-950/70 ${runner}`}
        >
          <span className="flex h-full animate-bob">
            <GallopingHorse />
          </span>
        </span>
      ))}

      <div className="absolute bottom-[8%] left-[18%] h-40 w-40 animate-smoke rounded-full bg-amber-700/20 blur-[70px]" />
      <div className="absolute bottom-[12%] right-[22%] h-48 w-48 animate-smoke rounded-full bg-yellow-600/15 blur-[80px] [animation-delay:8s]" />
    </>
  )
}

const BACKGROUNDS = {
  starrail: StarRailBackground,
  genshin: GenshinBackground,
  dxd: DxdBackground,
  zzz: ZzzBackground,
  umamusume: UmamusumeBackground,
}

// Umamusume todavia no tiene personajes cargados en la base de datos.
const GAMES_WITH_CHARACTERS = [
  'genshin-impact',
  'honkai-star-rail',
  'high-school-dxd-opi',
  'zenless-zone-zero',
]

// DxD queda fuera: no hay tier list publicada de ese juego.
const GAMES_WITH_TIERLIST = [
  'genshin-impact',
  'honkai-star-rail',
  'zenless-zone-zero',
]

const MENU_ITEMS = [
  { id: 'inicio', labelKey: 'game.menu.home', icon: Home },
  { id: 'personajes', labelKey: 'game.menu.characters', icon: Users },
  { id: 'tierlist', labelKey: 'game.menu.tierList', icon: ListOrdered },
  { id: 'guias', labelKey: 'game.menu.guides', icon: BookOpen },
]

// Umamusume no se organiza por secciones sino por version del juego.
const UMAMUSUME_MENU = [
  { id: 'inicio', labelKey: 'game.menu.home', icon: Home, to: null },
  { id: 'japan', labelKey: 'game.menu.japanVersion', icon: Globe, to: 'japan' },
  { id: 'global', labelKey: 'game.menu.globalVersion', icon: Globe, to: 'global' },
]

function GamePage() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const { t, activeLanguage } = useI18n()
  const [isMenuOpen, setIsMenuOpen] = useState(false)
  const game = getGameById(gameId)

  if (!game) {
    return (
      <div className="flex min-h-screen scheme-dark flex-col items-center justify-center bg-black px-4 text-center">
        <h1 className="mb-3 text-2xl font-semibold text-white">
          {t('game.notFound')}
        </h1>
        <p className="mb-8 text-sm text-zinc-500">
          {t('game.notFoundBody', { id: gameId })}
        </p>
        <button
          type="button"
          onClick={() => navigate('/dashboard')}
          className="flex items-center gap-2 rounded-lg bg-white px-4 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:bg-[#0066ff] hover:text-white hover:shadow-[0_0_25px_rgba(0,102,255,0.65)] active:scale-95"
        >
          <ArrowLeft className="h-4 w-4" />
          {t('game.backToDashboard')}
        </button>
      </div>
    )
  }

  const Background = BACKGROUNDS[game.theme]
  const copy = getGameCopy(game, activeLanguage)
  // Umamusume tiene su propio sistema, con dos versiones del juego.
  const isUmamusume = game.id === 'umamusume-pretty-derby'
  const hasCharacters = isUmamusume || GAMES_WITH_CHARACTERS.includes(game.id)
  const hasTierList = isUmamusume || GAMES_WITH_TIERLIST.includes(game.id)
  // Las guias del juego dependen de que ese juego tenga modos definidos.
  const hasGuides = getGameModes(game.id).length > 0

  return (
    <div className="relative min-h-screen scheme-dark overflow-hidden bg-black">
      <div className="pointer-events-none fixed inset-0 overflow-hidden" aria-hidden="true">
        {Background && <Background />}
      </div>

      <header className="relative z-20 border-b border-white/10 bg-black/60 backdrop-blur-xl">
        <div className="mx-auto flex max-w-6xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate('/dashboard')}
            aria-label={t('game.backToDashboard')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="h-11 w-11 shrink-0 overflow-hidden rounded-xl ring-1 ring-white/15">
            <GameArtwork game={game} />
          </div>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-2xl">
              {game.name}
            </h1>
            <p className={`truncate text-xs sm:text-sm ${game.accent}`}>
              {game.tagline}
            </p>
          </div>

          <div className="relative shrink-0">
            <button
              type="button"
              onClick={() => setIsMenuOpen((open) => !open)}
              aria-expanded={isMenuOpen}
              aria-haspopup="menu"
              className="flex items-center gap-2 rounded-lg bg-white px-3 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:bg-[#0066ff] hover:text-white hover:shadow-[0_0_25px_rgba(0,102,255,0.65)] focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:scale-95 sm:px-4"
            >
              <span className="hidden sm:inline">Inicio</span>
              <ChevronDown
                className={`h-4 w-4 transition-transform duration-300 ${
                  isMenuOpen ? 'rotate-180' : ''
                }`}
              />
            </button>

            {isMenuOpen && (
              <>
                <button
                  type="button"
                  aria-label={t('game.closeMenu')}
                  onClick={() => setIsMenuOpen(false)}
                  className="fixed inset-0 z-10 cursor-default"
                />
                <div
                  role="menu"
                  className="absolute right-0 z-20 mt-2 w-56 overflow-hidden rounded-xl border border-white/10 bg-[#0e0e12]/95 p-1.5 shadow-2xl shadow-black/80 backdrop-blur-xl"
                >
                  {isUmamusume
                    ? UMAMUSUME_MENU.map((item) => {
                        const Icon = item.icon
                        const isCurrent = item.id === 'inicio'

                        return (
                          <button
                            key={item.id}
                            type="button"
                            role="menuitem"
                            onClick={() => {
                              setIsMenuOpen(false)
                              if (item.to) {
                                navigate(`/game/umamusume/${item.to}/characters`)
                              }
                            }}
                            className={`flex w-full items-center gap-3 rounded-lg px-3 py-2.5 text-left text-sm transition-colors duration-200 ${
                              isCurrent
                                ? 'bg-white/10 font-medium text-white'
                                : 'text-zinc-300 hover:bg-white/5 hover:text-white'
                            }`}
                          >
                            <Icon className="h-4 w-4 shrink-0" />
                            {t(item.labelKey)}
                          </button>
                        )
                      })
                    : MENU_ITEMS.map((item) => {
                        const Icon = item.icon
                        const isCurrent = item.id === 'inicio'
                        const isCharacters = item.id === 'personajes'
                        const isTierList = item.id === 'tierlist'
                        const isGuides = item.id === 'guias'
                        const isEnabled =
                          isCurrent ||
                          (isCharacters && hasCharacters) ||
                          (isTierList && hasTierList) ||
                          (isGuides && hasGuides)

                        return (
                          <button
                            key={item.id}
                            type="button"
                            role="menuitem"
                            disabled={!isEnabled}
                            onClick={() => {
                              setIsMenuOpen(false)
                              if (isCharacters) {
                                navigate(`/game/${gameId}/characters`)
                              } else if (isTierList) {
                                navigate(`/game/${gameId}/tierlist/official`)
                              } else if (isGuides) {
                                navigate(`/game/${gameId}/guides`)
                              }
                            }}
                            className={`flex w-full items-center gap-3 rounded-lg px-3 py-2.5 text-left text-sm transition-colors duration-200 ${
                              isCurrent
                                ? 'bg-white/10 font-medium text-white'
                                : isEnabled
                                  ? 'text-zinc-300 hover:bg-white/5 hover:text-white'
                                  : 'text-zinc-500 hover:bg-white/5 disabled:cursor-not-allowed'
                            }`}
                          >
                            <Icon className="h-4 w-4 shrink-0" />
                            <span className="flex-1">{t(item.labelKey)}</span>
                            {!isEnabled && (
                              <span className="rounded bg-white/5 px-1.5 py-0.5 text-[10px] uppercase tracking-wide text-zinc-500">
                                {t('common.soon')}
                              </span>
                            )}
                          </button>
                        )
                      })}
                </div>
              </>
            )}
          </div>
          <ProfileButton />
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-6xl px-4 py-10 sm:px-6 sm:py-16">
        <section className="rounded-3xl border border-white/10 bg-black/50 p-6 backdrop-blur-xl sm:p-10">
          <span
            className={`mb-5 inline-block rounded-full px-3 py-1 text-xs font-medium tracking-wide ring-1 ${game.accent} ${game.accentRing}`}
          >
            {game.genre}
          </span>

          <h2 className="mb-5 text-2xl font-semibold tracking-tight text-white sm:text-4xl">
            {game.name}
          </h2>

          <p className="max-w-3xl text-[15px] leading-relaxed text-zinc-300 sm:text-base">
            {copy.description}
          </p>

          <div className="mt-10 grid grid-cols-2 gap-4 sm:grid-cols-4">
            {[
              [t('game.developer'), game.developer],
              [t('game.release'), copy.release],
              [t('game.genre'), copy.genre],
              [t('game.platforms'), copy.platforms],
            ].map(([label, value]) => (
              <div
                key={label}
                className="rounded-xl border border-white/10 bg-white/[0.03] p-4"
              >
                <p className="mb-1.5 text-[11px] uppercase tracking-wide text-zinc-500">
                  {label}
                </p>
                <p className="text-sm font-medium text-white">{value}</p>
              </div>
            ))}
          </div>
        </section>

        <section className="mt-6 rounded-3xl border border-white/10 bg-black/50 p-6 backdrop-blur-xl sm:p-10">
          <h3 className="mb-6 text-lg font-semibold tracking-tight text-white sm:text-xl">
            {t('game.highlights')}
          </h3>

          <ul className="space-y-4">
            {copy.highlights.map((highlight) => (
              <li key={highlight} className="flex gap-4">
                <span
                  className={`mt-2 h-1.5 w-1.5 shrink-0 rounded-full bg-current ${game.accent}`}
                />
                <p className="text-[15px] leading-relaxed text-zinc-300">
                  {highlight}
                </p>
              </li>
            ))}
          </ul>
        </section>
      </main>
    </div>
  )
}

export default GamePage

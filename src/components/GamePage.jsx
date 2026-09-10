import { useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import {
  ArrowLeft,
  BookOpen,
  ChevronDown,
  Globe,
  Home,
  ListOrdered,
  Swords,
  Users,
} from 'lucide-react'
import GameArtwork from './GameArtwork'
import ProfileButton from './ProfileButton'
import { getGameById, getGameCopy } from '../data/games'
import { getGameModes } from '../data/gameModes'
import { WEAPON_SECTIONS, hasWeapons } from '../data/weapons'
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


// --- Expreso Astral de Honkai --------------------------------------------
// Vagones del tren. El primero es la locomotora, con el faro.
const TRAIN_CARS = [0, 1, 2, 3, 4, 5, 6, 7]

// Rocas del cinturon. Van dentro del contenedor girado, asi que su
// desplazamiento horizontal las lleva en diagonal a lo largo de la via.
const ASTEROIDS = [
  'top-[8%] h-3 w-4 [animation-duration:19s] [animation-delay:-2s] opacity-80',
  'top-[16%] h-2 w-2 [animation-duration:26s] [animation-delay:-9s] opacity-60',
  'top-[26%] h-5 w-6 [animation-duration:22s] [animation-delay:-14s] opacity-90',
  'top-[34%] h-2 w-3 [animation-duration:30s] [animation-delay:-5s] opacity-50',
  'top-[44%] h-4 w-5 [animation-duration:17s] [animation-delay:-11s] opacity-85',
  'top-[52%] h-2 w-2 [animation-duration:28s] [animation-delay:-20s] opacity-55',
  'top-[62%] h-6 w-7 [animation-duration:24s] [animation-delay:-3s] opacity-90',
  'top-[70%] h-3 w-4 [animation-duration:21s] [animation-delay:-16s] opacity-70',
  'top-[78%] h-2 w-3 [animation-duration:33s] [animation-delay:-7s] opacity-45',
  'top-[86%] h-4 w-4 [animation-duration:18s] [animation-delay:-23s] opacity-80',
  'top-[94%] h-3 w-5 [animation-duration:27s] [animation-delay:-12s] opacity-65',
]


// --- Puerta celestial de Genshin -----------------------------------------
// Columnas del santuario. Las del primer array quedan al fondo y son mas
// palidas; las del segundo estan en primer plano. y es donde arranca el
// capitel: todas bajan hasta perderse en las nubes.
const GI_COLUMNS_FAR = [
  { x: 62, y: 96, w: 5, o: 0.5 },
  { x: 96, y: 74, w: 6, o: 0.56 },
  { x: 126, y: 104, w: 5, o: 0.46 },
  { x: 150, y: 86, w: 5, o: 0.52 },
  { x: 250, y: 92, w: 5, o: 0.52 },
  { x: 276, y: 70, w: 6, o: 0.58 },
  { x: 306, y: 100, w: 5, o: 0.46 },
  { x: 338, y: 82, w: 6, o: 0.54 },
]

const GI_COLUMNS_NEAR = [
  { x: 26, y: 46, w: 11, o: 0.92 },
  { x: 74, y: 34, w: 10, o: 0.88 },
  { x: 114, y: 56, w: 8, o: 0.8 },
  { x: 290, y: 40, w: 10, o: 0.88 },
  { x: 334, y: 24, w: 12, o: 0.95 },
  { x: 380, y: 50, w: 11, o: 0.92 },
]

// Rayos que salen de detras de la puerta.
const GI_RAYS = [-26, -12, 10, 24]

const GI_CLOUDS = [
  'top-[52%] h-24 w-[30rem] opacity-70 [animation-duration:74s] [animation-delay:-8s]',
  'top-[62%] h-20 w-[24rem] opacity-60 [animation-duration:96s] [animation-delay:-40s]',
  'top-[44%] h-16 w-[20rem] opacity-45 [animation-duration:120s] [animation-delay:-22s]',
  'top-[70%] h-28 w-[34rem] opacity-75 [animation-duration:64s] [animation-delay:-52s]',
  'top-[34%] h-12 w-[16rem] opacity-35 [animation-duration:140s] [animation-delay:-70s]',
]

// Bordes de la pasarela en perspectiva, para trazar sus lineas grabadas.
const GI_PATH_TOP = 166
const GI_PATH_BOTTOM = 225
const giPathEdges = (y) => {
  const t = (y - GI_PATH_TOP) / (GI_PATH_BOTTOM - GI_PATH_TOP)
  return { left: 158 - 40 * t, right: 242 + 40 * t }
}

function StarRailBackground() {
  return (
    <>
      {/* Espacio profundo, con la nebulosa violeta detras del planeta. */}
      <div className="absolute inset-0 bg-[linear-gradient(155deg,#080b1c_0%,#12183a_42%,#1d1749_72%,#0a0c1e_100%)]" />
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_62%_34%,rgba(129,140,248,0.30),transparent_58%)]" />
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_14%_82%,rgba(56,189,248,0.14),transparent_52%)]" />

      {STARS.map((star) => (
        <span
          key={star}
          className={`absolute h-[3px] w-[3px] animate-twinkle rounded-full bg-white ${star}`}
        />
      ))}

      {/* Planeta palido: la luz entra por arriba a la izquierda. */}
      <div className="absolute left-[52%] top-[6%] aspect-square w-[min(78vw,34rem)] -translate-x-1/2 rounded-full bg-[radial-gradient(circle_at_34%_26%,#eef0ea_0%,#c3cabf_34%,#7c877f_62%,#2c3339_88%,#171c22_100%)] opacity-90" />
      <div className="absolute left-[52%] top-[6%] aspect-square w-[min(78vw,34rem)] -translate-x-1/2 rounded-full shadow-[0_0_140px_50px_rgba(148,163,184,0.16)]" />
      {/* Grieta tenue de la superficie. */}
      <div className="absolute left-[52%] top-[6%] aspect-square w-[min(78vw,34rem)] -translate-x-1/2 overflow-hidden rounded-full">
        <div className="absolute left-[38%] top-[30%] h-[42%] w-px rotate-[24deg] bg-gradient-to-b from-transparent via-slate-700/70 to-transparent" />
        <div className="absolute left-[48%] top-[44%] h-[28%] w-px -rotate-[14deg] bg-gradient-to-b from-transparent via-slate-700/60 to-transparent" />
      </div>

      {/* Via, tren y cinturon comparten el mismo giro: todo va en diagonal. */}
      <div className="absolute left-[-22%] top-[30%] h-[46%] w-[144%] -rotate-[21deg]">
        {/* Estela encendida bajo el convoy. */}
        <div className="absolute inset-x-0 top-[58%] h-[3px] bg-gradient-to-r from-transparent via-amber-100 to-transparent shadow-[0_0_40px_rgba(253,230,138,0.95)]" />
        <div className="absolute inset-x-[6%] top-[58%] h-[26px] -translate-y-[12px] bg-gradient-to-r from-transparent via-amber-300/30 to-transparent blur-lg" />

        {ASTEROIDS.map((rock) => (
          <span
            key={rock}
            className={`absolute left-0 animate-driftx rounded-[46%_54%_58%_42%/48%_40%_60%_52%] bg-gradient-to-br from-slate-300/70 via-slate-500/60 to-slate-900/80 ${rock}`}
          />
        ))}

        {/* Convoy: vagones iluminados y el faro en cabeza. */}
        <div className="absolute left-1/2 top-[58%] flex -translate-x-1/2 -translate-y-1/2 items-center gap-2">
          {TRAIN_CARS.map((car) => (
            <span
              key={car}
              className="h-12 w-40 rounded-[6px] bg-gradient-to-b from-slate-300 via-slate-700 to-slate-950 shadow-[0_0_34px_rgba(15,23,42,0.95)] ring-1 ring-slate-200/50"
            >
              <span className="mt-3.5 block h-3.5 w-full bg-[repeating-linear-gradient(90deg,rgba(125,211,252,0.95)_0_10px,transparent_10px_26px)]" />
            </span>
          ))}
          {/* Locomotora: morro mas estrecho, sin faro (va aparte, al borde). */}
          <span className="h-9 w-20 rounded-r-full bg-gradient-to-b from-slate-200 via-slate-600 to-slate-950 ring-1 ring-slate-200/50" />
          <span className="ml-1 h-[5px] w-24 bg-gradient-to-r from-amber-100 to-transparent" />
        </div>
      </div>

      {/* Salto a la velocidad de la luz: el destello nace en el extremo
          derecho, justo delante del convoy, y estira la luz hacia dentro. */}
      <div className="pointer-events-none absolute right-0 top-[30%] -translate-y-1/2">
        <div className="absolute right-0 top-1/2 h-[420px] w-[420px] -translate-y-1/2 translate-x-1/3 rounded-full bg-[radial-gradient(circle,rgba(255,255,255,0.95)_0%,rgba(254,240,138,0.55)_18%,rgba(125,211,252,0.28)_42%,transparent_72%)] blur-[2px]" />
        <div className="absolute right-0 top-1/2 h-[3px] w-[70vw] -translate-y-1/2 bg-gradient-to-l from-white via-amber-100/70 to-transparent" />
        <div className="absolute right-0 top-1/2 h-24 w-[46vw] -translate-y-1/2 bg-gradient-to-l from-amber-100/70 via-sky-200/25 to-transparent blur-2xl" />
        <div className="absolute right-4 top-1/2 h-[190px] w-[3px] -translate-y-1/2 bg-gradient-to-b from-transparent via-white to-transparent blur-[1px]" />
        <div className="absolute right-0 top-1/2 h-24 w-24 -translate-y-1/2 translate-x-1/3 rounded-full bg-white shadow-[0_0_120px_60px_rgba(254,240,138,0.85),0_0_240px_120px_rgba(56,189,248,0.35)]" />
      </div>

      {SHOOTING_STARS.map((shoot) => (
        <span
          key={shoot}
          className={`absolute h-px w-24 rotate-45 animate-shoot bg-gradient-to-r from-transparent via-white to-transparent ${shoot}`}
        />
      ))}
    </>
  )
}

function GenshinColumn({ column }) {
  const shaftTop = column.y + 6
  return (
    <g opacity={column.o}>
      <rect
        x={column.x - column.w * 0.95}
        y={column.y}
        width={column.w * 1.9}
        height="2.6"
        rx="0.8"
        fill="url(#giStoneLit)"
      />
      <rect
        x={column.x - column.w * 0.72}
        y={column.y + 2.6}
        width={column.w * 1.44}
        height="3.4"
        fill="url(#giStone)"
      />
      <rect
        x={column.x - column.w / 2}
        y={shaftTop}
        width={column.w}
        height={225 - shaftTop}
        fill="url(#giStone)"
      />
      <rect
        x={column.x - column.w * 0.16}
        y={shaftTop}
        width={column.w * 0.18}
        height={225 - shaftTop}
        fill="#fff7ea"
        opacity="0.35"
      />
    </g>
  )
}

function GenshinBackground() {
  return (
    <>
      {/* Cielo de atardecer: lavanda arriba, rosa y oro junto al horizonte. */}
      <div className="absolute inset-0 bg-[linear-gradient(to_bottom,#6f6bb0_0%,#9a7fbd_22%,#d09ab4_44%,#eeb49f_62%,#f6d2a8_78%,#e0a682_100%)]" />

      {/* Sol detras de la puerta. */}
      <div className="absolute left-1/2 top-[46%] h-[34rem] w-[34rem] -translate-x-1/2 -translate-y-1/2 rounded-full bg-[radial-gradient(circle,rgba(255,244,214,0.85)_0%,rgba(255,214,170,0.42)_32%,transparent_68%)] blur-[2px]" />

      {/* Mar de nubes cruzando por detras del santuario. */}
      {GI_CLOUDS.map((cloud) => (
        <span
          key={cloud}
          className={`absolute left-0 animate-cloud rounded-full bg-[radial-gradient(ellipse_at_50%_50%,rgba(255,255,255,0.98)_0%,rgba(255,214,226,0.78)_42%,rgba(214,166,196,0.28)_66%,transparent_78%)] blur-lg ${cloud}`}
        />
      ))}

      <svg
        className="absolute inset-0 h-full w-full"
        viewBox="0 0 400 225"
        preserveAspectRatio="xMidYMax slice"
        aria-hidden="true"
      >
        <defs>
          <linearGradient id="giStone" x1="0" y1="0" x2="1" y2="0">
            <stop offset="0%" stopColor="#fff6e8" />
            <stop offset="30%" stopColor="#e3d0cd" />
            <stop offset="70%" stopColor="#9b8aa6" />
            <stop offset="100%" stopColor="#655a7a" />
          </linearGradient>
          <linearGradient id="giStoneLit" x1="0" y1="0" x2="1" y2="0">
            <stop offset="0%" stopColor="#fffaf0" />
            <stop offset="100%" stopColor="#cbbcc9" />
          </linearGradient>
          <linearGradient id="giPath" x1="0" y1="0" x2="0" y2="1">
            <stop offset="0%" stopColor="#fdf2df" />
            <stop offset="60%" stopColor="#f0e2d2" />
            <stop offset="100%" stopColor="#d8c4bb" />
          </linearGradient>
          <linearGradient id="giDoor" x1="0" y1="0" x2="0" y2="1">
            <stop offset="0%" stopColor="#8f93c4" />
            <stop offset="55%" stopColor="#5b5f92" />
            <stop offset="100%" stopColor="#3d4070" />
          </linearGradient>
          <linearGradient id="giRay" x1="0" y1="1" x2="0" y2="0">
            <stop offset="0%" stopColor="#fff4d6" stopOpacity="0.55" />
            <stop offset="100%" stopColor="#fff4d6" stopOpacity="0" />
          </linearGradient>
        </defs>

        {/* Rayos, por detras de todo lo construido. */}
        <g>
          {GI_RAYS.map((offset) => (
            <polygon
              key={offset}
              points={`200,130 ${200 + offset * 3.2 - 9},0 ${200 + offset * 3.2 + 9},0`}
              fill="url(#giRay)"
            />
          ))}
        </g>

        {GI_COLUMNS_FAR.map((column) => (
          <GenshinColumn key={`far-${column.x}`} column={column} />
        ))}

        {/* Balaustrada a ambos lados de la puerta. */}
        <g opacity="0.65">
          <rect x="0" y="150" width="158" height="2" fill="url(#giStoneLit)" />
          <rect x="242" y="150" width="158" height="2" fill="url(#giStoneLit)" />
          {Array.from({ length: 20 }, (_, i) => i * 8).map((x) => (
            <rect key={`bl-${x}`} x={x} y="152" width="2" height="9" fill="url(#giStone)" />
          ))}
          {Array.from({ length: 20 }, (_, i) => 244 + i * 8).map((x) => (
            <rect key={`br-${x}`} x={x} y="152" width="2" height="9" fill="url(#giStone)" />
          ))}
        </g>

        {/* La puerta. */}
        <g>
          <path
            d="M163 158 L163 62 A37 37 0 0 1 237 62 L237 158 Z"
            fill="url(#giDoor)"
            stroke="#fbf1ea"
            strokeWidth="2.2"
            strokeOpacity="0.95"
          />
          <path d="M171 156 L171 63 A29 29 0 0 1 229 63 L229 156 Z" fill="#3f4478" opacity="0.94" />
          <path
            d="M200 74 C188 96 188 122 200 144 C212 122 212 96 200 74 Z"
            fill="none"
            stroke="#dfe3ff"
            strokeWidth="1.3"
            strokeOpacity="0.8"
          />
          <circle cx="200" cy="109" r="6" fill="none" stroke="#dfe3ff" strokeWidth="1" strokeOpacity="0.7" />
          <line
            x1="200"
            y1="63"
            x2="200"
            y2="156"
            stroke="#b9bee8"
            strokeWidth="0.8"
            strokeOpacity="0.65"
          />
          {/* Escalones sobre los que se apoya. */}
          <rect x="159" y="158" width="82" height="3.6" fill="url(#giStone)" />
          <rect x="153" y="161.6" width="94" height="4.4" fill="url(#giStoneLit)" />
        </g>

        {/* Pasarela de piedra hacia la puerta. */}
        <polygon points="158,166 242,166 282,225 118,225" fill="url(#giPath)" />
        <g stroke="#b9a597" strokeOpacity="0.5" strokeWidth="0.5">
          {[176, 188, 200, 213].map((y) => {
            const edge = giPathEdges(y)
            return <line key={`pl-${y}`} x1={edge.left} y1={y} x2={edge.right} y2={y} />
          })}
          <line x1="170" y1="166" x2="141" y2="225" />
          <line x1="230" y1="166" x2="259" y2="225" />
        </g>

        {GI_COLUMNS_NEAR.map((column) => (
          <GenshinColumn key={`near-${column.x}`} column={column} />
        ))}
      </svg>

      {/* Motas de luz subiendo. */}
      {FLOATERS.map((floater) => (
        <span
          key={floater}
          className={`absolute h-1.5 w-1.5 animate-rise rounded-full bg-amber-50 shadow-[0_0_12px_rgba(255,237,213,0.95)] ${floater}`}
        />
      ))}

      {/* Velo superior para que la cabecera se siga leyendo sobre el cielo. */}
      <div className="absolute inset-x-0 top-0 h-40 bg-gradient-to-b from-black/45 via-black/20 to-transparent" />
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

// --- Hipodromo de Umamusume ----------------------------------------------
// Escena fija: gradas a la izquierda, cielo y arboleda al fondo, valla blanca
// y cesped en perspectiva. Sin animacion, tal y como se pidio.

// Rayas del cesped: todas salen del punto de fuga, asi que la hierba parece
// abrirse hacia el espectador.
const UMA_VANISH = { x: 268, y: 76 }
const UMA_TURF_LINES = [
  { x: -220, w: 3.4, o: 0.5 },
  { x: -140, w: 2.6, o: 0.34 },
  { x: -70, w: 3.8, o: 0.46 },
  { x: -10, w: 2.4, o: 0.3 },
  { x: 48, w: 4.2, o: 0.52 },
  { x: 110, w: 2.8, o: 0.32 },
  { x: 168, w: 3.4, o: 0.44 },
  { x: 232, w: 2.6, o: 0.3 },
  { x: 300, w: 4, o: 0.48 },
  { x: 372, w: 2.8, o: 0.34 },
  { x: 450, w: 3.6, o: 0.42 },
  { x: 540, w: 2.6, o: 0.28 },
]

// Briznas de hierba levantadas por las carreras.
const UMA_BLADES = [
  'left-[6%] top-[54%] h-6 w-1.5 -rotate-[28deg]',
  'left-[13%] top-[70%] h-8 w-2 rotate-[16deg]',
  'left-[22%] top-[46%] h-5 w-1.5 rotate-[42deg]',
  'left-[35%] top-[78%] h-7 w-2 -rotate-[18deg]',
  'left-[47%] top-[58%] h-5 w-1.5 rotate-[34deg]',
  'left-[58%] top-[84%] h-8 w-2 -rotate-[36deg]',
  'left-[69%] top-[50%] h-6 w-1.5 rotate-[22deg]',
  'left-[79%] top-[72%] h-7 w-2 -rotate-[26deg]',
  'left-[89%] top-[44%] h-5 w-1.5 rotate-[38deg]',
  'left-[94%] top-[64%] h-6 w-2 -rotate-[14deg]',
]

// Destellos del sol sobre el cesped.
const UMA_SPARKS = [
  'left-[9%] top-[62%] h-2 w-2',
  'left-[19%] top-[48%] h-1.5 w-1.5',
  'left-[29%] top-[74%] h-2.5 w-2.5',
  'left-[41%] top-[52%] h-1.5 w-1.5',
  'left-[52%] top-[68%] h-2 w-2',
  'left-[63%] top-[45%] h-2.5 w-2.5',
  'left-[73%] top-[80%] h-1.5 w-1.5',
  'left-[84%] top-[56%] h-2 w-2',
  'left-[92%] top-[70%] h-2.5 w-2.5',
]

function UmamusumeBackground() {
  return (
    <>
      <svg
        viewBox="0 0 400 225"
        preserveAspectRatio="xMidYMid slice"
        className="absolute inset-0 h-full w-full"
        aria-hidden="true"
      >
        <defs>
          <linearGradient id="umaSky" x1="0" y1="0" x2="0" y2="1">
            <stop offset="0%" stopColor="#8ec5e8" />
            <stop offset="55%" stopColor="#c2e0f0" />
            <stop offset="100%" stopColor="#e8f4ee" />
          </linearGradient>
          <linearGradient id="umaTurf" x1="0" y1="0" x2="0" y2="1">
            <stop offset="0%" stopColor="#3f9b32" />
            <stop offset="20%" stopColor="#63c93b" />
            <stop offset="55%" stopColor="#8fe348" />
            <stop offset="100%" stopColor="#b6f05e" />
          </linearGradient>
          <linearGradient id="umaDirt" x1="0" y1="0" x2="0" y2="1">
            <stop offset="0%" stopColor="#c9a06a" />
            <stop offset="100%" stopColor="#e0c294" />
          </linearGradient>
          <linearGradient id="umaStand" x1="0" y1="0" x2="1" y2="0.4">
            <stop offset="0%" stopColor="#3b3f6b" />
            <stop offset="70%" stopColor="#5a5f8c" />
            <stop offset="100%" stopColor="#7e83ab" />
          </linearGradient>
          <linearGradient id="umaRoof" x1="0" y1="0" x2="1" y2="0">
            <stop offset="0%" stopColor="#1f2340" />
            <stop offset="100%" stopColor="#454a75" />
          </linearGradient>
          <radialGradient id="umaSun" cx="0.5" cy="0.5" r="0.5">
            <stop offset="0%" stopColor="#fffdf2" stopOpacity="0.95" />
            <stop offset="100%" stopColor="#fffdf2" stopOpacity="0" />
          </radialGradient>
        </defs>

        {/* Cielo y sol. */}
        <rect x="0" y="0" width="400" height="92" fill="url(#umaSky)" />
        <circle cx="300" cy="24" r="46" fill="url(#umaSun)" />
        <ellipse cx="268" cy="26" rx="34" ry="9" fill="#ffffff" opacity="0.85" />
        <ellipse cx="292" cy="21" rx="22" ry="7" fill="#ffffff" opacity="0.8" />
        <ellipse cx="352" cy="34" rx="28" ry="8" fill="#ffffff" opacity="0.7" />
        <ellipse cx="214" cy="16" rx="20" ry="6" fill="#ffffff" opacity="0.6" />

        {/* Arboleda del fondo. */}
        {[188, 206, 224, 244, 262, 282, 302, 322, 344, 366, 388].map((x, i) => (
          <ellipse
            key={`tree-${x}`}
            cx={x}
            cy={70 - (i % 3) * 2}
            rx={13 + (i % 4) * 2}
            ry={8 + (i % 3) * 1.5}
            fill="#2c6b33"
            opacity="0.85"
          />
        ))}
        <rect x="176" y="70" width="224" height="6" fill="#2f7237" />

        {/* Pista de arena exterior y su valla blanca. */}
        <rect x="150" y="76" width="250" height="13" fill="url(#umaDirt)" />
        <rect x="150" y="75" width="250" height="1.6" fill="#f7fbff" />
        <rect x="150" y="86" width="250" height="2.2" fill="#f7fbff" />
        {Array.from({ length: 22 }, (_, i) => 154 + i * 11.5).map((x) => (
          <rect key={`post-${x}`} x={x} y="75" width="1.6" height="13" fill="#eef4fa" />
        ))}

        {/* Gradas: techo en voladizo y publico. */}
        <polygon points="0,0 168,0 150,30 0,44" fill="url(#umaRoof)" />
        <polygon points="0,44 150,30 150,78 0,96" fill="url(#umaStand)" />
        <polygon points="0,44 150,30 150,34 0,49" fill="#9aa0c8" opacity="0.7" />
        {/* Filas de publico: puntitos en diagonal siguiendo la grada. */}
        {Array.from({ length: 7 }, (_, row) => row).map((row) =>
          Array.from({ length: 34 }, (_, col) => col).map((col) => {
            const x = 3 + col * 4.4
            const y = 38 + row * 6.2 + (150 - x) * 0.055
            return (
              <circle
                key={`fan-${row}-${col}`}
                cx={x}
                cy={y}
                r={1.5 - row * 0.08}
                fill={col % 3 === 0 ? '#e7e9f7' : col % 3 === 1 ? '#b6bcdf' : '#8f96c4'}
                opacity={0.5 + ((row + col) % 4) * 0.1}
              />
            )
          }),
        )}
        <rect x="0" y="90" width="152" height="4" fill="#2b2f52" opacity="0.8" />

        {/* Valla interior blanca que separa las gradas del cesped. */}
        <polygon points="0,96 150,78 150,82 0,101" fill="#f7fbff" opacity="0.95" />
        {Array.from({ length: 14 }, (_, i) => i * 11).map((x) => (
          <rect
            key={`rail-${x}`}
            x={x}
            y={96 - x * 0.12}
            width="1.6"
            height="8"
            fill="#eef4fa"
            opacity="0.9"
          />
        ))}

        {/* Cesped en perspectiva. */}
        <polygon points="0,101 150,82 400,88 400,225 0,225" fill="url(#umaTurf)" />
        <g stroke="#e6ffb0" strokeLinecap="round">
          {UMA_TURF_LINES.map((line) => (
            <line
              key={`turf-${line.x}`}
              x1={UMA_VANISH.x}
              y1={UMA_VANISH.y}
              x2={line.x}
              y2={225}
              strokeWidth={line.w}
              strokeOpacity={line.o}
            />
          ))}
        </g>
        {/* Franjas de siega, mas claras y muy tenues. */}
        {[112, 138, 168, 202, 225].map((y, i) => (
          <rect
            key={`mow-${y}`}
            x="0"
            y={y}
            width="400"
            height={6 + i * 2}
            fill="#ffffff"
            opacity="0.06"
          />
        ))}

        {/* Poste de distancia rojiblanco a la derecha. */}
        <rect x="348" y="30" width="3.4" height="58" fill="#f4f7fb" />
        {[34, 44, 54, 64, 74].map((y) => (
          <rect key={`pole-${y}`} x="348" y={y} width="3.4" height="5" fill="#d94a4a" />
        ))}
        <rect x="342" y="22" width="15" height="10" rx="2" fill="#f4f7fb" />
        <text x="349.5" y="30" textAnchor="middle" fontSize="8" fontWeight="700" fill="#2d3350">
          2
        </text>
      </svg>

      {/* Briznas de hierba levantadas. */}
      {UMA_BLADES.map((blade) => (
        <span
          key={blade}
          className={`absolute rounded-full bg-lime-200/80 shadow-[0_0_10px_rgba(190,242,100,0.7)] ${blade}`}
        />
      ))}

      {/* Destellos. */}
      {UMA_SPARKS.map((spark) => (
        <span
          key={spark}
          className={`absolute rounded-full bg-white shadow-[0_0_14px_6px_rgba(255,255,255,0.75)] ${spark}`}
        />
      ))}

      {/* Vineteado suave para que el texto de las tarjetas siga leyendose. */}
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_50%_45%,transparent_38%,rgba(12,20,10,0.3)_100%)]" />
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
  // La etiqueta cambia por juego: "Conos de luz" en Honkai y "Armas" en el
  // resto, asi que se resuelve al pintar el menu y no aqui.
  { id: 'armas', labelKey: 'game.menu.weapons', icon: Swords },
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
  const hasWeaponSection = hasWeapons(game.id)
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
                        const isWeapons = item.id === 'armas'
                        const isEnabled =
                          isCurrent ||
                          (isCharacters && hasCharacters) ||
                          (isTierList && hasTierList) ||
                          (isGuides && hasGuides) ||
                          (isWeapons && hasWeaponSection)

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
                              } else if (isWeapons) {
                                navigate(`/game/${gameId}/weapons`)
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
                            <span className="flex-1">
                              {t(
                                isWeapons
                                  ? (WEAPON_SECTIONS[game.id]?.menuKey ??
                                      'game.menu.weapons')
                                  : item.labelKey,
                              )}
                            </span>
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
        <section className="rounded-3xl border border-white/10 bg-black/55 p-6 backdrop-blur-sm sm:p-10">
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
                className="rounded-xl border border-white/10 bg-black/40 p-4"
              >
                <p className="mb-1.5 text-[11px] uppercase tracking-wide text-zinc-300">
                  {label}
                </p>
                <p className="text-sm font-medium text-white">{value}</p>
              </div>
            ))}
          </div>
        </section>

        <section className="mt-6 rounded-3xl border border-white/10 bg-black/55 p-6 backdrop-blur-sm sm:p-10">
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

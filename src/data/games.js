import genshinLogo from '../assets/games/GenshinImpactLogo.jpg'
import starRailLogo from '../assets/games/HonkaiStarRailLogo.jpg'
import dxdArt from '../assets/games/hIghschooldxdOPILogo.jpg'
import umamusumeArt from '../assets/games/Umamusume-Pretty-Derby-logo.jpg'
import zzzLogo from '../assets/games/ZenlesszonezeroLogo.jpg'
import { GAME_COPY_EN } from './gamesEn'

// imageFit 'logo': el archivo es un logo sobre fondo blanco, asi que va
// centrado sobre una placa clara. 'cover': es arte a color y llena la caja.
export const GAME_CATALOG = [
  {
    id: 'genshin-impact',
    name: 'Genshin Impact',
    short: 'GI',
    image: genshinLogo,
    imageFit: 'logo',
    theme: 'genshin',
    banner: 'from-sky-500/45 via-cyan-500/15 to-transparent',
    glow: 'text-sky-200',
    accent: 'text-sky-300',
    accentRing: 'ring-sky-400/30',
    tagline: 'Step Into a Vast Magical World of Adventure',
    developer: 'HoYoverse',
    release: '28 de septiembre de 2020',
    genre: 'RPG de acción y mundo abierto',
    platforms: 'PC, PlayStation, iOS y Android',
    description:
      'Genshin Impact transcurre en Teyvat, un mundo de fantasía formado por siete naciones, cada una gobernada por un Arconte y ligada a uno de los siete elementos. Encarnas al Viajero, un visitante de otro mundo separado de su hermano gemelo por una diosa desconocida, que recorre el continente en su busca mientras descubre los secretos que lo sostienen.',
    highlights: [
      'Exploración libre: escalar, planear y nadar por todo el continente sin barreras.',
      'Combate elemental en el que combinas reacciones entre los siete elementos.',
      'Equipos de cuatro personajes intercambiables en pleno combate.',
    ],
  },
  {
    id: 'honkai-star-rail',
    name: 'Honkai: Star Rail',
    short: 'HSR',
    image: starRailLogo,
    imageFit: 'logo',
    // El logo esta algo alto en el archivo: subir la ventana de recorte lo baja.
    imagePosition: 'object-[50%_45%]',
    theme: 'starrail',
    banner: 'from-indigo-500/45 via-violet-500/15 to-transparent',
    glow: 'text-indigo-200',
    accent: 'text-indigo-300',
    accentRing: 'ring-indigo-400/30',
    tagline: 'May This Journey Lead Us Starward',
    developer: 'HoYoverse',
    release: '26 de abril de 2023',
    genre: 'RPG por turnos de fantasía espacial',
    platforms: 'PC, PlayStation 5, iOS y Android',
    description:
      'Honkai: Star Rail te sube a bordo del Expreso Astral, un tren capaz de viajar entre mundos. Como Pionero portas un Estelarón en tu interior, la semilla de un cataclismo que amenaza a cada planeta que visitas, y recorres la galaxia junto a la tripulación buscando entender su origen.',
    highlights: [
      'Combate por turnos con debilidades elementales y roturas de escudo.',
      'Sistema de Sendas que define el rol de cada personaje en el equipo.',
      'Mundos autoconclusivos con una historia propia en cada planeta.',
    ],
  },
  {
    id: 'high-school-dxd-opi',
    name: 'High School DxD: OPI',
    short: 'DxD',
    image: dxdArt,
    imageFit: 'cover',
    theme: 'dxd',
    banner: 'from-rose-500/45 via-red-500/15 to-transparent',
    glow: 'text-rose-200',
    accent: 'text-rose-300',
    accentRing: 'ring-rose-400/30',
    tagline: 'Operation Paradise Infinity',
    developer: 'G123',
    release: '22 de abril de 2025',
    genre: 'RPG de navegador basado en el anime',
    platforms: 'Navegador en PC, tablet y móvil',
    description:
      'High School D×D: Operation Paradise Infinity es un RPG basado en la serie de anime High School D×D. Reúne a más de sesenta personajes de la obra, entre ellos Issei Hyodo y Rias Gremory, con ilustraciones creadas en exclusiva para el juego, y te pide formar el mejor equipo aprovechando las habilidades y atributos de cada uno.',
    highlights: [
      'Más de 60 personajes de la serie, con arte exclusivo del juego.',
      'Tecnología HTML5: se juega en el navegador, sin instalar nada.',
      'Free to play, con compras opcionales dentro del juego.',
    ],
  },
  {
    id: 'umamusume-pretty-derby',
    name: 'Umamusume: Pretty Derby',
    short: 'UMA',
    image: umamusumeArt,
    imageFit: 'cover',
    // El logotipo esta en la franja baja del arte: el encuadre baja para que
    // entre en la tarjeta en lugar de quedarse fuera.
    imagePosition: 'object-[50%_85%]',
    theme: 'umamusume',
    banner: 'from-amber-700/45 via-yellow-600/15 to-transparent',
    glow: 'text-amber-100',
    accent: 'text-amber-200',
    accentRing: 'ring-amber-300/30',
    tagline: 'Eclipse first, the rest nowhere',
    developer: 'Cygames',
    release: '24 de febrero de 2021 (Japón) · 26 de junio de 2025 (versión en inglés)',
    genre: 'Simulación de entrenamiento y carreras',
    platforms: 'PC (Steam), iOS y Android',
    description:
      'Umamusume: Pretty Derby es un juego de simulación de Cygames dentro del proyecto Umamusume, una franquicia que abarca anime, manga y música. Te pone al mando del entrenamiento de una umamusume, una chica caballo inspirada en un purasangre japonés real, y te encarga llevarla a lo más alto de las carreras.',
    highlights: [
      'Entrenamiento por turnos que moldea las estadísticas y aptitudes de cada umamusume.',
      'Personajes basados en purasangres japoneses reales y sus trayectorias.',
      'Carreras en 3D con comentarios en directo durante la competición.',
    ],
  },
  {
    id: 'zenless-zone-zero',
    name: 'Zenless Zone Zero',
    short: 'ZZZ',
    image: zzzLogo,
    imageFit: 'logo',
    theme: 'zzz',
    banner: 'from-amber-500/45 via-orange-500/15 to-transparent',
    glow: 'text-amber-200',
    accent: 'text-amber-300',
    accentRing: 'ring-amber-400/30',
    tagline: "Welcome to New Eridu — Don't enter the Hollows",
    developer: 'HoYoverse',
    release: '4 de julio de 2024',
    genre: 'RPG de acción y fantasía urbana',
    platforms: 'PC, PlayStation 5, iOS y Android',
    description:
      'Zenless Zone Zero se sitúa en un futuro cercano arrasado por los Hollows, un desastre natural que devoró la civilización. Nueva Eridu es el último oasis que ha aprendido a convivir con ellos. Actúas como Proxy, guiando a los Agentes que se adentran en los Hollows para cumplir encargos y desentrañar el misterio que rodea a la ciudad.',
    highlights: [
      'Combate de acción rápido con cambios de personaje encadenados.',
      'Nueva Eridu como hub urbano lleno de facciones enfrentadas.',
      'Exploración de los Hollows sobre un tablero de televisores.',
    ],
  },
]

export const getGameById = (id) => GAME_CATALOG.find((game) => game.id === id)

// Textos del juego en el idioma activo. El catalogo esta escrito en castellano,
// asi que solo el ingles necesita buscarse aparte.
export const getGameCopy = (game, language) => {
  const english = language === 'en' ? GAME_COPY_EN[game.id] : null
  return {
    release: english?.release ?? game.release,
    genre: english?.genre ?? game.genre,
    platforms: english?.platforms ?? game.platforms,
    description: english?.description ?? game.description,
    highlights: english?.highlights ?? game.highlights,
  }
}

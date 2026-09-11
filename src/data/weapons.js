// Configuracion de la seccion de armas y conos de luz.
//
// Los tres juegos comparten la tabla "weapons" y los mismos componentes: lo
// unico que cambia entre ellos es como se llama la seccion y como se llama la
// categoria por la que se filtra.

export const WEAPON_SECTIONS = {
  'genshin-impact': {
    titleKey: 'weapons.gi.title',
    categoryKey: 'weapons.gi.category',
    menuKey: 'game.menu.weapons',
    // En Genshin los cinco niveles de la pasiva son refinamientos (R1-R5).
    rankKey: 'weapons.rankRefine',
  },
  'honkai-star-rail': {
    titleKey: 'weapons.hsr.title',
    categoryKey: 'weapons.hsr.category',
    menuKey: 'game.menu.lightCones',
  },
  'zenless-zone-zero': {
    titleKey: 'weapons.zzz.title',
    categoryKey: 'weapons.zzz.category',
    menuKey: 'game.menu.wEngines',
    // Los cinco niveles del efecto se suben con copias del amplificador.
    rankKey: 'weapons.rankLevel',
  },
}

export const hasWeapons = (gameId) => Boolean(WEAPON_SECTIONS[gameId])

// Pistas de disco: solo las tiene Zenless.
export const hasDriveDiscs = (gameId) => gameId === 'zenless-zone-zero'

// Genshin y Honkai guardan la rareza en estrellas (5, 4, 3...) y Zenless en
// letras (S, A, B). Para ordenar y dar color se pasan las letras a numero, y al
// mostrarla se ensena la letra tal cual en vez de estrellas.
const RANGO_LETRA = { S: 5, A: 4, B: 3 }
export const rarityRank = (rarity) => RANGO_LETRA[rarity] ?? (Number(rarity) || 1)
export const rarityLabel = (rarity) =>
  RANGO_LETRA[rarity] ? rarity : '★'.repeat(Number(rarity) || 1)

// Un color por categoria. Las clases se escriben enteras porque Tailwind lee
// el codigo como texto y una clase montada a trozos no llegaria a generarse.
const CATEGORY_STYLES = {
  // Honkai: vias
  Destrucción: 'text-red-300 ring-red-400/30',
  Cacería: 'text-sky-300 ring-sky-400/30',
  Erudición: 'text-cyan-300 ring-cyan-400/30',
  Armonía: 'text-emerald-300 ring-emerald-400/30',
  Nihilidad: 'text-violet-300 ring-violet-400/30',
  Conservación: 'text-amber-300 ring-amber-400/30',
  Abundancia: 'text-lime-300 ring-lime-400/30',
  Memoria: 'text-indigo-300 ring-indigo-400/30',
  Exultación: 'text-fuchsia-300 ring-fuchsia-400/30',
  // Genshin: tipos de arma
  'Espada ligera': 'text-sky-300 ring-sky-400/30',
  Espada: 'text-sky-300 ring-sky-400/30',
  Mandoble: 'text-amber-300 ring-amber-400/30',
  Lanza: 'text-rose-300 ring-rose-400/30',
  Arco: 'text-emerald-300 ring-emerald-400/30',
  Catalizador: 'text-violet-300 ring-violet-400/30',
  // Zenless: especialidades. La tabla de personajes usa una palabra y la de
  // amplificadores otra, asi que estan las dos.
  Atacante: 'text-red-300 ring-red-400/30',
  Aturdidor: 'text-amber-300 ring-amber-400/30',
  'Anómalo': 'text-fuchsia-300 ring-fuchsia-400/30',
  Auxiliar: 'text-emerald-300 ring-emerald-400/30',
  Defensivo: 'text-sky-300 ring-sky-400/30',
  Disruptivo: 'text-orange-300 ring-orange-400/30',
  Armero: 'text-lime-300 ring-lime-400/30',
  Ataque: 'text-red-300 ring-red-400/30',
  Aturdimiento: 'text-amber-300 ring-amber-400/30',
  Anomalía: 'text-fuchsia-300 ring-fuchsia-400/30',
  Apoyo: 'text-emerald-300 ring-emerald-400/30',
  Defensa: 'text-sky-300 ring-sky-400/30',
  Ruptura: 'text-orange-300 ring-orange-400/30',
  Blindaje: 'text-lime-300 ring-lime-400/30',
}

const FALLBACK = 'text-zinc-300 ring-white/20'

export const getCategoryStyle = (category) => CATEGORY_STYLES[category] ?? FALLBACK

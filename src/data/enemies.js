// Apartado de enemigos: que juegos lo tienen y como se organiza en cada uno.
//
// Honkai tiene debilidades de verdad, asi que se filtra por "Debil a". En
// Genshin casi todos los enemigos resisten un 10% a todo: lo util es saber a
// que elemento NO resisten mucho, y ademas tiene una pestana de fauna.
export const ENEMY_SECTIONS = {
  'honkai-star-rail': {
    tabs: ['jefe', 'esbirro'],
    // Orden en el que el juego muestra los elementos.
    elements: ['Físico', 'Fuego', 'Hielo', 'Rayo', 'Viento', 'Cuántico', 'Imaginario'],
    filter: 'weakTo',
  },
  'genshin-impact': {
    tabs: ['jefe', 'esbirro', 'fauna'],
    elements: ['Físico', 'Pyro', 'Hydro', 'Anemo', 'Electro', 'Dendro', 'Cryo', 'Geo'],
    filter: 'notResistant',
  },
}

export const hasEnemies = (gameId) => Boolean(ENEMY_SECTIONS[gameId])

// Resistencia a partir de la cual se considera alta (en %).
export const HIGH_RESISTANCE = 30

// Las clases van enteras para que Tailwind las genere.
export const RANK_STYLES = {
  jefe: 'bg-rose-500/15 text-rose-200 ring-rose-400/30',
  elite: 'bg-amber-500/15 text-amber-200 ring-amber-400/30',
  normal: 'bg-white/10 text-zinc-300 ring-white/20',
}

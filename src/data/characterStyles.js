// Las clases se escriben enteras porque Tailwind analiza el codigo como texto:
// una clase construida a trozos no llegaria a generarse.
const ELEMENT_STYLES = {
  Anemo: { badge: 'bg-teal-500/15 text-teal-300 ring-teal-400/30', tile: 'from-teal-500/40 to-teal-900/10' },
  Geo: { badge: 'bg-amber-500/15 text-amber-300 ring-amber-400/30', tile: 'from-amber-500/40 to-amber-900/10' },
  Electro: { badge: 'bg-purple-500/15 text-purple-300 ring-purple-400/30', tile: 'from-purple-500/40 to-purple-900/10' },
  Dendro: { badge: 'bg-green-500/15 text-green-300 ring-green-400/30', tile: 'from-green-500/40 to-green-900/10' },
  Hydro: { badge: 'bg-blue-500/15 text-blue-300 ring-blue-400/30', tile: 'from-blue-500/40 to-blue-900/10' },
  Pyro: { badge: 'bg-red-500/15 text-red-300 ring-red-400/30', tile: 'from-red-500/40 to-red-900/10' },
  Cryo: { badge: 'bg-cyan-500/15 text-cyan-300 ring-cyan-400/30', tile: 'from-cyan-500/40 to-cyan-900/10' },
  Físico: { badge: 'bg-zinc-500/15 text-zinc-300 ring-zinc-400/30', tile: 'from-zinc-500/40 to-zinc-900/10' },
  Fuego: { badge: 'bg-orange-500/15 text-orange-300 ring-orange-400/30', tile: 'from-orange-500/40 to-orange-900/10' },
  Hielo: { badge: 'bg-sky-500/15 text-sky-300 ring-sky-400/30', tile: 'from-sky-500/40 to-sky-900/10' },
  Rayo: { badge: 'bg-violet-500/15 text-violet-300 ring-violet-400/30', tile: 'from-violet-500/40 to-violet-900/10' },
  Viento: { badge: 'bg-emerald-500/15 text-emerald-300 ring-emerald-400/30', tile: 'from-emerald-500/40 to-emerald-900/10' },
  Cuántico: { badge: 'bg-indigo-500/15 text-indigo-300 ring-indigo-400/30', tile: 'from-indigo-500/40 to-indigo-900/10' },
  Imaginario: { badge: 'bg-yellow-500/15 text-yellow-300 ring-yellow-400/30', tile: 'from-yellow-500/40 to-yellow-900/10' },
  Eléctrico: { badge: 'bg-blue-500/15 text-blue-300 ring-blue-400/30', tile: 'from-blue-500/40 to-blue-900/10' },
  Éter: { badge: 'bg-fuchsia-500/15 text-fuchsia-300 ring-fuchsia-400/30', tile: 'from-fuchsia-500/40 to-fuchsia-900/10' },
  Etéreo: { badge: 'bg-fuchsia-500/15 text-fuchsia-300 ring-fuchsia-400/30', tile: 'from-fuchsia-500/40 to-fuchsia-900/10' },
  'Multi-elemento': { badge: 'bg-pink-500/15 text-pink-300 ring-pink-400/30', tile: 'from-pink-500/40 to-indigo-900/10' },
}

const FALLBACK_STYLE = {
  badge: 'bg-white/10 text-zinc-300 ring-white/20',
  tile: 'from-zinc-600/40 to-zinc-900/10',
}

const RARITY_STYLES = {
  '5': 'bg-amber-500/15 text-amber-300 ring-amber-400/30',
  S: 'bg-amber-500/15 text-amber-300 ring-amber-400/30',
  '4': 'bg-purple-500/15 text-purple-300 ring-purple-400/30',
  A: 'bg-purple-500/15 text-purple-300 ring-purple-400/30',
}

export const getElementStyle = (element) =>
  ELEMENT_STYLES[element] ?? FALLBACK_STYLE

export const getRarityStyle = (rarity) =>
  RARITY_STYLES[rarity] ?? FALLBACK_STYLE.badge

// Genshin y Star Rail usan estrellas; Zenless usa rangos con letra.
export const formatRarity = (rarity) =>
  rarity === '4' || rarity === '5' ? `${rarity}★` : rarity

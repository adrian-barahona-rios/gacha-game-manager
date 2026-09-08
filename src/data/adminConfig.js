// Configuracion del panel de administracion.
//
// Cada juego guarda sus personajes de forma distinta: los cuatro primeros
// comparten la tabla "characters", mientras que Umamusume tiene la suya con
// columnas propias y sin biografia.

export const ADMIN_GAMES = [
  {
    id: 'genshin-impact',
    name: 'Genshin Impact',
    table: 'characters',
    prefix: 'gi',
    elementKey: 'admin.field.element',
    elements: ['Anemo', 'Cryo', 'Dendro', 'Electro', 'Geo', 'Hydro', 'Pyro', 'Multi-elemento'],
    rarities: ['4', '5'],
    roleKey: 'admin.field.role',
    levelCap: 90,
  },
  {
    id: 'honkai-star-rail',
    name: 'Honkai: Star Rail',
    table: 'characters',
    prefix: 'hsr',
    elementKey: 'admin.field.element',
    elements: ['Cuántico', 'Fuego', 'Físico', 'Hielo', 'Imaginario', 'Rayo', 'Viento'],
    rarities: ['4', '5'],
    roleKey: 'admin.field.role',
    pathKey: 'character.path.hsr',
    signatureKey: 'character.signature.hsr',
    levelCap: 80,
  },
  {
    id: 'zenless-zone-zero',
    name: 'Zenless Zone Zero',
    table: 'characters',
    prefix: 'zzz',
    elementKey: 'admin.field.attribute',
    elements: ['Eléctrico', 'Etéreo', 'Fuego', 'Físico', 'Hielo'],
    rarities: ['A', 'S'],
    roleKey: 'admin.field.role',
    pathKey: 'character.path.zzz',
    signatureKey: 'character.signature.zzz',
    levelCap: 60,
  },
  {
    id: 'high-school-dxd-opi',
    name: 'High School DxD: OPI',
    table: 'characters',
    prefix: 'dxd',
    // La ficha de DxD solo guarda nombre y descripcion.
    roleKey: 'admin.field.role',
  },
  {
    id: 'umamusume-pretty-derby',
    name: 'Umamusume: Pretty Derby',
    table: 'umamusume_characters',
    prefix: 'uma',
    versions: ['global', 'japan'],
    rarities: ['★', '★★', '★★★'],
    baseCharacter: true,
  },
]

// Solo estos tres juegos tienen tier list oficial cargada.
export const TIER_LIST_GAMES = [
  { id: 'genshin-impact', name: 'Genshin Impact', modes: ['General'] },
  {
    id: 'honkai-star-rail',
    name: 'Honkai: Star Rail',
    modes: ['Memory of Chaos', 'Pure Fiction', 'Apocalyptic Shadow'],
  },
  { id: 'zenless-zone-zero', name: 'Zenless Zone Zero', modes: ['General'] },
]

// Escala de Prydwen: 0 es el tier mas alto y 5 el mas bajo.
export const TIER_RATINGS = [0, 0.5, 1, 1.5, 2, 3, 4, 5]

export const BIOGRAPHY_GAMES = ADMIN_GAMES.filter((game) => game.table === 'characters')

export const getAdminGame = (id) => ADMIN_GAMES.find((game) => game.id === id)

// "Yumemizuki Mizuki" -> "gi-yumemizuki-mizuki". Los ids ya existentes siguen
// este patron, asi que conviene mantenerlo.
export const buildCharacterId = (prefix, name) => {
  const slug = name
    .normalize('NFD')
    .replace(/\p{Diacritic}/gu, '')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
  return slug ? `${prefix}-${slug}` : ''
}

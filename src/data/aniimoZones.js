// Mapa de Aniimo: regiones, zonas y puntos de interes.
//
// Los nombres de las zonas estan en espanol porque son los que usa la wiki
// oficial en las fichas de cada criatura (su apartado de habitats). Los nombres
// de las regiones y de los puntos de interes siguen en ingles: el juego todavia
// no los ha traducido, asi que se dejan como aparecen y se explican al lado.
//
// Fuentes: wiki.aniimo.com (habitats de cada criatura) y la guia del mapa de
// Game8 (game8.co/games/Aniimo/archives/618730).

export const REGIONS = [
  {
    id: 'breezy-plains',
    name: 'Breezy Plains',
    description:
      'La primera región de Idyll y la más grande: catorce zonas con criaturas, jefes Alfa, retos de Pathfinder y ámbares Lumin. Se abre después de terminar la historia en Astra.',
    areas: [
      'El Estrecho de Plata',
      'Campos Nubosos',
      'Bosque de Estrellas Fugaces',
      'Desembarco de Echoback',
      'Cresta de Bestiacolmillo',
      'Bosques de Neblina',
      'Bosque Electrizante',
      'Costa de la Marea Floreciente',
      'Mar de Flores',
      'Pradera del Deslizamiento',
      'Pasarela Berilina',
      'Sierras Bermejas',
      'Puente Terrestre de Céfiro',
      'Bosque de la Torre de los Rosales',
    ],
  },
  {
    id: 'astra',
    name: 'Astra',
    description:
      'La zona residencial que flota sobre Idyll: tiendas, vendedores, refugios y retos de Pathfinder. Es donde empieza la historia.',
    areas: [],
  },
  {
    id: 'whisperwake-isles',
    name: 'Whisperwake Isles',
    description:
      'Una isla aislada dentro de Breezy Plains, con las criaturas marinas y con Glameep, la criatura Prismana.',
    areas: ['Bahía de la Luna Nueva', 'Mar del Ocaso'],
  },
]

// Lo que te vas a encontrar por el mapa.
export const POINTS_OF_INTEREST = [
  { name: 'Bloom', description: 'Descubre el mapa de la zona y sirve de punto de viaje rápido.' },
  { name: 'Branch', description: 'Otro punto de viaje rápido: descubre los Blooms de la región y se mejora con ámbar Lumin.' },
  { name: 'RV Park', description: 'Tu caravana: la casa del juego, donde decoras el interior y tienes el huerto.' },
  { name: 'Sanctum', description: 'Repara la vena que esconde dentro y te llevas recompensas, criaturas especiales incluidas.' },
  { name: 'Nurture', description: 'Punto de crianza: invoca muchas criaturas de golpe y cuanto mejor sea la ofrenda, mejor la criatura.' },
  { name: "Morphling's Memory", description: 'Recoge fragmentos de máscara por la región; al completarlos te llevas a Morphling.' },
  { name: 'Outpost', description: 'Consolas de investigación para registrar las criaturas que llevas, más tienda y Hatchinator.' },
  { name: 'Pathfinder Challenge', description: 'Duelos contra NPC a cambio de recompensas.' },
  { name: 'Elite Pathfinder Challenge', description: 'La versión difícil del duelo; suelen estar acampados por la región.' },
  { name: 'Lumin Amber', description: 'Recurso repartido por el mapa (puzles, retos o escondido) que sirve para mejorar los Branch.' },
  { name: 'Lumin Marking', description: 'Puzle de perspectiva: colócate hasta que las piezas formen el símbolo y te llevas ámbar.' },
  { name: 'Lumin Collection', description: 'Recoge todas las energías Lumin antes de que se acabe el tiempo.' },
  { name: 'Vein Abundance', description: 'Zona cargada de energía de vena: invoca muchas criaturas a la vez.' },
  { name: 'Vein Crevice', description: 'Grieta con tanta energía que invoca una criatura legendaria. Entra y plántale cara.' },
  { name: 'Alpha Aniimo', description: 'Jefes de campo. Captúralos con un Aniipod Ultra para llevarte buenas recompensas.' },
  { name: 'Chests', description: 'Cofres con materiales; algunos hay que alcanzarlos usando las habilidades de tus criaturas.' },
]

// Cosas del entorno que ayudan (o estorban) mientras exploras.
export const EXPLORATION_TIPS = [
  { name: 'Glimmer Tree', description: 'Solo en Bosques de Neblina: al activarlo ilumina el camino de la zona.' },
  { name: 'Swamp', description: 'Charcas contaminadas que te dejan lento al atravesarlas. Ojo con las que están escondidas.' },
  { name: 'Peculiar Clouds', description: 'Solo en Campos Nubosos: entra dentro para encontrar tesoros y saltar más alto.' },
  { name: 'Dandelion Tree', description: 'También en Campos Nubosos: usa los dientes de león para subir a la copa, donde suele haber tesoro.' },
  { name: 'Water Lily', description: 'Nenúfares que sirven de plataforma para cruzar un lago, pero se hunden si te quedas quieto.' },
]

// Todas las zonas en las que puede vivir una criatura, en orden de region.
export const ALL_AREAS = REGIONS.flatMap((region) => region.areas)

// De momento el mapa por zonas es solo de Aniimo.
export const hasZones = (gameId) => gameId === 'aniimo'

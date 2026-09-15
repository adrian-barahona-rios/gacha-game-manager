// Conjuntos de equipo (tabla relic_sets): reliquias y ornamentos en Honkai,
// artefactos en Genshin. Cambian las pestanas y como se llama el apartado.
export const RELIC_SECTIONS = {
  'honkai-star-rail': {
    titleKey: 'relics.title',
    menuKey: 'game.menu.relics',
    tabs: [
      { id: 'reliquia', labelKey: 'relics.tab.relics' },
      { id: 'ornamento', labelKey: 'relics.tab.ornaments' },
    ],
  },
  'genshin-impact': {
    titleKey: 'relics.gi.title',
    menuKey: 'game.menu.artifacts',
    tabs: [{ id: 'artefacto', labelKey: 'relics.gi.title' }],
  },
}

export const hasRelics = (gameId) => Boolean(RELIC_SECTIONS[gameId])

// Rotaciones del endgame cargadas en la base de datos.
export const hasEndgameRotations = (gameId) =>
  ['honkai-star-rail', 'genshin-impact', 'zenless-zone-zero'].includes(gameId)

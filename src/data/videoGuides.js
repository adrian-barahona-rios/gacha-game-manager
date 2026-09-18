// Apartado de guias en video: que juegos lo tienen y que busquedas hace en
// YouTube cada pestana.
//
// El texto de la busqueda sale de strings.js, asi que en ingles se buscan
// videos en ingles. Se dejan a proposito muy cortas: con frases largas YouTube
// devuelve videos que no tienen nada que ver con el juego.
//
// recent: false pide los mas relevantes de siempre en vez de los de la ultima
// semana, que es lo que interesa en una guia para empezar.
export const VIDEO_SECTIONS = {
  aniimo: {
    // Va delante de cada busqueda para no mezclar resultados de otros juegos.
    queryPrefix: 'Aniimo',
    categories: [
      { id: 'empezar', labelKey: 'videos.cat.start', queryKey: 'videos.query.start', recent: false },
      { id: 'gameplay', labelKey: 'videos.cat.gameplay', queryKey: 'videos.query.gameplay', recent: true },
      { id: 'criaturas', labelKey: 'videos.cat.creatures', queryKey: 'videos.query.creatures', recent: false },
      { id: 'capturas', labelKey: 'videos.cat.catching', queryKey: 'videos.query.catching', recent: false },
      { id: 'jefes', labelKey: 'videos.cat.bosses', queryKey: 'videos.query.bosses', recent: false },
      { id: 'exploracion', labelKey: 'videos.cat.exploration', queryKey: 'videos.query.exploration', recent: false },
    ],
  },
}

export const hasVideoGuides = (gameId) => Boolean(VIDEO_SECTIONS[gameId])

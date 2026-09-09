// Temas de guias de Umamusume, distintos en cada version del juego.
//
// Los escenarios y su disponibilidad salen de umamusu.wiki (pagina "Scenario"),
// donde la tabla marca con asterisco los que no estan en la version inglesa.
// Van ordenados del mas reciente al mas antiguo: lo que se busca casi siempre
// es el ultimo escenario que ha salido.
//
// Cuando salga un escenario nuevo basta con anadirlo arriba del todo de su
// version y quitar isNew del anterior.

const SCENARIOS = {
  global: [
    'Grand Concert',
    'Trackblazer',
    'Unity Cup',
    'URA Finale',
  ],
  japan: [
    'Tracen Ramen',
    'Beyond Dreams',
    'Paradise Yukoma Hot Springs',
    'Design Your Island',
    'The Twinkle Legends',
    'Engage! Mecha Umamusume',
    'Gourmet Festival',
    'U.A.F. Ready GO!',
    "Project L'Arc",
    'Grand Masters',
  ],
}

// Los dos temas que no dependen del escenario de turno.
const EVERGREEN = [
  {
    id: 'calificaciones',
    kind: 'grades',
    name: { es: 'Mejores calificaciones finales', en: 'Better final grades' },
    query: {
      es: 'Umamusume mejorar calificacion final uma guia',
      en: 'Umamusume better final grade uma guide',
    },
  },
  {
    id: 'gameplays',
    kind: 'gameplay',
    name: { es: 'Gameplays de YouTubers', en: 'YouTuber gameplays' },
    query: { es: 'Umamusume Pretty Derby gameplay español', en: 'Umamusume Pretty Derby gameplay' },
  },
]

const slug = (value) =>
  value
    .normalize('NFD')
    .replace(/\p{Diacritic}/gu, '')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')

function buildTopics(version) {
  const region = version === 'global' ? 'Global' : 'JP'

  const scenarios = SCENARIOS[version].map((name, index) => ({
    id: slug(name),
    kind: 'scenario',
    name: { es: name, en: name },
    isNew: index === 0,
    // El nombre del escenario ya es bastante especifico: se le anade la region
    // para no mezclar guias de la version equivocada.
    query: {
      es: `Umamusume ${name} ${region} guia escenario`,
      en: `Umamusume ${name} ${region} scenario guide`,
    },
  }))

  const evergreen = EVERGREEN.map((topic) => ({
    ...topic,
    query: {
      es: `${topic.query.es} ${region}`,
      en: `${topic.query.en} ${region}`,
    },
  }))

  return [...scenarios, ...evergreen]
}

export const UMAMUSUME_GUIDES = {
  global: buildTopics('global'),
  japan: buildTopics('japan'),
}

export const getUmamusumeTopics = (version) => UMAMUSUME_GUIDES[version] ?? []

export const getUmamusumeTopic = (version, topicId) =>
  getUmamusumeTopics(version).find((topic) => topic.id === topicId)

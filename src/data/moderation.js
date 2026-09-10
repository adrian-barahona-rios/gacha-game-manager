// Moderacion automatica de comentarios, en cuatro idiomas: espanol, ingles,
// frances y portugues.
//
// Criterio de la lista: solo entran terminos que son insulto u odio en
// practicamente cualquier contexto. Se dejan fuera a proposito palabras que
// tienen un uso normal ademas del despectivo, porque bloquearlas rechazaria
// comentarios inofensivos y el usuario no entenderia por que. Ejemplos de lo
// que NO esta y por que:
//
//   negro, moro, gitano   -> colores, gentilicios y palabras corrientes
//   veado, bicha (pt)     -> "ciervo" y "cola/fila"
//   macaco, raton (es/pt) -> animales
//   pede (fr "pédé")      -> al quitar las tildes choca con "ele pede" (pt)
//   pd (fr)               -> choca con la posdata en espanol
//   pedale, tapette (fr)  -> "pedal" y "matamoscas"; solo van con su insulto
//   connard, salope (fr)  -> insultos de barra de bar, como gilipollas
//
// Cuando un termino es ambiguo pero el insulto existe, se incluye la frase
// completa en vez de la palabra suelta ("sale pedale" en lugar de "pedale").
//
// Los terminos se escriben en minusculas, sin tildes y en su grafia natural.
// El texto del usuario se normaliza igual antes de comparar, asi que da lo
// mismo que escriba "MARICÓN", "mar1c0n" o "mariiiicon".
//
// Esta lista es el original: supabase/comments.sql lleva una copia para que la
// base de datos rechace tambien lo que llegue sin pasar por la aplicacion. Si
// tocas una, toca la otra.

// Homofobia y transfobia.
const LGBT_SLURS = [
  // Espanol
  'maricon',
  'maricona',
  'maricones',
  'marikon',
  'mariconazo',
  'mariposon',
  'julandron',
  'bollera',
  'bolleras',
  'tortillera',
  'sarasa',
  'trolo',
  'travelo',
  'sidoso',
  // Ingles
  'fag',
  'fags',
  'faggot',
  'faggots',
  'faggy',
  'tranny',
  'trannies',
  'shemale',
  'dyke',
  'dykes',
  // Frances
  'gouine',
  'gouines',
  'tarlouze',
  'tantouze',
  'sale pedale',
  'grosse pedale',
  'sale tapette',
  'sale pede',
  // Portugues
  'viado',
  'viados',
  'boiola',
  'bichona',
  'traveco',
  'traveca',
  'sapatao',
]

// Racismo y antisemitismo.
const RACIST_SLURS = [
  // Espanol
  'negrata',
  'negratas',
  'sudaca',
  'sudacas',
  'panchito',
  'panchitos',
  'negro de mierda',
  'moro de mierda',
  'judio de mierda',
  'gitano de mierda',
  // Ingles
  'nigger',
  'niggers',
  'nigga',
  'niggas',
  'chink',
  'chinks',
  'gook',
  'spic',
  'spics',
  'wetback',
  'wetbacks',
  'kike',
  'kikes',
  'beaner',
  'beaners',
  'coon',
  'coons',
  'jigaboo',
  'zipperhead',
  'towelhead',
  'raghead',
  'sandnigger',
  'pikey',
  'gyppo',
  // Frances
  'bougnoule',
  'bougnoules',
  'bicot',
  'youpin',
  'youpins',
  'chintok',
  'negresse',
  'sale arabe',
  'sale juif',
  'sale noir',
  'sale negre',
  'sale race',
  'sale bougnoule',
  // Portugues
  'crioulo',
  'macaco de merda',
  'preto de merda',
  'preto imundo',
  'judeu de merda',
  'volta pra senzala',
]

// Xenofobia: desprecio por nacionalidad o por ser inmigrante.
const XENOPHOBIC_SLURS = [
  // Espanol
  'moromierda',
  'putos moros',
  'putos negros',
  'putos gitanos',
  'putos sudamericanos',
  'putos inmigrantes',
  'puto inmigrante',
  'fuera inmigrantes',
  'volved a vuestro pais',
  // Ingles
  'paki',
  'pakis',
  'go back to your country',
  'go back to africa',
  'filthy immigrants',
  // Frances
  'rentre dans ton pays',
  'retourne dans ton pays',
  'dehors les etrangers',
  'la france aux francais',
  // Portugues
  'volta pro teu pais',
  'volta para o teu pais',
  'fora imigrantes',
  'imigrantes de merda',
]

// Odio contra personas con discapacidad.
const ABLEIST_SLURS = [
  // Espanol
  'subnormal',
  'subnormales',
  'mongolico',
  'mongolica',
  'retrasado mental',
  // Ingles
  'retard',
  'retards',
  'retarded',
  'mongoloid',
  // Frances
  'attarde mental',
  'sale mongol',
  // Portugues
  'retardado mental',
  'mongoloide',
]

// Violencia verbal: amenazas e incitacion al suicidio.
const VIOLENT_THREATS = [
  // Espanol
  'te voy a matar',
  'os voy a matar',
  'te voy a reventar',
  'te voy a rajar',
  'te voy a quemar',
  'ojala te mueras',
  'ojala te maten',
  'muerete',
  'matate',
  'suicidate',
  'cuelgate',
  'tirate por la ventana',
  // Ingles
  'kill yourself',
  'kys',
  'go kill yourself',
  'i will kill you',
  'im going to kill you',
  'i am going to kill you',
  'hang yourself',
  'neck yourself',
  'go die',
  'you should die',
  // Frances
  'je vais te tuer',
  'je vais te crever',
  'va crever',
  'creve toi',
  'tue toi',
  'suicide toi',
  'pends toi',
  'jespere que tu vas mourir',
  // Portugues
  'vou te matar',
  'vou matar te',
  'vai se matar',
  'mata te',
  'suicida te',
  'enforca te',
  'morre logo',
  'espero que morras',
]

// Delitos de odio: apologia y deshumanizacion.
const HATE_CRIME = [
  // Espanol
  'hitler tenia razon',
  'a la camara de gas',
  'camara de gas para',
  'muerte a los judios',
  'muerte a los moros',
  'muerte a los negros',
  'a colgarlos a todos',
  // Ingles
  'heil hitler',
  'sieg heil',
  'hitler was right',
  'gas the jews',
  'gas them all',
  'white power',
  'death to jews',
  'death to muslims',
  'lynch them',
  // Frances
  'mort aux juifs',
  'mort aux arabes',
  'mort aux noirs',
  'chambre a gaz pour',
  'les juifs au four',
  'la france aux blancs',
  // Portugues
  'morte aos judeus',
  'morte aos negros',
  'hitler tinha razao',
  'camara de gas para eles',
]

// Insultos graves contra la persona. Los "de barra de bar" (tonto, idiota,
// cabron, connard, otario) se quedan fuera: el objetivo es frenar el odio, no
// censurar una discusion acalorada.
const SEVERE_INSULTS = [
  // Espanol
  'hijo de puta',
  'hija de puta',
  'hijos de puta',
  'hijas de puta',
  'hijoputa',
  'hijaputa',
  'malnacido',
  'malparido',
  'me cago en tus muertos',
  // Ingles
  'son of a bitch',
  'motherfucker',
  'cunt',
  // Frances
  'fils de pute',
  'fille de pute',
  'encule',
  'enculee',
  'encules',
  'nique ta mere',
  'nique ta race',
  'salopard',
  // Portugues
  'filho da puta',
  'filha da puta',
  'filhos da puta',
  'fdp',
  'vai tomar no cu',
  'puta que te pariu',
]

export const BLOCKED_TERMS = [
  ...LGBT_SLURS,
  ...RACIST_SLURS,
  ...XENOPHOBIC_SLURS,
  ...ABLEIST_SLURS,
  ...VIOLENT_THREATS,
  ...HATE_CRIME,
  ...SEVERE_INSULTS,
]

// Deja el texto en minusculas, sin tildes, sin adornos y con los trucos
// habituales para esquivar filtros ya deshechos.
export function normalizeForModeration(text) {
  return (
    String(text ?? '')
      .toLowerCase()
      .normalize('NFD')
      .replace(/\p{Diacritic}/gu, '')
      // Sustituciones de tipo "l33t": n1gg3r, mar1c0n, fuck$.
      .replace(/[013457]|[@$]/g, (char) => {
        const map = { 0: 'o', 1: 'i', 3: 'e', 4: 'a', 5: 's', 7: 't', '@': 'a', $: 's' }
        return map[char] ?? char
      })
      // Cualquier separador (signos, emojis, saltos de linea) pasa a espacio.
      .replace(/[^a-z0-9]+/g, ' ')
      // Y las letras sueltas seguidas se vuelven a juntar, para que
      // "m.a.r.i.c.o.n" no cuele partido en siete palabras de una letra.
      .replace(/\b(?:[a-z0-9] )+[a-z0-9]\b/g, (run) => run.replace(/ /g, ''))
      // Letras estiradas: solo se recortan las repeticiones de tres o mas, para
      // no convertir "Niger" en la version con dos ges.
      .replace(/(.)\1{2,}/g, '$1')
      .trim()
  )
}

// Devuelve el termino que ha hecho saltar el filtro, o null si el texto pasa.
// Compara con espacios alrededor para que solo cuenten palabras completas:
// "escasez" no debe saltar por contener "casa".
export function findBlockedTerm(text) {
  const haystack = ` ${normalizeForModeration(text).replace(/\s+/g, ' ')} `
  return BLOCKED_TERMS.find((term) => haystack.includes(` ${term} `)) ?? null
}

export function isOffensive(text) {
  return findBlockedTerm(text) !== null
}

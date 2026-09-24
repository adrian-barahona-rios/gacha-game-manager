// Tabla de tipos de Aniimo: los nueve elementos y lo que hace cada uno contra
// los demas.
//
// El juego usa un solo multiplicador: x1.6 cuando el elemento es fuerte contra
// el otro, x0.625 cuando es debil y x1 en el resto. No hay inmunidades ni
// valores intermedios.
//
// Fuente: la tabla publicada en aniimogame.net/type-chart. La wiki oficial no
// publica la suya, asi que esto es informacion de la comunidad: cuadra con lo
// que cuentan las guias de combate, pero alguna casilla puede cambiar.

// Orden oficial de los elementos, con el nombre que usa la wiki en espanol.
export const ELEMENTS = [
  { en: 'Fire', es: 'Fuego' },
  { en: 'Water', es: 'Agua' },
  { en: 'Grass', es: 'Hierba' },
  { en: 'Electric', es: 'Eléctrico' },
  { en: 'Ice', es: 'Hielo' },
  { en: 'Rock', es: 'Roca' },
  { en: 'Wind', es: 'Viento' },
  { en: 'Dark', es: 'Oscuridad' },
  { en: 'Holy', es: 'Sagrado' },
]

export const STRONG = 1.6
export const WEAK = 0.625

// Cada fila es el elemento que ataca y cada columna el que se defiende, en el
// orden de ELEMENTS.
export const MATRIX = [
  [WEAK, WEAK, STRONG, 1, STRONG, WEAK, 1, 1, WEAK],
  [STRONG, WEAK, WEAK, 1, WEAK, STRONG, 1, 1, WEAK],
  [WEAK, STRONG, WEAK, 1, 1, STRONG, 1, 1, WEAK],
  [1, STRONG, 1, WEAK, WEAK, WEAK, STRONG, 1, 1],
  [WEAK, STRONG, 1, STRONG, WEAK, WEAK, WEAK, 1, 1],
  [1, WEAK, WEAK, STRONG, STRONG, WEAK, 1, WEAK, 1],
  [1, 1, STRONG, WEAK, 1, 1, WEAK, STRONG, 1],
  [STRONG, WEAK, STRONG, 1, 1, 1, WEAK, 1, STRONG],
  [1, 1, 1, WEAK, 1, 1, STRONG, STRONG, WEAK],
]

const indiceDe = (nombre) => ELEMENTS.findIndex((e) => e.es === nombre || e.en === nombre)

// Multiplicador de dano de un elemento contra otro (1 si alguno no existe).
export function multiplierOf(atacante, defensor) {
  const fila = indiceDe(atacante)
  const columna = indiceDe(defensor)
  if (fila < 0 || columna < 0) return 1
  return MATRIX[fila][columna]
}

// Los cuatro listados de un elemento: contra quien pega fuerte, contra quien
// se queda corto, quien le pega fuerte a el y quien le hace poco.
export function matchupsOf(nombre) {
  const indice = indiceDe(nombre)
  if (indice < 0) return { strongAgainst: [], weakAgainst: [], vulnerableTo: [], resistantTo: [] }

  const nombres = (prueba) => ELEMENTS.filter((_, i) => prueba(i)).map((e) => e.es)
  return {
    strongAgainst: nombres((i) => MATRIX[indice][i] === STRONG),
    weakAgainst: nombres((i) => MATRIX[indice][i] === WEAK),
    vulnerableTo: nombres((i) => MATRIX[i][indice] === STRONG),
    resistantTo: nombres((i) => MATRIX[i][indice] === WEAK),
  }
}

// De momento la tabla de tipos es solo de Aniimo.
export const hasTypeChart = (gameId) => gameId === 'aniimo'

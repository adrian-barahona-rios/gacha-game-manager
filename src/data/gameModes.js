// Modos de contenido de endgame de cada juego, para la seccion de guias del
// juego (distinta de la guia de cada personaje).
//
// Los nombres en espanol son los oficiales, comprobados en las wikis en
// espanol de cada juego. Los modos de Zenless se quedan en ingles porque su
// wiki en espanol esta practicamente vacia y no hay traduccion que verificar.

export const GAME_MODES = {
  'genshin-impact': [
    {
      id: 'spiral-abyss',
      name: 'Spiral Abyss',
      nameEs: 'Espiral del Abismo',
      points: {
        es: [
          'Modo rotativo, normalmente de 9 cámaras.',
          'Desafíos con buffs y debuffs que cambian cada temporada.',
          'Recompensas cada 2 semanas.',
        ],
        en: [
          'Rotating mode, usually 9 chambers.',
          'Challenges with buffs and debuffs that change each season.',
          'Rewards every 2 weeks.',
        ],
      },
    },
    {
      id: 'imaginarium-theater',
      name: 'Imaginarium Theater',
      nameEs: 'Teatro Fantasía',
      points: {
        es: [
          'Pone a prueba tu plantilla: necesitas muchos personajes distintos.',
          'Puedes tomar prestados personajes de tus amigos.',
          'Recompensas mensuales.',
        ],
        en: [
          'A roster check: you need a lot of different characters.',
          'You can borrow characters from your friends.',
          'Monthly rewards.',
        ],
      },
    },
    {
      id: 'stygian-onslaught',
      name: 'Stygian Onslaught',
      nameEs: 'Conflagración estigia',
      isNew: true,
      since: '2025',
      points: {
        es: [
          'Boss rush: 3 jefes seguidos.',
          '6 niveles de dificultad, de Normal a Dire.',
          'Muy difícil: pensado para cuentas muy invertidas.',
          'Recompensas: aspectos de armas y artefactos.',
        ],
        en: [
          'Boss rush: 3 bosses in a row.',
          '6 difficulty levels, from Normal to Dire.',
          'Very hard: meant for heavily invested accounts.',
          'Rewards: weapon skins and artifacts.',
        ],
      },
    },
  ],

  'honkai-star-rail': [
    {
      id: 'memory-of-chaos',
      name: 'Memory of Chaos',
      points: {
        es: [
          '3 etapas, cada una con su objetivo.',
          'Hay que ganar dentro de un número limitado de ciclos.',
          'El modo clásico.',
        ],
        en: [
          '3 stages, each with its own objective.',
          'You have to win within a limited number of cycles.',
          'The classic mode.',
        ],
      },
    },
    {
      id: 'pure-fiction',
      name: 'Pure Fiction',
      nameEs: 'Pura ficción',
      points: {
        es: [
          'Derrota al máximo de enemigos posible en 4 ciclos.',
          'Sistema de puntos.',
          'Parecido al Memory of Chaos, pero con otra mecánica.',
        ],
        en: [
          'Defeat as many enemies as possible in 4 cycles.',
          'Point-based scoring.',
          'Similar to Memory of Chaos, but with a different mechanic.',
        ],
      },
    },
    {
      id: 'apocalyptic-shadow',
      name: 'Apocalyptic Shadow',
      nameEs: 'Espejismo apocalíptico',
      since: '2.3',
      points: {
        es: [
          '4 dificultades crecientes.',
          'Combates contra jefes que van a más.',
          'Añadido en la versión 2.3.',
        ],
        en: [
          '4 increasing difficulties.',
          'Progressively harder boss fights.',
          'Added in version 2.3.',
        ],
      },
    },
    {
      id: 'anomaly-arbitration',
      name: 'Anomaly Arbitration',
      nameEs: 'Arbitraje atípico',
      isNew: true,
      since: '3.6',
      points: {
        es: [
          'Dificultad extrema, para jugadores veteranos.',
          'Necesitas 3 equipos distintos, sin repetir personajes entre ellos.',
          'La etapa final admite cualquier equipo.',
          'Recompensas cosméticas exclusivas.',
        ],
        en: [
          'Extreme difficulty, for experienced players.',
          'You need 3 different teams, with no characters shared between them.',
          'The final stage accepts any team.',
          'Exclusive cosmetic rewards.',
        ],
      },
    },
  ],

  'zenless-zone-zero': [
    {
      id: 'shiyu-defense',
      name: 'Shiyu Defense',
      points: {
        es: [
          'Oleadas de enemigos con límite de tiempo.',
          'El equivalente al Memory of Chaos de Honkai.',
          'Rotativo.',
        ],
        en: [
          'Waves of enemies against the clock.',
          "Zenless's equivalent of Honkai's Memory of Chaos.",
          'Rotating.',
        ],
      },
    },
    {
      id: 'deadly-assault',
      name: 'Deadly Assault',
      points: {
        es: [
          '3 combates contra jefes seguidos.',
          'El equivalente a la Conflagración estigia de Genshin.',
          'Dificultades Menacing y Fearless.',
        ],
        en: [
          '3 boss fights in a row.',
          "Zenless's equivalent of Genshin's Stygian Onslaught.",
          'Menacing and Fearless difficulties.',
        ],
      },
    },
    {
      id: 'hollow-zero',
      name: 'Hollow Zero',
      points: {
        es: [
          'Exploración con dificultad gradual.',
          'Da acceso gratis a agentes nuevos.',
          'El más asequible de todos.',
        ],
        en: [
          'Exploration with gradually rising difficulty.',
          'Gives free access to new agents.',
          'The most casual of them all.',
        ],
      },
    },
    {
      id: 'simulated-battle-trial',
      name: 'Simulated Battle Trial',
      points: {
        es: ['Pruebas de batalla simuladas.'],
        en: ['Simulated battle trials.'],
      },
    },
    {
      id: 'endless-tower',
      name: 'Endless Tower',
      points: {
        es: ['Torre sin fin, con la dificultad subiendo piso a piso.'],
        en: ['An endless tower, with difficulty rising floor by floor.'],
      },
    },
    {
      id: 'annihilation-simulacrum',
      name: 'Annihilation Simulacrum + Norma',
      isNew: true,
      points: {
        es: ['Contenido de endgame añadido recientemente.'],
        en: ['Endgame content added recently.'],
      },
    },
  ],
}

export const getGameModes = (gameId) => GAME_MODES[gameId] ?? []

export const getGameMode = (gameId, modeId) =>
  getGameModes(gameId).find((mode) => mode.id === modeId)

// En espanol se usa el nombre oficial traducido cuando existe.
export const getModeName = (mode, language) =>
  (language === 'es' && mode.nameEs) || mode.name

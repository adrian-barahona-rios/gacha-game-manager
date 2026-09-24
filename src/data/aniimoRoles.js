// Los cinco roles de Aniimo. Son los que usa la wiki oficial en la ficha de
// cada criatura (y los mismos que aparecen en las composiciones de Game8), asi
// que el valor de "role" en la base de datos es exactamente uno de estos.
//
// El texto de cada rol esta en strings.js para que cambie con el idioma.
export const ROLES = [
  {
    id: 'dps',
    // Valor tal cual esta guardado en characters.role.
    value: 'DPS',
    icon: 'Swords',
    chip: 'bg-rose-500/15 text-rose-200 ring-rose-400/30',
    // Cuantos conviene llevar en un equipo de cuatro.
    team: { min: 1, max: 2 },
  },
  {
    id: 'break',
    value: 'Ruptura',
    icon: 'Hammer',
    chip: 'bg-amber-500/15 text-amber-200 ring-amber-400/30',
    team: { min: 1, max: 2 },
  },
  {
    id: 'support',
    value: 'Apoyo',
    icon: 'Sparkles',
    chip: 'bg-violet-500/15 text-violet-200 ring-violet-400/30',
    team: { min: 0, max: 1 },
  },
  {
    id: 'heal',
    value: 'Curación',
    icon: 'HeartPulse',
    chip: 'bg-emerald-500/15 text-emerald-200 ring-emerald-400/30',
    team: { min: 1, max: 1 },
  },
  {
    id: 'regen',
    value: 'Regeneración',
    icon: 'BatteryCharging',
    chip: 'bg-sky-500/15 text-sky-200 ring-sky-400/30',
    team: { min: 0, max: 1 },
  },
]

export const roleByValue = (value) => ROLES.find((r) => r.value === value) ?? null

// De momento la guia de roles y los equipos meta son solo de Aniimo.
export const hasRolesGuide = (gameId) => gameId === 'aniimo'
export const hasMetaTeams = (gameId) => gameId === 'aniimo'

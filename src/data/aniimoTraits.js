// Rasgos (pasivas) de Aniimo: como se agrupan y como se lee la sinergia de un
// equipo.
//
// Los tipos salen de la propia descripcion del rasgo (lo hace el generador del
// SQL), asi que aqui solo estan el orden y el color de cada uno.
export const EFFECT_TYPES = [
  { id: 'equipo', chip: 'bg-emerald-500/15 text-emerald-200 ring-emerald-400/30' },
  { id: 'familia', chip: 'bg-violet-500/15 text-violet-200 ring-violet-400/30' },
  { id: 'cambio', chip: 'bg-sky-500/15 text-sky-200 ring-sky-400/30' },
  { id: 'sostenimiento', chip: 'bg-teal-500/15 text-teal-200 ring-teal-400/30' },
  { id: 'penalizacion', chip: 'bg-fuchsia-500/15 text-fuchsia-200 ring-fuchsia-400/30' },
  { id: 'ruptura', chip: 'bg-amber-500/15 text-amber-200 ring-amber-400/30' },
  { id: 'recursos', chip: 'bg-blue-500/15 text-blue-200 ring-blue-400/30' },
  { id: 'critico', chip: 'bg-rose-500/15 text-rose-200 ring-rose-400/30' },
  { id: 'elemento', chip: 'bg-orange-500/15 text-orange-200 ring-orange-400/30' },
  { id: 'acumulacion', chip: 'bg-lime-500/15 text-lime-200 ring-lime-400/30' },
  { id: 'movilidad', chip: 'bg-cyan-500/15 text-cyan-200 ring-cyan-400/30' },
  { id: 'otro', chip: 'bg-white/10 text-zinc-300 ring-white/20' },
]

export const effectStyle = (id) => EFFECT_TYPES.find((t) => t.id === id)?.chip ?? 'bg-white/10 text-zinc-300 ring-white/20'

// De momento el catalogo de rasgos y el creador de equipos son solo de Aniimo.
export const hasTraits = (gameId) => gameId === 'aniimo'

import { FAMILIES } from './aniimoFamilies'

// La raiz con la que cada elemento aparece escrito en los rasgos: asi se
// reconoce tanto "oscuridad" como "ataques oscuros".
const RAICES_ELEMENTO = {
  Agua: 'agua',
  Fuego: 'fuego',
  Hielo: 'hielo',
  Viento: 'viento',
  Roca: 'roca',
  Hierba: 'hierba',
  Oscuridad: 'oscur',
  Sagrado: 'sagrad',
  Eléctrico: 'léctric',
}

// Que aporta cada criatura del equipo. Devuelve una lista de hallazgos, cada
// uno con el porque, para poder ensenarlos tal cual.
function sinergiasDeRasgos(miembros, rasgoDe) {
  const hallazgos = []

  for (const criatura of miembros) {
    const rasgo = rasgoDe(criatura)
    if (!rasgo) continue

    // Rasgos que dicen expresamente que afectan al equipo.
    if (rasgo.effect_type === 'equipo') {
      hallazgos.push({ tipo: 'equipo', criatura, rasgo })
    }

    // Rasgos que piden un familiar: solo cuenta si ese familiar esta dentro.
    if (rasgo.effect_type === 'familia' || (rasgo.tags ?? []).includes('familia')) {
      const texto = `${rasgo.description_es ?? ''} ${rasgo.description_en ?? ''}`.toLowerCase()
      // La familia que pide el rasgo se busca por su nombre dentro del texto.
      const familia = FAMILIES.find((f) => texto.includes(f.name.toLowerCase()))
      if (familia) {
        const acompanantes = miembros.filter(
          (otro) => otro.id !== criatura.id && familia.members.includes(otro.name),
        )
        hallazgos.push({
          tipo: acompanantes.length ? 'familia' : 'familiaSinCumplir',
          criatura,
          rasgo,
          familia: familia.name,
          acompanantes,
        })
      }
    }

    // Rasgos que se activan al cambiar de criatura o al entrar en combate.
    if (rasgo.effect_type === 'cambio') {
      hallazgos.push({ tipo: 'cambio', criatura, rasgo })
    }

    // Rasgos que nombran un elemento (le bajan la resistencia o suben su
    // dano): cuentan cuando hay mas criaturas de ese elemento en el equipo.
    const texto = (rasgo.description_es ?? '').toLowerCase()
    for (const [elemento, raiz] of Object.entries(RAICES_ELEMENTO)) {
      if (!texto.includes(raiz)) continue
      const acompanantes = miembros.filter((otro) => otro.id !== criatura.id && otro.element === elemento)
      if (acompanantes.length > 0) {
        hallazgos.push({ tipo: 'elemento', criatura, rasgo, elemento, acompanantes })
      }
    }
  }

  return hallazgos
}

// Nota de 0 a 100, repartida en tres partes que se ensenan por separado.
// No hay numeros magicos: cada punto viene de una regla que se explica.
export function analizarEquipo(miembros, rasgoDe, matchupsOf) {
  const roles = miembros.map((c) => c.role)
  const cuenta = (valor) => roles.filter((r) => r === valor).length
  const avisos = []

  // --- Reparto de roles (40 puntos) ---
  let roleBalance = 0
  const conCura = cuenta('Curación') + cuenta('Regeneración')
  const dps = cuenta('DPS')
  const ruptura = cuenta('Ruptura')

  if (conCura >= 1) roleBalance += 15
  else avisos.push({ nivel: 'alto', clave: 'noHeal' })

  if (ruptura >= 1) roleBalance += 15
  else avisos.push({ nivel: 'alto', clave: 'noBreak' })

  if (dps >= 1) roleBalance += 10
  else avisos.push({ nivel: 'medio', clave: 'noDps' })

  if (dps > 2) avisos.push({ nivel: 'medio', clave: 'tooManyDps' })
  if (new Set(roles).size === 1 && miembros.length > 1) avisos.push({ nivel: 'alto', clave: 'sameRole' })

  // --- Cobertura de elementos (30 puntos) ---
  const elementos = [...new Set(miembros.map((c) => c.element).filter(Boolean))]
  const amenazados = new Set()
  for (const elemento of elementos) {
    for (const otro of matchupsOf(elemento).strongAgainst) amenazados.add(otro)
  }
  // Nueve elementos en el juego: la cobertura es cuantos de ellos amenaza el
  // equipo con ventaja.
  const elementCoverage = Math.round((amenazados.size / 9) * 30)
  if (elementos.length === 1 && miembros.length > 1) avisos.push({ nivel: 'medio', clave: 'sameElement' })

  // --- Sinergia de rasgos (30 puntos) ---
  const hallazgos = sinergiasDeRasgos(miembros, rasgoDe)
  const buenos = hallazgos.filter((h) => h.tipo !== 'familiaSinCumplir')
  const traitSynergy = Math.min(30, buenos.length * 10)
  if (buenos.length === 0 && miembros.length === 4) avisos.push({ nivel: 'bajo', clave: 'noSynergy' })

  return {
    score: roleBalance + elementCoverage + traitSynergy,
    roleBalance,
    elementCoverage,
    traitSynergy,
    amenazados: [...amenazados],
    elementos,
    hallazgos,
    avisos,
    roles: { dps, ruptura, apoyo: cuenta('Apoyo'), cura: cuenta('Curación'), regen: cuenta('Regeneración') },
  }
}

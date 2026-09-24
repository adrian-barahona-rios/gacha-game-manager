// Familias de Aniimo: cada arbol de evolucion de la wiki oficial es una
// familia, y la criatura de la que sale le da nombre. Se usa para saber si un
// rasgo que pide "un miembro de la familia X" se cumple en el equipo.
//
// Generado a partir de los datos de la wiki oficial; no tocar a mano.
export const FAMILIES = [
  { name: 'Baleetle', members: ['Baleetle', 'Waleetle', 'Bouldus'] },
  { name: 'Bolty', members: ['Bolty', 'Blazen'] },
  { name: 'Bonesky', members: ['Bonesky', 'Fenrier', 'Glynsera'] },
  { name: 'Budclaw', members: ['Budclaw', 'Geoclaw', 'Shrubclaw'] },
  { name: 'Budsquire', members: ['Budsquire', 'Thornblade', 'Melloblum'] },
  { name: 'Bulbly', members: ['Bulbly', 'Veilfloat', 'Luminelle'] },
  { name: 'Celestis', members: ['Celestis', 'Stellarys'] },
  { name: 'Chirpi', members: ['Chirpi', 'Tromber', 'Cornet', 'Tubster'] },
  { name: 'Cozite', members: ['Cozite', 'Bailite'] },
  { name: 'Cubbo', members: ['Cubbo', 'Grizbo'] },
  { name: 'Dewy', members: ['Dewy', 'Fragrancier'] },
  { name: 'Eko', members: ['Eko', 'Eklue'] },
  { name: 'Emberpup', members: ['Emberpup', 'Flameruff', 'Scorchhowl', 'Inferlupa'] },
  { name: 'Fahloo', members: ['Fahloo', 'Erlath'] },
  { name: 'Fentuft', members: ['Fentuft', 'Fenmane'] },
  { name: 'Flutternym', members: ['Flutternym', 'Gracewing'] },
  { name: 'Helmut', members: ['Helmut', 'Pawney', 'Rookey'] },
  { name: 'Helmwhelp', members: ['Helmwhelp', 'Helgon', 'Infergon'] },
  { name: 'Hummin', members: ['Hummin', 'Hexxin', 'Tuckin'] },
  { name: 'Iris', members: ['Iris', 'Irisal'] },
  { name: 'Nimbi', members: ['Nimbi', 'Dreaple', 'Turbo'] },
  { name: 'Pebbling', members: ['Pebbling', 'Lavazar', 'Magmarex', 'Geodeback', 'Minespine'] },
  { name: 'Pomegg', members: ['Pomegg', 'Dazmand', 'Pomawk'] },
  { name: 'Shelly', members: ['Shelly', 'Sheldon', 'Sherro'] },
  { name: 'Skippy', members: ['Skippy', 'Pranky', 'Glacy', 'Leafy'] },
  { name: 'Sparki', members: ['Sparki', 'Flamerion'] },
  { name: 'Squarrel', members: ['Squarrel', 'Squashel'] },
  { name: 'Susuta', members: ['Susuta', 'Popota', 'Panpanta', 'Piopiota'] },
  { name: 'Wisptis', members: ['Wisptis', 'Fulmintis', 'Ignitis'] },
]

// La familia a la que pertenece una criatura, por su nombre.
export const familyOf = (name) => FAMILIES.find((f) => f.members.includes(name)) ?? null

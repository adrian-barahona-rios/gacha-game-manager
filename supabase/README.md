# Base de datos (Supabase)

Todo lo que necesita la base de datos de la app, en 19 archivos. Se ejecutan en
**Supabase → SQL Editor → New query → Run**, en orden:

| Archivo | Qué hace |
|---|---|
| `01_esquema.sql` | Toda la estructura: tablas, columnas, índices, permisos (RLS), funciones y triggers. Va siempre el primero. |
| `02_personajes_genshin.sql` | Los 119 personajes de Genshin, cada uno con datos, icono, biografía y materiales de ascensión. |
| `03_personajes_hsr.sql` | Los 92 personajes de Honkai: Star Rail. |
| `04_personajes_zzz.sql` | Los 60 agentes de Zenless Zone Zero. |
| `05_personajes_dxd.sql` | Los 22 personajes de High School DxD: OPI. |
| `06_armas_genshin_1.sql` … `_4.sql` | Las 246 armas de Genshin, con los personajes recomendados. Van en 4 partes porque el archivo entero no cabe en el SQL Editor. |
| `07_conos_hsr.sql` | Los 169 conos de luz de Honkai. |
| `08_amplificadores_zzz.sql` | Los 99 amplificadores de Zenless. |
| `09_discos_zzz.sql` | Los 30 conjuntos de pistas de disco de Zenless. |
| `10_tier_lists.sql` | Las tier lists oficiales. Necesita los personajes (02 a 04). |
| `11_umamusume.sql` | Umamusume: versiones, entrenadoras y cartas de apoyo. |
| `12_enemigos_hsr_1.sql` … `_3.sql` | Los 375 enemigos de Honkai: Star Rail (jefes, élites y esbirros), con debilidades, resistencias, habilidades e imagen. Van en 3 partes por el mismo motivo. |
| `13_reliquias_hsr.sql` | Los 60 conjuntos de reliquias y ornamentos planares de Honkai, con sus efectos y dónde se consiguen. |
| `14_builds_hsr.sql` | La build recomendada de cada personaje de Honkai: conos, reliquias, ornamentos y stats. Necesita 03, 07 y 13. |
| `15_endgame_hsr.sql` | La rotación actual de Memory of Chaos, Pura ficción, Espejismo apocalíptico y Arbitraje atípico, con sus enemigos y efectos. Necesita 12. Hay que regenerarlo cuando cambie la rotación. |
| `16_enemigos_genshin_1.sql` … `_4.sql` | Los 569 enemigos de Genshin (jefes, élites, esbirros y fauna), con resistencias, botín, consejos de combate e imagen. |
| `17_artefactos_genshin.sql` | Los 63 conjuntos de artefactos de Genshin, con efectos, piezas y dónde se consiguen. |
| `18_builds_genshin.sql` | La build recomendada de los 119 personajes de Genshin (guías de Game8). Necesita 02, 06 y 17. |
| `19_endgame_genshin.sql` | La rotación actual de la Espiral del Abismo, el Teatro Fantasía y la Conflagración estigia. Necesita 16. Hay que regenerarlo cuando cambie la rotación. |

## Cómo funcionan

- **Se pueden repetir.** Ejecutar un archivo dos veces no duplica nada: el
  esquema usa `if not exists` y los datos insertan lo que falte y actualizan lo
  que ya exista.
- **Los datos no borran nada.** Los favoritos, tier lists y guías de los
  usuarios que apuntan a un personaje o arma se conservan.
- **Los datos son una copia.** Salen de la base de datos real tal y como estaba
  el día que se generaron. Si después cambias algo desde la app (por ejemplo
  una biografía o una tier list desde /admin) y vuelves a ejecutar el archivo,
  ese cambio se pierde.

## Montar una base de datos nueva

Ejecuta los 19 en orden y ya está. Después, para tener un administrador:
regístrate en la app y cambia tu fila en **Table Editor → profiles**, poniendo
`role` a `admin`.

## Añadir cosas más adelante

Cuando haya personajes o armas nuevas, lo más limpio es regenerar el archivo de
datos de ese catálogo en vez de crear archivos sueltos que lo continúen.

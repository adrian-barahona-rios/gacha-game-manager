-- Ejecutar en Supabase -> SQL Editor -> New query -> Run.
-- Requiere 01_esquema.sql (endgame_rotations con la columna extra), los
-- 16_enemigos_genshin_*.sql y 02_personajes_genshin.sql.
--
-- Rotaciones del endgame de Genshin Impact: la actual de cada modo y la
-- siguiente cuando ya se conoce.
--   Espiral del Abismo: planta 12 de la fase que acaba el 16 de septiembre y la
--     bendicion de la siguiente (sus enemigos aun no se han publicado).
--   Teatro Fantasia: temporada 27 (septiembre), con elementos, personajes
--     iniciales, invitados y los jefes de cada dificultad.
--   Conflagracion estigia: ciclo de la 7.0 y fechas del de la 7.1.
--
-- Fuente: las guias de Game8. Los datos extraidos del juego aun no traen estas
-- temporadas, asi que los efectos estan traducidos del ingles (no son los
-- textos oficiales del juego). Los enemigos que no estan en el archivo del
-- juego se guardan solo con su nombre.
--
-- Inserta lo que falte y actualiza lo que ya exista. Cuando cambie la rotacion
-- hay que volver a generar este archivo.
--
-- Generado el 2026-09-15.

insert into public.endgame_rotations (
  id, game_id, mode, name, status, begins_on, ends_on, effects, floors, extra
)
values
  ('gi-abyss-2026-08', 'genshin-impact', 'spiral-abyss', 'Luna Abisal «Ice-Surging Moon» · Planta 12', 'actual', '2026-08-16', '2026-09-16', '[{"nombre":"Bendición de la Luna Abisal","descripcion":"Mientras el personaje en uso está dentro de un campo de Estrella Polar, al infligir daño a un enemigo su ataque libera una onda expansiva en la posición del enemigo que inflige daño verdadero. Puede activarse una vez cada 4 s.","tipo":"general"},{"nombre":"Nivel de los enemigos","descripcion":"Nivel 95 – 100.","tipo":"general"}]'::jsonb, '[{"piso":1,"nombre":"Sala 12-1","mitades":[{"elementos":["Electro","Cryo"],"oleadas":[["gi-enemy-24020401","gi-enemy-24020101"],["gi-enemy-24021101"]],"efectos":[{"nombre":"Trastorno de las líneas ley","descripcion":"El daño de Superconductor aumenta en un 200% y el de Superconductor Estelar en un 75%.","tipo":"general"}]},{"elementos":["Pyro"],"oleadas":[["gi-enemy-24069201","gi-enemy-24070301"]],"efectos":[{"nombre":"Trastorno de las líneas ley","descripcion":"El Daño Pyro de los Ataques Normales aumenta en un 75%.","tipo":"general"}]}]},{"piso":2,"nombre":"Sala 12-2","mitades":[{"elementos":["Electro","Cryo"],"oleadas":[["gi-enemy-26310401"],["gi-enemy-26310501"]],"efectos":[{"nombre":"Trastorno de las líneas ley","descripcion":"El daño de Superconductor aumenta en un 200% y el de Superconductor Estelar en un 75%.","tipo":"general"}]},{"elementos":["Pyro"],"oleadas":[["gi-enemy-22010201"],["gi-enemy-22100501"]],"efectos":[{"nombre":"Trastorno de las líneas ley","descripcion":"El Daño Pyro de los Ataques Normales aumenta en un 75%.","tipo":"general"}]}]},{"piso":3,"nombre":"Sala 12-3","mitades":[{"elementos":["Electro","Cryo"],"oleadas":[["nombre:Furiosa"]],"efectos":[{"nombre":"Trastorno de las líneas ley","descripcion":"El daño de Superconductor aumenta en un 200% y el de Superconductor Estelar en un 75%.","tipo":"general"}]},{"elementos":["Pyro"],"oleadas":[["gi-enemy-24090101","gi-enemy-26220301"]],"efectos":[{"nombre":"Trastorno de las líneas ley","descripcion":"El Daño Pyro de los Ataques Normales aumenta en un 75%.","tipo":"general"}]}]}]'::jsonb, '{"equipos":[{"nombre":"Primera mitad (Superconductor Estelar)","personajes":["gi-sandrone","gi-nicole","gi-odette","gi-yae-miko"]},{"nombre":"Primera mitad","personajes":["gi-cyno","gi-alyosha","gi-qiqi","gi-beidou"]},{"nombre":"Primera mitad","personajes":["gi-wriothesley","gi-nicole","gi-odette","gi-yae-miko"]},{"nombre":"Segunda mitad (Pyro)","personajes":["gi-arlecchino","gi-columbina","gi-ineffa","gi-jahoda"]},{"nombre":"Segunda mitad","personajes":["gi-mavuika","gi-iansan","gi-citlali","gi-xilonen"]},{"nombre":"Segunda mitad","personajes":["gi-gaming","gi-xianyun","gi-iansan","gi-furina"]}]}'::jsonb),
  ('gi-abyss-2026-09', 'genshin-impact', 'spiral-abyss', 'Luna Abisal «Converging Moon»', 'proxima', '2026-09-16', null, '[{"nombre":"Bendición de la Luna Abisal","descripcion":"Tras golpear a un enemigo con un Ataque Cargado, el personaje obtiene un 20% de Bono de Daño del tipo elemental (o Físico) de ese Ataque Cargado durante 5 s. Puede activarse una vez cada 0,5 s y acumularse hasta 3 veces; los bonos de cada tipo de daño se cuentan por separado.","tipo":"general"}]'::jsonb, '[]'::jsonb, null),
  ('gi-theater-27', 'genshin-impact', 'imaginarium-theater', 'Temporada 27', 'actual', '2026-09-01', '2026-09-30', '[{"nombre":"Bendición fantástica","descripcion":"Cuando los personajes iniciales de la temporada se unen al equipo, su Vida Máx., ATQ y DEF aumentan en un 20% (también fuera del teatro).","tipo":"general"}]'::jsonb, '[{"piso":1,"nombre":"Modo Fácil","mitades":[{"nombre":"Acto 3 · nivel 80","elementos":[],"oleadas":[["gi-enemy-26110101"]]}]},{"piso":2,"nombre":"Modo Normal","mitades":[{"nombre":"Acto 3 · nivel 85","elementos":[],"oleadas":[["gi-enemy-26110101"]]},{"nombre":"Acto 6 · nivel 90","elementos":[],"oleadas":[["gi-enemy-26160302"]]}]},{"piso":3,"nombre":"Modo Difícil","mitades":[{"nombre":"Acto 3 · nivel 90","elementos":[],"oleadas":[["gi-enemy-26110101"]]},{"nombre":"Acto 6 · nivel 92","elementos":[],"oleadas":[["gi-enemy-26160302"]]},{"nombre":"Acto 8 · nivel 95","elementos":[],"oleadas":[["nombre:Battle-Hardened Pipilpan Idol"]]}]},{"piso":4,"nombre":"Modo Visionario","mitades":[{"nombre":"Acto 3 · nivel 90","elementos":[],"oleadas":[["gi-enemy-26110101"]]},{"nombre":"Acto 6 · nivel 92","elementos":[],"oleadas":[["gi-enemy-26160302"]]},{"nombre":"Acto 8 · nivel 95","elementos":[],"oleadas":[["nombre:Battle-Hardened Pipilpan Idol"]]},{"nombre":"Acto 10 · nivel 100","elementos":[],"oleadas":[["gi-enemy-26301101"]]}]},{"piso":5,"nombre":"Modo Lunar","mitades":[{"nombre":"Acto 3 · nivel 90","elementos":[],"oleadas":[["gi-enemy-26110101"]]},{"nombre":"Acto 6 · nivel 92","elementos":[],"oleadas":[["gi-enemy-26160302"]]},{"nombre":"Acto 8 · nivel 95","elementos":[],"oleadas":[["nombre:Battle-Hardened Pipilpan Idol"]]},{"nombre":"Acto 10 · nivel 100","elementos":[],"oleadas":[["gi-enemy-26301101"]]},{"nombre":"Desafío arcano I · nivel 100","elementos":[],"oleadas":[["gi-enemy-22070301","gi-enemy-22070201","gi-enemy-22070101"]]},{"nombre":"Desafío arcano II · nivel 100","elementos":[],"oleadas":[["gi-enemy-26050601"]]}]}]'::jsonb, '{"elementos":["Hydro","Electro","Dendro"],"grupos":[{"nombre":"Personajes iniciales (obligatorios; si no los tienes, se prestan de prueba)","personajes":["gi-columbina","gi-cyno","gi-lauma","gi-xingqiu","gi-kuki-shinobu","gi-kaveh"]},{"nombre":"Invitados especiales (solo si los tienes)","personajes":["gi-nicole","gi-sandrone","gi-odette","gi-sucrose"]}]}'::jsonb),
  ('gi-stygian-7-0', 'genshin-impact', 'stygian-onslaught', 'Ciclo de la versión 7.0', 'actual', '2026-08-19', '2026-09-22', '[{"nombre":"León Quimérico Alado","descripcion":"El daño de Destello Estelar impide que complete sus ataques. Sirve cualquier daño Estelar, pero lo más recomendable es un equipo de Superconductor Estelar para romper su escudo Electro.","tipo":"general"},{"nombre":"Soldado Fatui - Senescal Anemo (veterano)","descripcion":"Personajes como Arlecchino o Clorinde, que se benefician del pacto vital, lo ponen muy fácil.","tipo":"general"},{"nombre":"Puñopato","descripcion":"Invoca varios dispositivos de estampado y se protege con un escudo. Lo mejor es usar Electrocargado o Electrocargado Lunar para volver los dispositivos contra él y romper el escudo.","tipo":"general"}]'::jsonb, '[{"piso":1,"nombre":"Campo de batalla 1","mitades":[{"elementos":[],"oleadas":[["gi-enemy-26310501"]]}]},{"piso":2,"nombre":"Campo de batalla 2","mitades":[{"elementos":[],"oleadas":[["gi-enemy-23060201"]]}]},{"piso":3,"nombre":"Campo de batalla 3","mitades":[{"elementos":[],"oleadas":[["gi-enemy-24100101"]]}]}]'::jsonb, '{"equipos":[{"nombre":"Campo de batalla 1","personajes":["gi-sandrone","gi-yae-miko","gi-odette","gi-nicole"]},{"nombre":"Campo de batalla 2","personajes":["gi-arlecchino","gi-nicole","gi-chevreuse","gi-fischl"]},{"nombre":"Campo de batalla 3","personajes":["gi-flins","gi-sucrose","gi-ineffa","gi-columbina"]}]}'::jsonb),
  ('gi-stygian-7-1', 'genshin-impact', 'stygian-onslaught', 'Ciclo de la versión 7.1', 'proxima', '2026-09-30', '2026-11-03', '[]'::jsonb, '[]'::jsonb, null)
on conflict (id) do update
  set game_id = excluded.game_id,
      mode = excluded.mode,
      name = excluded.name,
      status = excluded.status,
      begins_on = excluded.begins_on,
      ends_on = excluded.ends_on,
      effects = excluded.effects,
      floors = excluded.floors,
      extra = excluded.extra,
      updated_at = now();

-- Las rotaciones que ya no son la actual ni la siguiente dejan de ensenarse.
update public.endgame_rotations
set status = 'pasada', updated_at = now()
where game_id = 'genshin-impact'
  and id not in ('gi-abyss-2026-08', 'gi-abyss-2026-09', 'gi-theater-27', 'gi-stygian-7-0', 'gi-stygian-7-1');

-- Comprobacion
select mode, name, status, begins_on, ends_on, jsonb_array_length(floors) as pisos
from public.endgame_rotations
where game_id = 'genshin-impact' and status <> 'pasada'
order by mode, begins_on nulls first;

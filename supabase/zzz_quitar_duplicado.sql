-- Ejecutar en Supabase -> SQL Editor -> New query -> Run.
--
-- Soldado 11 estaba dos veces en la tabla de personajes:
--   zzz-soldado-11  -> la buena: viene de characters_full.sql, tiene rol,
--                      especialidad, motor-W y es la que usa la tier list.
--   zzz-soldier-11  -> la vieja de characters.sql. Volvio a aparecer porque
--                      characters.sql se ejecuto despues de characters_full.sql.
--
-- Borrar la fila vieja a pelo borraria en cascada lo que los usuarios hayan
-- guardado con ella (favoritos, tier list personal, guias). Por eso primero se
-- pasa todo a zzz-soldado-11 y solo despues se borra. Si un usuario ya lo
-- tenia guardado con las dos, se queda con lo de zzz-soldado-11.
--
-- Se puede ejecutar varias veces: si la fila vieja ya no existe, no hace nada.

begin;

-- Favoritos.
insert into public.favorite_characters (user_id, character_id, created_at)
select user_id, 'zzz-soldado-11', created_at
from public.favorite_characters
where character_id = 'zzz-soldier-11'
on conflict (user_id, character_id) do nothing;

-- Tier list personal de cada usuario.
insert into public.tier_lists_personal (user_id, game_id, character_id, tier, updated_at)
select user_id, game_id, 'zzz-soldado-11', tier, updated_at
from public.tier_lists_personal
where character_id = 'zzz-soldier-11'
on conflict (user_id, game_id, character_id) do nothing;

-- Tier list oficial.
insert into public.tier_lists_oficial (game_id, mode, character_id, rating, source, updated_at)
select game_id, mode, 'zzz-soldado-11', rating, source, updated_at
from public.tier_lists_oficial
where character_id = 'zzz-soldier-11'
on conflict (game_id, mode, character_id) do nothing;

-- Guias meta.
insert into public.character_meta_guides
  (game_id, character_id, mode, equipment_build, stats, variations, source, updated_at)
select game_id, 'zzz-soldado-11', mode, equipment_build, stats, variations, source, updated_at
from public.character_meta_guides
where character_id = 'zzz-soldier-11'
on conflict (character_id, mode) do nothing;

-- Guias de los usuarios: cada una tiene su propio id, asi que se mueven tal cual.
update public.user_guides
set character_id = 'zzz-soldado-11'
where character_id = 'zzz-soldier-11';

-- Ahora ya se puede borrar sin perder nada.
delete from public.characters where id = 'zzz-soldier-11';

commit;

-- Comprobacion: deberia salir una sola fila, zzz-soldado-11.
select id, name from public.characters where name ilike '%soldad%' or name ilike '%soldier%';

-- Ejecutar en Supabase -> SQL Editor -> New query -> Run.
--
-- Borra High School DxD: OPI de la base de datos. El juego ya no esta en la
-- app: se ha quitado del codigo y su archivo de datos (05_personajes_dxd.sql)
-- se ha eliminado del repositorio.
--
-- Al borrar los personajes desaparecen solos (en cascada) sus favoritos, sus
-- entradas en las tier lists oficiales y personales, sus guias meta y las
-- guias que hayan escrito los usuarios sobre ellos.
--
-- Es de un solo uso: una vez ejecutado, no hace falta volver a pasarlo.
-- Tampoco pasa nada si se repite: simplemente no encontrara nada que borrar.
--
-- Generado el 2026-09-18.

-- Que hay antes de borrar.
select 'personajes' as tabla, count(*) as filas from public.characters where game_id = 'high-school-dxd-opi'
union all
select 'favoritos', count(*) from public.favorite_characters f
  join public.characters c on c.id = f.character_id where c.game_id = 'high-school-dxd-opi'
union all
select 'tier list oficial', count(*) from public.tier_lists_oficial where game_id = 'high-school-dxd-opi'
union all
select 'tier list personal', count(*) from public.tier_lists_personal where game_id = 'high-school-dxd-opi'
union all
select 'guias meta', count(*) from public.character_meta_guides where game_id = 'high-school-dxd-opi'
union all
select 'guias de usuarios', count(*) from public.user_guides where game_id = 'high-school-dxd-opi'
union all
select 'juego en bibliotecas', count(*) from public.user_games where game_id = 'high-school-dxd-opi';

-- Biblioteca de los usuarios: esta tabla no apunta a los personajes, asi que
-- se limpia aparte.
delete from public.user_games where game_id = 'high-school-dxd-opi';

-- Por si alguna fila quedo con el game_id pero apuntando a otro personaje.
delete from public.tier_lists_oficial where game_id = 'high-school-dxd-opi';
delete from public.tier_lists_personal where game_id = 'high-school-dxd-opi';
delete from public.user_guides where game_id = 'high-school-dxd-opi';
delete from public.character_meta_guides where game_id = 'high-school-dxd-opi';

-- Y los personajes, que arrastran en cascada todo lo que cuelgue de ellos.
delete from public.characters where game_id = 'high-school-dxd-opi';

-- Comprobacion: deberia salir 0 en las dos.
select
  (select count(*) from public.characters where game_id = 'high-school-dxd-opi') as personajes,
  (select count(*) from public.user_games where game_id = 'high-school-dxd-opi') as bibliotecas;

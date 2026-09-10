-- Ejecutar en Supabase -> SQL Editor -> New query -> Run.
-- Requiere characters.sql.
--
-- Personajes de Honkai: Star Rail que faltaban. La base de datos tenia 81 y el
-- catalogo del juego va por 97 (las otras 15 diferencias son variantes del
-- Trazacaminos que ya estaban o que no existen como unidad aparte).
--
-- Fuentes:
--   Roster, atributos y caminos -> StarRailRes, de Mar-7th, que es el catalogo
--     que usan casi todas las webs de Honkai:
--     https://github.com/Mar-7th/StarRailRes
--   Fecha de salida -> wiki de Honkai (campo release_date), para poder separar
--     lo que ya esta en el juego de lo que todavia no.
--   Iconos -> enka.network, el mismo formato que ya usaban las filas antiguas.
--
-- Generado el 2026-09-10. Los 7 iconos se comprobaron uno a uno: 7 responden.

-- ---------------------------------------------------------------------------
-- Marca para los personajes anunciados que aun no han salido.
-- ---------------------------------------------------------------------------
alter table public.characters
  add column if not exists is_upcoming boolean not null default false;

-- ---------------------------------------------------------------------------
-- Si ya se ejecuto la version anterior de este archivo, el camino se llamaba
-- "Jubilo". Estas lineas lo dejan como "Exultacion" y quitan la fila del
-- Trazacaminos con el id viejo, para que no quede duplicada al reinsertarlo.
-- Si no se ejecuto, no hacen nada.
-- ---------------------------------------------------------------------------
update public.characters set path = 'Exultación' where path = 'Júbilo';
delete from public.characters where id = 'hsr-trazacaminos-jubilo';

-- ---------------------------------------------------------------------------
-- 6 personajes ya publicados.
-- ---------------------------------------------------------------------------
insert into public.characters (id, game_id, name, element, rarity, path, image_url, is_upcoming)
values
  ('hsr-the-dahlia', 'honkai-star-rail', 'La Dalia (The Dahlia)', 'Fuego', '5', 'Nihilidad', 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1321.png', false),  -- sale el 2025-12-17
  ('hsr-sparxie', 'honkai-star-rail', 'Chispa (Sparxie)', 'Fuego', '5', 'Exultación', 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1501.png', false),  -- sale el 2026-03-03
  ('hsr-yao-guang', 'honkai-star-rail', 'Yao Guang', 'Físico', '5', 'Exultación', 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1502.png', false),  -- sale el 2026-02-13
  ('hsr-ashveil', 'honkai-star-rail', 'Ashveil', 'Rayo', '5', 'Cacería', 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1504.png', false),  -- sale el 2026-03-25
  ('hsr-evanescia', 'honkai-star-rail', 'Evanescia', 'Físico', '5', 'Exultación', 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1505.png', false),  -- sale el 2026-05-13
  ('hsr-trazacaminos-exultacion', 'honkai-star-rail', 'Trazacaminos (Exultación)', 'Rayo', '5', 'Exultación', 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/8009.png', false)  -- sale el 2026-04-22
on conflict (id) do update
  set name = excluded.name,
      element = excluded.element,
      rarity = excluded.rarity,
      path = excluded.path,
      image_url = excluded.image_url,
      is_upcoming = excluded.is_upcoming;

-- ---------------------------------------------------------------------------
-- 1 anunciado(s) que todavia no ha(n) salido, marcado(s) como futuro.
-- ---------------------------------------------------------------------------
insert into public.characters (id, game_id, name, element, rarity, path, image_url, is_upcoming)
values
  ('hsr-aventurine-waveflair', 'honkai-star-rail', 'Aventurino Oleaje (Aventurine • Waveflair)', 'Cuántico', '5', 'Exultación', 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1513.png', true)  -- sale el 2026-09-12
on conflict (id) do update
  set name = excluded.name,
      element = excluded.element,
      rarity = excluded.rarity,
      path = excluded.path,
      image_url = excluded.image_url,
      is_upcoming = excluded.is_upcoming;

-- ---------------------------------------------------------------------------
-- Cuando salga de verdad, basta con quitarle la marca:
--   update public.characters set is_upcoming = false where id = '...';
-- ---------------------------------------------------------------------------

-- Comprobacion: deben salir 88 personajes, 1 de ellos marcado(s) como futuro.
select count(*) as total,
       count(*) filter (where is_upcoming) as proximamente,
       count(*) filter (where image_url is null) as sin_icono
from public.characters
where game_id = 'honkai-star-rail';

select name, element, rarity, path, is_upcoming
from public.characters
where game_id = 'honkai-star-rail'
order by is_upcoming desc, name;

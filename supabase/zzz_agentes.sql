-- Ejecutar en Supabase -> SQL Editor -> New query -> Run.
-- Requiere characters.sql.
--
-- Roster completo de agentes de Zenless Zone Zero. La base de datos se habia
-- quedado en 26 agentes (mas o menos la version 1.4) y el juego va ya por 60.
--
-- Los datos salen de la API publica de Enka, que los saca del propio juego:
-- https://raw.githubusercontent.com/EnkaNetwork/API-docs/master/store/zzz/
-- De ahi vienen el nombre en espanol, la rareza, el atributo, la especialidad
-- y el icono. Las 60 imagenes se comprobaron una a una: todas responden.
--
-- Generado el 2026-09-10.

-- ---------------------------------------------------------------------------
-- Los 34 agentes que faltaban.
--
-- "on conflict do update" hace que se pueda volver a ejecutar sin miedo: si la
-- fila ya existe se actualiza en vez de fallar.
-- ---------------------------------------------------------------------------
insert into public.characters (id, game_id, name, element, rarity, role, image_url)
values
  ('zzz-alice', 'zenless-zone-zero', 'Alice', 'Físico', 'S', 'Anomalía', 'https://enka.network/ui/zzz/IconRoleCircle46.png'),
  ('zzz-aria', 'zenless-zone-zero', 'Aria', 'Éter', 'S', 'Anomalía', 'https://enka.network/ui/zzz/IconRoleCircle57.png'),
  ('zzz-astra-yao', 'zenless-zone-zero', 'Astra Yao', 'Éter', 'S', 'Apoyo', 'https://enka.network/ui/zzz/IconRoleCircle36.png'),
  ('zzz-banyue', 'zenless-zone-zero', 'Banyue', 'Fuego', 'S', 'Ruptura', 'https://enka.network/ui/zzz/IconRoleCircle53.png'),
  ('zzz-cissia', 'zenless-zone-zero', 'Cissia', 'Eléctrico', 'S', 'Ataque', 'https://enka.network/ui/zzz/IconRoleCircle60.png'),
  ('zzz-claret', 'zenless-zone-zero', 'Claret', 'Eléctrico', 'S', 'Blindaje', 'https://enka.network/ui/zzz/IconRoleCircle1611.png'),
  ('zzz-dialyn', 'zenless-zone-zero', 'Dialyn', 'Físico', 'S', 'Aturdimiento', 'https://enka.network/ui/zzz/IconRoleCircle54.png'),
  ('zzz-evelyn', 'zenless-zone-zero', 'Evelyn', 'Fuego', 'S', 'Ataque', 'https://enka.network/ui/zzz/IconRoleCircle37.png'),
  ('zzz-hugo', 'zenless-zone-zero', 'Hugo', 'Hielo', 'S', 'Ataque', 'https://enka.network/ui/zzz/IconRoleCircle42.png'),
  ('zzz-ju-fufu', 'zenless-zone-zero', 'Ju Fufu', 'Fuego', 'S', 'Aturdimiento', 'https://enka.network/ui/zzz/IconRoleCircle43.png'),
  ('zzz-lucia', 'zenless-zone-zero', 'Lucía', 'Éter', 'S', 'Apoyo', 'https://enka.network/ui/zzz/IconRoleCircle50.png'),
  ('zzz-manato', 'zenless-zone-zero', 'Manato', 'Fuego', 'A', 'Ruptura', 'https://enka.network/ui/zzz/IconRoleCircle51.png'),
  ('zzz-nangong-yu', 'zenless-zone-zero', 'Nangong Yu', 'Éter', 'S', 'Aturdimiento', 'https://enka.network/ui/zzz/IconRoleCircle59.png'),
  ('zzz-norma', 'zenless-zone-zero', 'Norma', 'Fuego', 'S', 'Aturdimiento', 'https://enka.network/ui/zzz/IconRoleCircle65.png'),
  ('zzz-orphie-magus', 'zenless-zone-zero', 'Orfia y Magas (Orphie & Magus)', 'Fuego', 'S', 'Ataque', 'https://enka.network/ui/zzz/IconRoleCircle49.png'),
  ('zzz-pan-yinhu', 'zenless-zone-zero', 'Pan Yinhu', 'Físico', 'A', 'Defensa', 'https://enka.network/ui/zzz/IconRoleCircle45.png'),
  ('zzz-promeia', 'zenless-zone-zero', 'Promeia', 'Hielo', 'S', 'Anomalía', 'https://enka.network/ui/zzz/IconRoleCircle61.png'),
  ('zzz-pulchra', 'zenless-zone-zero', 'Pulchra', 'Físico', 'A', 'Aturdimiento', 'https://enka.network/ui/zzz/IconRoleCircle38.png'),
  ('zzz-pyrois', 'zenless-zone-zero', 'Pyrois', 'Éter', 'S', 'Ataque', 'https://enka.network/ui/zzz/IconRoleCircle63.png'),
  ('zzz-remielle', 'zenless-zone-zero', 'Remielle', 'Lumen', 'S', 'Anomalía', 'https://enka.network/ui/zzz/IconRoleCircle67.png'),
  ('zzz-roxy', 'zenless-zone-zero', 'Roxy', 'Viento', 'S', 'Aturdimiento', 'https://enka.network/ui/zzz/IconRoleCircle68.png'),
  ('zzz-seed', 'zenless-zone-zero', 'Sporos (Seed)', 'Eléctrico', 'S', 'Ataque', 'https://enka.network/ui/zzz/IconRoleCircle48.png'),
  ('zzz-sigrid', 'zenless-zone-zero', 'Sigrid', 'Hielo', 'S', 'Ataque', 'https://enka.network/ui/zzz/IconRoleCircle66.png'),
  ('zzz-soldier-0-anby', 'zenless-zone-zero', 'N.º 0: Anby (Soldier 0 - Anby)', 'Eléctrico', 'S', 'Ataque', 'https://enka.network/ui/zzz/IconRoleCircle40.png'),
  ('zzz-starlight-billy', 'zenless-zone-zero', 'Billy Estelar (Starlight - Billy)', 'Físico', 'S', 'Ruptura', 'https://enka.network/ui/zzz/IconRoleCircle62.png'),
  ('zzz-sunna', 'zenless-zone-zero', 'Sunna', 'Físico', 'S', 'Apoyo', 'https://enka.network/ui/zzz/IconRoleCircle58.png'),
  ('zzz-trigger', 'zenless-zone-zero', 'Gatillo (Trigger)', 'Eléctrico', 'S', 'Aturdimiento', 'https://enka.network/ui/zzz/IconRoleCircle39.png'),
  ('zzz-velina', 'zenless-zone-zero', 'Velina', 'Viento', 'S', 'Anomalía', 'https://enka.network/ui/zzz/IconRoleCircle64.png'),
  ('zzz-vivian', 'zenless-zone-zero', 'Vivian', 'Éter', 'S', 'Anomalía', 'https://enka.network/ui/zzz/IconRoleCircle41.png'),
  ('zzz-ye-shunguang', 'zenless-zone-zero', 'Ye Shunguang', 'Físico', 'S', 'Ataque', 'https://enka.network/ui/zzz/IconRoleCircle55.png'),
  ('zzz-yidhari', 'zenless-zone-zero', 'Yidhari', 'Hielo', 'S', 'Ruptura', 'https://enka.network/ui/zzz/IconRoleCircle52.png'),
  ('zzz-yixuan', 'zenless-zone-zero', 'Yixuan', 'Éter', 'S', 'Ruptura', 'https://enka.network/ui/zzz/IconRoleCircle44.png'),
  ('zzz-yuzuha', 'zenless-zone-zero', 'Yuzuha', 'Físico', 'S', 'Apoyo', 'https://enka.network/ui/zzz/IconRoleCircle47.png'),
  ('zzz-zhao', 'zenless-zone-zero', 'Zhao', 'Hielo', 'S', 'Defensa', 'https://enka.network/ui/zzz/IconRoleCircle56.png')
on conflict (id) do update
  set name = excluded.name,
      element = excluded.element,
      rarity = excluded.rarity,
      role = excluded.role,
      image_url = excluded.image_url;

-- ---------------------------------------------------------------------------
-- Comprobacion: deben salir 60 agentes y ninguno sin icono.
-- ---------------------------------------------------------------------------
select count(*) as total,
       count(*) filter (where image_url is null) as sin_icono
from public.characters
where game_id = 'zenless-zone-zero';

select name, element, rarity, role
from public.characters
where game_id = 'zenless-zone-zero'
order by name;

-- ---------------------------------------------------------------------------
-- OPCIONAL: unificar la especialidad de los 26 agentes antiguos.
--
-- Los que ya estaban usan etiquetas del estilo "DPS", "Buffer" o
-- "Tanque / Sub-DPS", mientras que los nuevos llevan la especialidad oficial
-- del juego ("Ataque", "Aturdimiento", "Anomalia"...). Si prefieres una sola
-- forma de nombrarlas, descomenta este bloque y quedaran todas iguales.
-- Si te gustan las etiquetas de antes, no ejecutes nada de aqui abajo.
-- ---------------------------------------------------------------------------
-- update public.characters set role = 'Anomalía', element = 'Físico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle46.png' where id = 'zzz-alice';
-- update public.characters set role = 'Aturdimiento', element = 'Eléctrico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle01.png' where id = 'zzz-anby';
-- update public.characters set role = 'Ataque', element = 'Eléctrico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle15.png' where id = 'zzz-anton';
-- update public.characters set role = 'Anomalía', element = 'Éter', image_url = 'https://enka.network/ui/zzz/IconRoleCircle57.png' where id = 'zzz-aria';
-- update public.characters set role = 'Apoyo', element = 'Éter', image_url = 'https://enka.network/ui/zzz/IconRoleCircle36.png' where id = 'zzz-astra-yao';
-- update public.characters set role = 'Ruptura', element = 'Fuego', image_url = 'https://enka.network/ui/zzz/IconRoleCircle53.png' where id = 'zzz-banyue';
-- update public.characters set role = 'Defensa', element = 'Fuego', image_url = 'https://enka.network/ui/zzz/IconRoleCircle16.png' where id = 'zzz-ben';
-- update public.characters set role = 'Ataque', element = 'Físico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle10.png' where id = 'zzz-billy';
-- update public.characters set role = 'Anomalía', element = 'Fuego', image_url = 'https://enka.network/ui/zzz/IconRoleCircle32.png' where id = 'zzz-burnice';
-- update public.characters set role = 'Defensa', element = 'Físico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle25.png' where id = 'zzz-caesar';
-- update public.characters set role = 'Ataque', element = 'Eléctrico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle60.png' where id = 'zzz-cissia';
-- update public.characters set role = 'Blindaje', element = 'Eléctrico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle1611.png' where id = 'zzz-claret';
-- update public.characters set role = 'Ataque', element = 'Físico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle09.png' where id = 'zzz-corin';
-- update public.characters set role = 'Aturdimiento', element = 'Físico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle54.png' where id = 'zzz-dialyn';
-- update public.characters set role = 'Ataque', element = 'Hielo', image_url = 'https://enka.network/ui/zzz/IconRoleCircle21.png' where id = 'zzz-ellen';
-- update public.characters set role = 'Ataque', element = 'Fuego', image_url = 'https://enka.network/ui/zzz/IconRoleCircle37.png' where id = 'zzz-evelyn';
-- update public.characters set role = 'Anomalía', element = 'Eléctrico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle20.png' where id = 'zzz-grace';
-- update public.characters set role = 'Ataque', element = 'Eléctrico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle35.png' where id = 'zzz-harumasa';
-- update public.characters set role = 'Ataque', element = 'Hielo', image_url = 'https://enka.network/ui/zzz/IconRoleCircle42.png' where id = 'zzz-hugo';
-- update public.characters set role = 'Anomalía', element = 'Físico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle24.png' where id = 'zzz-jane';
-- update public.characters set role = 'Aturdimiento', element = 'Fuego', image_url = 'https://enka.network/ui/zzz/IconRoleCircle43.png' where id = 'zzz-ju-fufu';
-- update public.characters set role = 'Aturdimiento', element = 'Fuego', image_url = 'https://enka.network/ui/zzz/IconRoleCircle14.png' where id = 'zzz-koleda';
-- update public.characters set role = 'Aturdimiento', element = 'Fuego', image_url = 'https://enka.network/ui/zzz/IconRoleCircle26.png' where id = 'zzz-lighter';
-- update public.characters set role = 'Apoyo', element = 'Éter', image_url = 'https://enka.network/ui/zzz/IconRoleCircle50.png' where id = 'zzz-lucia';
-- update public.characters set role = 'Apoyo', element = 'Fuego', image_url = 'https://enka.network/ui/zzz/IconRoleCircle27.png' where id = 'zzz-lucy';
-- update public.characters set role = 'Aturdimiento', element = 'Hielo', image_url = 'https://enka.network/ui/zzz/IconRoleCircle18.png' where id = 'zzz-lycaon';
-- update public.characters set role = 'Ruptura', element = 'Fuego', image_url = 'https://enka.network/ui/zzz/IconRoleCircle51.png' where id = 'zzz-manato';
-- update public.characters set role = 'Anomalía', element = 'Hielo', image_url = 'https://enka.network/ui/zzz/IconRoleCircle13.png' where id = 'zzz-miyabi';
-- update public.characters set role = 'Aturdimiento', element = 'Éter', image_url = 'https://enka.network/ui/zzz/IconRoleCircle59.png' where id = 'zzz-nangong-yu';
-- update public.characters set role = 'Ataque', element = 'Físico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle11.png' where id = 'zzz-nekomata';
-- update public.characters set role = 'Apoyo', element = 'Éter', image_url = 'https://enka.network/ui/zzz/IconRoleCircle12.png' where id = 'zzz-nicole';
-- update public.characters set role = 'Aturdimiento', element = 'Fuego', image_url = 'https://enka.network/ui/zzz/IconRoleCircle65.png' where id = 'zzz-norma';
-- update public.characters set role = 'Ataque', element = 'Fuego', image_url = 'https://enka.network/ui/zzz/IconRoleCircle49.png' where id = 'zzz-orphie-magus';
-- update public.characters set role = 'Defensa', element = 'Físico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle45.png' where id = 'zzz-pan-yinhu';
-- update public.characters set role = 'Anomalía', element = 'Físico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle28.png' where id = 'zzz-piper';
-- update public.characters set role = 'Anomalía', element = 'Hielo', image_url = 'https://enka.network/ui/zzz/IconRoleCircle61.png' where id = 'zzz-promeia';
-- update public.characters set role = 'Aturdimiento', element = 'Físico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle38.png' where id = 'zzz-pulchra';
-- update public.characters set role = 'Ataque', element = 'Éter', image_url = 'https://enka.network/ui/zzz/IconRoleCircle63.png' where id = 'zzz-pyrois';
-- update public.characters set role = 'Aturdimiento', element = 'Eléctrico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle29.png' where id = 'zzz-qingyi';
-- update public.characters set role = 'Anomalía', element = 'Lumen', image_url = 'https://enka.network/ui/zzz/IconRoleCircle67.png' where id = 'zzz-remielle';
-- update public.characters set role = 'Apoyo', element = 'Eléctrico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle22.png' where id = 'zzz-rina';
-- update public.characters set role = 'Aturdimiento', element = 'Viento', image_url = 'https://enka.network/ui/zzz/IconRoleCircle68.png' where id = 'zzz-roxy';
-- update public.characters set role = 'Ataque', element = 'Eléctrico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle48.png' where id = 'zzz-seed';
-- update public.characters set role = 'Defensa', element = 'Eléctrico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle30.png' where id = 'zzz-seth';
-- update public.characters set role = 'Ataque', element = 'Hielo', image_url = 'https://enka.network/ui/zzz/IconRoleCircle66.png' where id = 'zzz-sigrid';
-- update public.characters set role = 'Ataque', element = 'Eléctrico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle40.png' where id = 'zzz-soldier-0-anby';
-- update public.characters set role = 'Ataque', element = 'Fuego', image_url = 'https://enka.network/ui/zzz/IconRoleCircle05.png' where id = 'zzz-soldado-11';
-- update public.characters set role = 'Apoyo', element = 'Hielo', image_url = 'https://enka.network/ui/zzz/IconRoleCircle17.png' where id = 'zzz-soukaku';
-- update public.characters set role = 'Ruptura', element = 'Físico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle62.png' where id = 'zzz-starlight-billy';
-- update public.characters set role = 'Apoyo', element = 'Físico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle58.png' where id = 'zzz-sunna';
-- update public.characters set role = 'Aturdimiento', element = 'Eléctrico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle39.png' where id = 'zzz-trigger';
-- update public.characters set role = 'Anomalía', element = 'Viento', image_url = 'https://enka.network/ui/zzz/IconRoleCircle64.png' where id = 'zzz-velina';
-- update public.characters set role = 'Anomalía', element = 'Éter', image_url = 'https://enka.network/ui/zzz/IconRoleCircle41.png' where id = 'zzz-vivian';
-- update public.characters set role = 'Anomalía', element = 'Eléctrico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle31.png' where id = 'zzz-yanagi';
-- update public.characters set role = 'Ataque', element = 'Físico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle55.png' where id = 'zzz-ye-shunguang';
-- update public.characters set role = 'Ruptura', element = 'Hielo', image_url = 'https://enka.network/ui/zzz/IconRoleCircle52.png' where id = 'zzz-yidhari';
-- update public.characters set role = 'Ruptura', element = 'Éter', image_url = 'https://enka.network/ui/zzz/IconRoleCircle44.png' where id = 'zzz-yixuan';
-- update public.characters set role = 'Apoyo', element = 'Físico', image_url = 'https://enka.network/ui/zzz/IconRoleCircle47.png' where id = 'zzz-yuzuha';
-- update public.characters set role = 'Defensa', element = 'Hielo', image_url = 'https://enka.network/ui/zzz/IconRoleCircle56.png' where id = 'zzz-zhao';
-- update public.characters set role = 'Ataque', element = 'Éter', image_url = 'https://enka.network/ui/zzz/IconRoleCircle23.png' where id = 'zzz-zhu-yuan';

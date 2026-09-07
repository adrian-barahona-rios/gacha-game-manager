-- Ejecutar en Supabase → SQL Editor → New query → Run.
-- Requiere characters_full.sql ya ejecutado.
--
-- Los 18 personajes de Genshin que faltaban frente al listado de la version 7.0
-- (118 jugables, contando al Viajero una sola vez).
--
-- Elemento y rareza verificados en GameWith. El rol se deja vacio a proposito:
-- la fuente solo lo indica para unos pocos y con otra terminologia distinta a
-- la de las demas fichas, asi que se rellena a mano para no mezclar criterios.
-- Se puede repetir sin problema: no duplica nada.

insert into public.characters (id, game_id, name, rarity, element, level_cap) values
  ('gi-dahlia', 'genshin-impact', 'Dahlia', '4', 'Hydro', 90),
  ('gi-durin', 'genshin-impact', 'Durin', '5', 'Pyro', 90),
  ('gi-escoffier', 'genshin-impact', 'Escoffier', '5', 'Cryo', 90),
  ('gi-ifa', 'genshin-impact', 'Ifa', '4', 'Anemo', 90),
  ('gi-illuga', 'genshin-impact', 'Illuga', '4', 'Geo', 90),
  ('gi-jahoda', 'genshin-impact', 'Jahoda', '4', 'Anemo', 90),
  ('gi-lauma', 'genshin-impact', 'Lauma', '5', 'Dendro', 90),
  ('gi-linnea', 'genshin-impact', 'Linnea', '5', 'Geo', 90),
  ('gi-lohen', 'genshin-impact', 'Lohen', '5', 'Cryo', 90),
  ('gi-mizuki', 'genshin-impact', 'Mizuki', '5', 'Anemo', 90),
  ('gi-nefer', 'genshin-impact', 'Nefer', '5', 'Dendro', 90),
  ('gi-nicole', 'genshin-impact', 'Nicole', '5', 'Pyro', 90),
  ('gi-prune', 'genshin-impact', 'Prune', '4', 'Anemo', 90),
  ('gi-sandrone', 'genshin-impact', 'Sandrone', '5', 'Cryo', 90),
  ('gi-skirk', 'genshin-impact', 'Skirk', '5', 'Cryo', 90),
  ('gi-varesa', 'genshin-impact', 'Varesa', '5', 'Electro', 90),
  ('gi-varka', 'genshin-impact', 'Varka', '5', 'Anemo', 90),
  ('gi-zibai', 'genshin-impact', 'Zibai', '5', 'Geo', 90)
on conflict (id) do nothing;

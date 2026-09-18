-- Ejecutar en Supabase -> SQL Editor -> New query -> Run.
-- Requiere 01_esquema.sql (la tabla enemies).
--
-- Los 20 jefes de campo de Aniimo: 17 Alfa y 3 Omega, con su elemento,
-- la zona donde aparecen, como llegar hasta ellos, el botin de la primera
-- victoria y los materiales que sueltan.
--
-- La faccion guarda la zona y la clasificacion el tipo de jefe y su elemento.
--
-- Fuente: la guia de Game8 (game8.co/games/Aniimo/archives/621778).
--
-- Inserta lo que falte y actualiza lo que ya exista, sin borrar nada.
--
-- Generado el 2026-09-18.

insert into public.enemies (
  id, game_id, name, name_en, category, rank, faction, description, image_url,
  weaknesses, resistances, drops, classification
)
values
  ('aniimo-jefe-alpha-turbo', 'aniimo', 'Alpha Turbo', 'Alpha Turbo', 'jefe', 'elite', 'Campos Nubosos', 'Dónde está: Pasea por el campo, un poco al noreste del Santuario de la Primera Chispa.
Materiales: Gust Stone', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10262.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Gust Stone","cantidad":5,"rareza":null},{"nombre":"Glimmer","cantidad":50,"rareza":null},{"nombre":"Safaris","cantidad":500,"rareza":null},{"nombre":"Irisalis Petal","cantidad":1,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":1,"rareza":null}]'::jsonb, 'Jefe Alfa · Viento'),
  ('aniimo-jefe-alpha-stellarys', 'aniimo', 'Alpha Stellarys', 'Alpha Stellarys', 'jefe', 'elite', 'Bosque de Estrellas Fugaces', 'Dónde está: Al norte del Outpost, en el centro de una pradera con forma de estrella.
Materiales: Night Stone', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10012.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Night Stone","cantidad":5,"rareza":null},{"nombre":"Glimmer","cantidad":50,"rareza":null},{"nombre":"Safaris","cantidad":500,"rareza":null},{"nombre":"Irisalis Petal","cantidad":1,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":1,"rareza":null}]'::jsonb, 'Jefe Alfa · Oscuridad'),
  ('aniimo-jefe-alpha-scorchhowl', 'aniimo', 'Alpha Scorchhowl', 'Alpha Scorchhowl', 'jefe', 'elite', 'Cresta de Bestiacolmillo', 'Dónde está: Al este del Santuario "Del agua al hielo", en el centro de un monolito de tres piedras.
Materiales: Blaze Stone', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10053.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Blaze Stone","cantidad":5,"rareza":null},{"nombre":"Glimmer","cantidad":50,"rareza":null},{"nombre":"Safaris","cantidad":500,"rareza":null},{"nombre":"Irisalis Petal","cantidad":1,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":1,"rareza":null}]'::jsonb, 'Jefe Alfa · Fuego'),
  ('aniimo-jefe-alpha-leafy', 'aniimo', 'Alpha Leafy', 'Alpha Leafy', 'jefe', 'elite', 'Bosques de Neblina', 'Dónde está: Al noreste del Branch de Breezy Plains, en el centro de una arboleda.
Materiales: Sprout Stone', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10045.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Sprout Stone","cantidad":5,"rareza":null},{"nombre":"Glimmer","cantidad":50,"rareza":null},{"nombre":"Safaris","cantidad":500,"rareza":null},{"nombre":"Irisalis Petal","cantidad":1,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":1,"rareza":null}]'::jsonb, 'Jefe Alfa · Hierba'),
  ('aniimo-jefe-alpha-glynsera', 'aniimo', 'Alpha Glynsera', 'Alpha Glynsera', 'jefe', 'elite', 'Cresta de Bestiacolmillo', 'Dónde está: Al sur del Santuario "Del agua al hielo", bajo una cueva de hielo tapada por lianas inflamables o por hielo macizo.
Materiales: Freeze Stone', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10133.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Freeze Stone","cantidad":5,"rareza":null},{"nombre":"Glimmer","cantidad":50,"rareza":null},{"nombre":"Safaris","cantidad":500,"rareza":null},{"nombre":"Irisalis Petal","cantidad":1,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":1,"rareza":null}]'::jsonb, 'Jefe Alfa · Hielo'),
  ('aniimo-jefe-alpha-panpanta', 'aniimo', 'Alpha Panpanta', 'Alpha Panpanta', 'jefe', 'elite', 'Desembarco de Echoback', 'Dónde está: Al norte del Bloom de Desembarco de Echoback, cerca de la orilla.
Materiales: Wave Stone', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10174.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Wave Stone","cantidad":5,"rareza":null},{"nombre":"Glimmer","cantidad":50,"rareza":null},{"nombre":"Safaris","cantidad":500,"rareza":null},{"nombre":"Irisalis Petal","cantidad":1,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":1,"rareza":null}]'::jsonb, 'Jefe Alfa · Agua'),
  ('aniimo-jefe-alpha-bouldus', 'aniimo', 'Alpha Bouldus', 'Alpha Bouldus', 'jefe', 'elite', 'Pasarela Berilina', 'Dónde está: Al noreste del Bloom del Paso de Piedrabarro, en lo alto de una colina.
Materiales: Loam Stone', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10454.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Loam Stone","cantidad":5,"rareza":null},{"nombre":"Glimmer","cantidad":50,"rareza":null},{"nombre":"Safaris","cantidad":500,"rareza":null},{"nombre":"Irisalis Petal","cantidad":1,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":1,"rareza":null}]'::jsonb, 'Jefe Alfa · Roca'),
  ('aniimo-jefe-alpha-blazen', 'aniimo', 'Alpha Blazen', 'Alpha Blazen', 'jefe', 'elite', 'Bosque Electrizante', 'Dónde está: Al sur del Bloom de Bosque Electrizante, en lo alto de una montaña.
Materiales: Roar Stone', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10222.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Roar Stone","cantidad":5,"rareza":null},{"nombre":"Glimmer","cantidad":50,"rareza":null},{"nombre":"Safaris","cantidad":500,"rareza":null},{"nombre":"Irisalis Petal","cantidad":1,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":1,"rareza":null}]'::jsonb, 'Jefe Alfa · Eléctrico'),
  ('aniimo-jefe-alpha-tubster', 'aniimo', 'Alpha Tubster', 'Alpha Tubster', 'jefe', 'elite', 'El Estrecho de Plata', 'Dónde está: Al suroeste del Santuario de la Primera Chispa, en mitad de la orilla.
Materiales: Aniipod Mega, Breezy Plains Dewdrop Crystal', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10187.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Breezy Plains Dewdrop Crystal","cantidad":60,"rareza":null},{"nombre":"Glimmer","cantidad":50,"rareza":null},{"nombre":"Safaris","cantidad":500,"rareza":null},{"nombre":"Irisalis Petal","cantidad":1,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":1,"rareza":null}]'::jsonb, 'Jefe Alfa · Viento'),
  ('aniimo-jefe-alpha-magmarex', 'aniimo', 'Alpha Magmarex', 'Alpha Magmarex', 'jefe', 'elite', 'Puente Terrestre de Céfiro', 'Dónde está: Al norte del Bloom del Arrecife de Aguas Termales.
Materiales: Aniipod Mega, Breezy Plains Dewdrop Crystal', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10283.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Breezy Plains Dewdrop Crystal","cantidad":60,"rareza":null},{"nombre":"Glimmer","cantidad":50,"rareza":null},{"nombre":"Safaris","cantidad":500,"rareza":null},{"nombre":"Irisalis Petal","cantidad":1,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":1,"rareza":null}]'::jsonb, 'Jefe Alfa · Fuego'),
  ('aniimo-jefe-alpha-ignitis', 'aniimo', 'Alpha Ignitis', 'Alpha Ignitis', 'jefe', 'elite', 'Pasarela Berilina', 'Dónde está: Al sureste del Bloom de Pasarela Berilina.
Materiales: Basic Carried Item Core, Common Carried Item Core, Advanced Carried Item Core, Ferocious Fang, Miraculous Fleece, Lightning Needle', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10032.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Basic Carried Item Core","cantidad":1,"rareza":null},{"nombre":"Ferocious Fang","cantidad":1,"rareza":null},{"nombre":"Glimmer","cantidad":50,"rareza":null},{"nombre":"Safaris","cantidad":500,"rareza":null},{"nombre":"Irisalis Petal","cantidad":1,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":1,"rareza":null}]'::jsonb, 'Jefe Alfa · Oscuridad'),
  ('aniimo-jefe-alpha-grizbo', 'aniimo', 'Alpha Grizbo', 'Alpha Grizbo', 'jefe', 'elite', 'Bosque de la Torre de los Rosales', 'Dónde está: Al norte del Bloom del Bosque de la Torre de los Rosales.
Materiales: Basic Carried Item Core, Common Carried Item Core, Advanced Carried Item Core, Avenging Gear, Heartseeker Pendant, Heritage Amulet', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10503.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Basic Carried Item Core","cantidad":5,"rareza":null},{"nombre":"Gargantuan Horn","cantidad":1,"rareza":null},{"nombre":"Glimmer","cantidad":50,"rareza":null},{"nombre":"Safaris","cantidad":500,"rareza":null},{"nombre":"Irisalis Petal","cantidad":1,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":1,"rareza":null}]'::jsonb, 'Jefe Alfa · Roca'),
  ('aniimo-jefe-alpha-geoclaw', 'aniimo', 'Alpha Geoclaw', 'Alpha Geoclaw', 'jefe', 'elite', 'Campos Nubosos', 'Dónde está: Bajo tierra, en la parte noroeste de Campos Nubosos, cerca del Branch de Breezy Plains.
Materiales: Basic Carried Item Core, Common Carried Item Core, Advanced Carried Item Core, Marching Flask, Capacitous Battery, Gargantuan Horn', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10163.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Basic Carried Item Core","cantidad":5,"rareza":null},{"nombre":"Heartseeker Pendant","cantidad":1,"rareza":null},{"nombre":"Glimmer","cantidad":50,"rareza":null},{"nombre":"Safaris","cantidad":500,"rareza":null},{"nombre":"Irisalis Petal","cantidad":1,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":1,"rareza":null}]'::jsonb, 'Jefe Alfa · Hielo'),
  ('aniimo-jefe-alpha-minespine', 'aniimo', 'Alpha Minespine', 'Alpha Minespine', 'jefe', 'elite', 'Cresta de Bestiacolmillo', 'Dónde está: Dentro de la Mina Olvidada, en una cueva de la Cresta de Bestiacolmillo.
Materiales: Basic Carried Item Core, Common Carried Item Core, Advanced Carried Item Core, Auspicious Bell, Explosive Gloves, Giant Tortoise Shell', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10285.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Basic Carried Item Core","cantidad":5,"rareza":null},{"nombre":"Explosive Gloves","cantidad":1,"rareza":null},{"nombre":"Glimmer","cantidad":50,"rareza":null},{"nombre":"Safaris","cantidad":500,"rareza":null},{"nombre":"Irisalis Petal","cantidad":1,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":1,"rareza":null}]'::jsonb, 'Jefe Alfa · Roca'),
  ('aniimo-jefe-alpha-irisal', 'aniimo', 'Alpha Irisal', 'Alpha Irisal', 'jefe', 'elite', 'Mar de Flores', 'Dónde está: Al sur del Bloom del Mar de Flores.
Materiales: Basic Carried Item Core, Common Carried Item Core, Advanced Carried Item Core, Spirited Feather, Echoing Grimoire, Fission Needles', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10212.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Basic Carried Item Core","cantidad":5,"rareza":null},{"nombre":"Spirited Feather","cantidad":1,"rareza":null},{"nombre":"Glimmer","cantidad":50,"rareza":null},{"nombre":"Safaris","cantidad":500,"rareza":null},{"nombre":"Irisalis Petal","cantidad":1,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":1,"rareza":null}]'::jsonb, 'Jefe Alfa · Hierba'),
  ('aniimo-jefe-alpha-rookey', 'aniimo', 'Alpha Rookey', 'Alpha Rookey', 'jefe', 'elite', 'Sierras Bermejas', 'Dónde está: Al este del Santuario de la Primera Mirada.
Materiales: Star Dust, Star Sand', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10027.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Star Dust","cantidad":5,"rareza":null},{"nombre":"Star Sand","cantidad":2,"rareza":null},{"nombre":"Glimmer","cantidad":50,"rareza":null},{"nombre":"Safaris","cantidad":800,"rareza":null},{"nombre":"Irisalis Petal","cantidad":1,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":1,"rareza":null}]'::jsonb, 'Jefe Alfa · Oscuridad'),
  ('aniimo-jefe-alpha-luminelle', 'aniimo', 'Alpha Luminelle', 'Alpha Luminelle', 'jefe', 'elite', 'Costa de la Marea Floreciente', 'Dónde está: Al sur del Bloom de la Costa de la Marea Floreciente.
Materiales: Star Dust, Star Sand', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10143.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Star Dust","cantidad":5,"rareza":null},{"nombre":"Star Sand","cantidad":2,"rareza":null},{"nombre":"Glimmer","cantidad":50,"rareza":null},{"nombre":"Safaris","cantidad":500,"rareza":null},{"nombre":"Irisalis Petal","cantidad":1,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":1,"rareza":null}]'::jsonb, 'Jefe Alfa · Eléctrico'),
  ('aniimo-jefe-omega-tuckin', 'aniimo', 'Omega Tuckin', 'Omega Tuckin', 'jefe', 'jefe', 'Bosques de Neblina', 'Dónde está: Al norte del Bloom de Bosques de Neblina, enterrado junto a un árbol grande.
Materiales: Breezy Plains Dewdrop Crystal', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10207.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Breezy Plains Dewdrop Crystal","cantidad":100,"rareza":null},{"nombre":"Glimmer","cantidad":100,"rareza":null},{"nombre":"Safaris","cantidad":800,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":2,"rareza":null}]'::jsonb, 'Jefe Omega · Hierba'),
  ('aniimo-jefe-young-omega-sherro', 'aniimo', 'Young Omega Sherro', 'Young Omega Sherro', 'jefe', 'jefe', 'Desembarco de Echoback', 'Dónde está: Al noroeste del Bloom de los Bancos de Arena de la Playa, en otra isla.
Materiales: Star Dust, Star Sand', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10194.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Star Dust","cantidad":10,"rareza":null},{"nombre":"Star Sand","cantidad":4,"rareza":null},{"nombre":"Glimmer","cantidad":100,"rareza":null},{"nombre":"Safaris","cantidad":800,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":2,"rareza":null}]'::jsonb, 'Jefe Omega · Agua'),
  ('aniimo-jefe-omega-infergon', 'aniimo', 'Omega Infergon', 'Omega Infergon', 'jefe', 'jefe', 'Sierras Bermejas', 'Dónde está: Al sur del Bloom de Sierras Bermejas.
Materiales: Starcryst Essence', 'https://worldx-website-cdn.aniimo.com/official-website/worldx/wiki_stage/init/Wiki_Aniimo_10025.png', '[]'::jsonb, '[]'::jsonb, '[{"nombre":"Glimmer","cantidad":100,"rareza":null},{"nombre":"Safaris","cantidad":800,"rareza":null},{"nombre":"Lumin Amber: Breezy Plains","cantidad":2,"rareza":null},{"nombre":"Starcryst Essence","cantidad":2,"rareza":null}]'::jsonb, 'Jefe Omega · Fuego')
on conflict (id) do update
  set name = excluded.name,
      name_en = excluded.name_en,
      category = excluded.category,
      rank = excluded.rank,
      faction = excluded.faction,
      description = excluded.description,
      image_url = excluded.image_url,
      drops = excluded.drops,
      classification = excluded.classification,
      updated_at = now();

-- Comprobacion
select rank, count(*) as jefes
from public.enemies
where game_id = 'aniimo'
group by rank
order by rank;

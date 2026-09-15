-- Ejecutar en Supabase -> SQL Editor -> New query -> Run.
-- Requiere 01_esquema.sql, 02_personajes_genshin.sql, los 06_armas_genshin_*.sql
-- y 17_artefactos_genshin.sql.
--
-- Build recomendada de 119 personajes de Genshin Impact (la guia "General" de
-- cada uno, en la pestana de guias del personaje).
--
-- Fuente: las guias de build de Game8 (la primera build de cada personaje):
-- armas, conjuntos de artefactos, stat principal de arenas, caliz y tiara, y
-- subestadisticas. Genshin no trae una recomendacion oficial dentro del juego.
-- El Viajero usa la build de su version Anemo.
--
-- Cada fila guarda la build en dos formatos: texto (equipment_build y stats,
-- editables desde /admin) y build (jsonb con ids, para pintarla con iconos).
--
-- Sobrescribe la guia General de estos personajes.
--
-- Generado el 2026-09-15.

insert into public.character_meta_guides (
  game_id, character_id, mode, equipment_build, stats, variations, source, build
)
values
  ('genshin-impact', 'gi-aino', 'General', 'Arma ideal: Sabiduría Fraguada.
Otras armas que le van bien: Llave Maestra, Gran Espada de Favonius o Májaira Aguamarina.
Artefactos: Serenata de la Luna Tejida (4).', 'Arenas del Eón: Maestría Elemental.
Cáliz de Eonothem: Maestría Elemental.
Tiara de Logos: Prob. CRIT o Maestría Elemental.
Subestadísticas: Maestría Elemental, Prob. CRIT, Daño CRIT, Recarga de Energía.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-12432"],"alternativas":["gi-w-12433","gi-w-12401","gi-w-12415"]},"artefactos":[{"conjuntos":["gi-artifact-15042"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Maestría Elemental"],"caliz":["Maestría Elemental"],"tiara":["Prob. CRIT","Maestría Elemental"]},"secundarias":["Maestría Elemental","Prob. CRIT","Daño CRIT","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-albedo', 'General', 'Arma ideal: Cortatelones de Urakusai.
Otras armas que le van bien: Himno de las Cumbres, Huso de Cinabrio, Cortador de Jade Primordial, Colmillo Lupino o Flauta de Ezpitzal.
Artefactos: Cáscara de Sueños Opulentos (4) o Compañía Dorada (4).', 'Arenas del Eón: DEF %.
Cáliz de Eonothem: DEF % o Bono de Daño Geo.
Tiara de Logos: DEF %, Prob. CRIT o Daño CRIT.
Subestadísticas: DEF %, Prob. CRIT, Daño CRIT.', null, 'Game8', '{"rol":"DPS secundario (Hexerei)","armas":{"ideales":["gi-w-11514"],"alternativas":["gi-w-11516","gi-w-11415","gi-w-11505","gi-w-11424","gi-w-11431"]},"artefactos":[{"conjuntos":["gi-artifact-15021"],"piezas":"4"},{"conjuntos":["gi-artifact-15032"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["DEF %"],"caliz":["DEF %","Bono de Daño Geo"],"tiara":["DEF %","Prob. CRIT","Daño CRIT"]},"secundarias":["DEF %","Prob. CRIT","Daño CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-alhaitham', 'General', 'Arma ideal: Clorofilo Refulgente.
Otras armas que le van bien: Cortatelones de Urakusai, Cortador de Jade Primordial, Colmillo Lupino o Espina de Hierro.
Artefactos: Sueños Áureos (4).', 'Arenas del Eón: Maestría Elemental.
Cáliz de Eonothem: Bono de Daño Dendro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Maestría Elemental, Recarga de Energía, Prob. CRIT, Daño CRIT, ATQ %.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-11512"],"alternativas":["gi-w-11514","gi-w-11505","gi-w-11424","gi-w-11407"]},"artefactos":[{"conjuntos":["gi-artifact-15026"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Maestría Elemental"],"caliz":["Bono de Daño Dendro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Maestría Elemental","Recarga de Energía","Prob. CRIT","Daño CRIT","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-aloy', 'General', 'Arma ideal: Agitador del Relámpago.
Otras armas que le van bien: Alas Celestiales, Último Acorde o Prototipo Luz de Luna.
Artefactos: Orquesta del Errante (2) + Nómada del Invierno (2).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Cryo.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Recarga de Energía, Daño CRIT, Prob. CRIT, ATQ %.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-15509"],"alternativas":["gi-w-15501","gi-w-15402","gi-w-15406"]},"artefactos":[{"conjuntos":["gi-artifact-15003","gi-artifact-14001"],"piezas":"2+2"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Cryo"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Recarga de Energía","Daño CRIT","Prob. CRIT","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-alyosha', 'General', 'Arma ideal: Luz del Segador.
Otras armas que le van bien: Sinfonista de Aromas, Lanza de Favonius, Charla en el Pabellón o Balada de la Custodia.
Artefactos: Ritual Antiguo de la Nobleza (4).
Alternativas: Corazón Forjado (4).', 'Arenas del Eón: ATQ % o Recarga de Energía.
Cáliz de Eonothem: ATQ %.
Tiara de Logos: ATQ % o Prob. CRIT.
Subestadísticas: Recarga de Energía, ATQ %, Prob. CRIT.', null, 'Game8', '{"rol":"Apoyo (Stellar Conduct)","armas":{"ideales":["gi-w-13509"],"alternativas":["gi-w-13514","gi-w-13407","gi-w-13432","gi-w-13436"]},"artefactos":[{"conjuntos":["gi-artifact-15007"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15048"],"piezas":"4"}],"principales":{"arenas":["ATQ %","Recarga de Energía"],"caliz":["ATQ %"],"tiara":["ATQ %","Prob. CRIT"]},"secundarias":["Recarga de Energía","ATQ %","Prob. CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-amber', 'General', 'Arma ideal: Elegía del Fin.
Otras armas que le van bien: Arco de Favonius o Arco del Sacrificio.
Artefactos: Ritual Antiguo de la Nobleza (4).', 'Arenas del Eón: Recarga de Energía o ATQ %.
Cáliz de Eonothem: Bono de Daño Pyro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Recarga de Energía, Prob. CRIT, Daño CRIT, ATQ %.', null, 'Game8', '{"rol":"DPS secundario y apoyo","armas":{"ideales":["gi-w-15503"],"alternativas":["gi-w-15401","gi-w-15403"]},"artefactos":[{"conjuntos":["gi-artifact-15007"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Recarga de Energía","ATQ %"],"caliz":["Bono de Daño Pyro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Recarga de Energía","Prob. CRIT","Daño CRIT","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-arataki-itto', 'General', 'Arma ideal: Espadón Cornirrojo.
Otras armas que le van bien: Emblema del Mar de Juncos, Orgullo Celestial, Médula de la Serpiente Marina o Sombra Blanca.
Artefactos: Cáscara de Sueños Opulentos (4).', 'Arenas del Eón: DEF %.
Cáliz de Eonothem: Bono de Daño Geo.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: DEF %, Daño CRIT, Prob. CRIT, Recarga de Energía.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-12510"],"alternativas":["gi-w-12511","gi-w-12501","gi-w-12409","gi-w-12407"]},"artefactos":[{"conjuntos":["gi-artifact-15021"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["DEF %"],"caliz":["Bono de Daño Geo"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["DEF %","Daño CRIT","Prob. CRIT","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-arlecchino', 'General', 'Arma ideal: Semblante de la Luna Carmesí.
Otras armas que le van bien: Báculo de Homa, Halcón de Jade, Lanza del Duelo, Borla Blanca o Lanza del Peñasco Oscuro.
Artefactos: Fragmento de la Armonía Fantasiosa (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Pyro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Prob. CRIT, Daño CRIT, Recarga de Energía, ATQ %.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-13512"],"alternativas":["gi-w-13501","gi-w-13505","gi-w-13405","gi-w-13301","gi-w-13404"]},"artefactos":[{"conjuntos":["gi-artifact-15035"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Pyro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Prob. CRIT","Daño CRIT","Recarga de Energía","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-ayaka', 'General', 'Arma ideal: Reflejo de las Tinieblas.
Otras armas que le van bien: Luna Ondulante de Futsu, Espada Negra o Espada Amenoma Gemela.
Artefactos: Nómada del Invierno (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Cryo.
Tiara de Logos: Daño CRIT.
Subestadísticas: Daño CRIT, Recarga de Energía, ATQ %, Prob. CRIT.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-11509"],"alternativas":["gi-w-11510","gi-w-11409","gi-w-11414"]},"artefactos":[{"conjuntos":["gi-artifact-14001"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Cryo"],"tiara":["Daño CRIT"]},"secundarias":["Daño CRIT","Recarga de Energía","ATQ %","Prob. CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-ayato', 'General', 'Arma ideal: Luna Ondulante de Futsu.
Otras armas que le van bien: Reflejo de las Tinieblas, Cortador de Jade Primordial o Espada Negra.
Artefactos: Eco del Sacrificio (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Hydro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Recarga de Energía, Prob. CRIT, Daño CRIT, ATQ %, Vida %.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-11510"],"alternativas":["gi-w-11509","gi-w-11505","gi-w-11409"]},"artefactos":[{"conjuntos":["gi-artifact-15024"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Hydro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Recarga de Energía","Prob. CRIT","Daño CRIT","ATQ %","Vida %"]}'::jsonb),
  ('genshin-impact', 'gi-baizhu', 'General', 'Arma ideal: Centelleo Jadecaído.
Otras armas que le van bien: Prototipo Ámbar, Códice de Favonius, Memorias de Sacrificios o Cuentos de Cazadores de Dragones.
Artefactos: Recuerdos del Bosque (4).', 'Arenas del Eón: Vida % o Recarga de Energía.
Cáliz de Eonothem: Vida %.
Tiara de Logos: Vida %.
Subestadísticas: Recarga de Energía, Vida %.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-14505"],"alternativas":["gi-w-14406","gi-w-14401","gi-w-14403","gi-w-14302"]},"artefactos":[{"conjuntos":["gi-artifact-15025"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Vida %","Recarga de Energía"],"caliz":["Vida %"],"tiara":["Vida %"]},"secundarias":["Recarga de Energía","Vida %"]}'::jsonb),
  ('genshin-impact', 'gi-barbara', 'General', 'Arma ideal: Cuentos de Cazadores de Dragones.
Otras armas que le van bien: Luna Inalterable o Prototipo Ámbar.
Artefactos: Perla Oceánica (4) o Doncella Amada (4).', 'Arenas del Eón: Vida %.
Cáliz de Eonothem: Vida %.
Tiara de Logos: Vida % o Bono de Curación.
Subestadísticas: Vida %.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-14302"],"alternativas":["gi-w-14506","gi-w-14406"]},"artefactos":[{"conjuntos":["gi-artifact-15022"],"piezas":"4"},{"conjuntos":["gi-artifact-14004"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Vida %"],"caliz":["Vida %"],"tiara":["Vida %","Bono de Curación"]},"secundarias":["Vida %"]}'::jsonb),
  ('genshin-impact', 'gi-beidou', 'General', 'Arma ideal: Mil Soles Abrasadores.
Otras armas que le van bien: Emblema del Mar de Juncos, Lápida del Lobo, Médula de la Serpiente Marina o Gran Espada de Favonius.
Artefactos: Emblema del Destino (4).', 'Arenas del Eón: ATQ % o Recarga de Energía.
Cáliz de Eonothem: Bono de Daño Electro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: ATQ %, Prob. CRIT, Daño CRIT.', null, 'Game8', '{"rol":"DPS secundario","armas":{"ideales":["gi-w-12514"],"alternativas":["gi-w-12511","gi-w-12502","gi-w-12409","gi-w-12401"]},"artefactos":[{"conjuntos":["gi-artifact-15020"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %","Recarga de Energía"],"caliz":["Bono de Daño Electro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["ATQ %","Prob. CRIT","Daño CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-bennett', 'General', 'Arma ideal: Reflejo de las Tinieblas.
Otras armas que le van bien: Aquila Favonia, Hoja Afilada Celestial, Espada de Favonius, Juramento por la Libertad o Vado del Río Ceniciento.
Artefactos: Ritual Antiguo de la Nobleza (4).
Alternativas: Emblema del Destino (4) o Pergamino del Héroe de la Ciudad de las Cenizas (4).', 'Arenas del Eón: Recarga de Energía o ATQ %.
Cáliz de Eonothem: Bono de Daño Pyro o Vida %.
Tiara de Logos: Prob. CRIT, Vida % o Daño CRIT.
Subestadísticas: Recarga de Energía, Prob. CRIT, Daño CRIT, ATQ %, Vida %.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-11509"],"alternativas":["gi-w-11501","gi-w-11502","gi-w-11401","gi-w-11503","gi-w-11426"]},"artefactos":[{"conjuntos":["gi-artifact-15007"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15020"],"piezas":"4"},{"conjuntos":["gi-artifact-15037"],"piezas":"4"}],"principales":{"arenas":["Recarga de Energía","ATQ %"],"caliz":["Bono de Daño Pyro","Vida %"],"tiara":["Prob. CRIT","Vida %","Daño CRIT"]},"secundarias":["Recarga de Energía","Prob. CRIT","Daño CRIT","ATQ %","Vida %"]}'::jsonb),
  ('genshin-impact', 'gi-candace', 'General', 'Arma ideal: La Captura.
Otras armas que le van bien: Báculo de Homa, Púa Celestial, Lanza de Favonius o Retribución de la Justicia.
Artefactos: Emblema del Destino (4).', 'Arenas del Eón: Recarga de Energía o Vida %.
Cáliz de Eonothem: Vida % o Bono de Daño Hydro.
Tiara de Logos: Vida %, Prob. CRIT o Daño CRIT.
Subestadísticas: Recarga de Energía, Prob. CRIT, Daño CRIT, Vida %, Maestría Elemental.', null, 'Game8', '{"rol":"DPS secundario","armas":{"ideales":["gi-w-13415"],"alternativas":["gi-w-13501","gi-w-13502","gi-w-13407","gi-w-13425"]},"artefactos":[{"conjuntos":["gi-artifact-15020"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Recarga de Energía","Vida %"],"caliz":["Vida %","Bono de Daño Hydro"],"tiara":["Vida %","Prob. CRIT","Daño CRIT"]},"secundarias":["Recarga de Energía","Prob. CRIT","Daño CRIT","Vida %","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-charlotte', 'General', 'Arma ideal: Códice de Favonius.
Otras armas que le van bien: Pergamino Celestial, Ojo del Juramento o Fluencia Impoluta.
Artefactos: Ritual Antiguo de la Nobleza (4) o Final del Gladiador (2) + Perla Oceánica (2).', 'Arenas del Eón: Recarga de Energía o ATQ %.
Cáliz de Eonothem: ATQ %.
Tiara de Logos: Bono de Curación o ATQ %.
Subestadísticas: ATQ %, Recarga de Energía.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-14401"],"alternativas":["gi-w-14501","gi-w-14415","gi-w-14425"]},"artefactos":[{"conjuntos":["gi-artifact-15007"],"piezas":"4"},{"conjuntos":["gi-artifact-15001","gi-artifact-15022"],"piezas":"2+2"}],"artefactosAlternativos":[],"principales":{"arenas":["Recarga de Energía","ATQ %"],"caliz":["ATQ %"],"tiara":["Bono de Curación","ATQ %"]},"secundarias":["ATQ %","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-chasca', 'General', 'Arma ideal: Pluma Carmesí Buitreastral.
Otras armas que le van bien: Aqua Simulacra, El Primer Gran Número de Magia, Descendientes del Sol Abrasador o Rompecadenas.
Artefactos: Códice de Obsidiana (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: ATQ %.
Tiara de Logos: Daño CRIT o Prob. CRIT.
Subestadísticas: Daño CRIT, Prob. CRIT, ATQ %, Maestría Elemental.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-15514"],"alternativas":["gi-w-15508","gi-w-15512","gi-w-15424","gi-w-15431"]},"artefactos":[{"conjuntos":["gi-artifact-15038"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["ATQ %"],"tiara":["Daño CRIT","Prob. CRIT"]},"secundarias":["Daño CRIT","Prob. CRIT","ATQ %","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-chevreuse', 'General', 'Arma ideal: Borla Negra.
Otras armas que le van bien: Discusión de los Sabios del Desierto, Lanza de Favonius o Retribución de la Justicia.
Artefactos: Ritual Antiguo de la Nobleza (4) o Son de Antaño (4).', 'Arenas del Eón: Vida % o Recarga de Energía.
Cáliz de Eonothem: Vida %.
Tiara de Logos: Vida % o Bono de Curación.
Subestadísticas: Vida %, Recarga de Energía.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-13303"],"alternativas":["gi-w-13426","gi-w-13407","gi-w-13425"]},"artefactos":[{"conjuntos":["gi-artifact-15007"],"piezas":"4"},{"conjuntos":["gi-artifact-15033"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Vida %","Recarga de Energía"],"caliz":["Vida %"],"tiara":["Vida %","Bono de Curación"]},"secundarias":["Vida %","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-chiori', 'General', 'Arma ideal: Cortatelones de Urakusai.
Otras armas que le van bien: Cortador de Jade Primordial, Reflejo de las Tinieblas, Huso de Cinabrio o Flauta de Ezpitzal.
Artefactos: Compañía Dorada (4) o Cáscara de Sueños Opulentos (4).', 'Arenas del Eón: DEF % o ATQ %.
Cáliz de Eonothem: Bono de Daño Geo.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Prob. CRIT, Daño CRIT, DEF %, ATQ %.', null, 'Game8', '{"rol":"DPS secundario","armas":{"ideales":["gi-w-11514"],"alternativas":["gi-w-11505","gi-w-11509","gi-w-11415","gi-w-11431"]},"artefactos":[{"conjuntos":["gi-artifact-15032"],"piezas":"4"},{"conjuntos":["gi-artifact-15021"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["DEF %","ATQ %"],"caliz":["Bono de Daño Geo"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Prob. CRIT","Daño CRIT","DEF %","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-chongyun', 'General', 'Arma ideal: Lápida del Lobo.
Otras armas que le van bien: Emblema del Mar de Juncos, Médula de la Serpiente Marina, Sombra de la Marea o Gran Espada de Favonius.
Artefactos: Emblema del Destino (4).', 'Arenas del Eón: ATQ % o Recarga de Energía.
Cáliz de Eonothem: Bono de Daño Cryo.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Recarga de Energía, Prob. CRIT, Daño CRIT, ATQ %, Maestría Elemental.', null, 'Game8', '{"rol":"DPS secundario","armas":{"ideales":["gi-w-12502"],"alternativas":["gi-w-12511","gi-w-12409","gi-w-12425","gi-w-12401"]},"artefactos":[{"conjuntos":["gi-artifact-15020"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %","Recarga de Energía"],"caliz":["Bono de Daño Cryo"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Recarga de Energía","Prob. CRIT","Daño CRIT","ATQ %","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-citlali', 'General', 'Arma ideal: Vigía de las Estrellas.
Otras armas que le van bien: Sueños de las Mil Noches, Estrella Errabunda, Memorias de Sacrificios, Cuentos de Cazadores de Dragones, Carta Náutica o Guía Mágica.
Artefactos: Pergamino del Héroe de la Ciudad de las Cenizas (4).', 'Arenas del Eón: Maestría Elemental.
Cáliz de Eonothem: Maestría Elemental.
Tiara de Logos: Maestría Elemental.
Subestadísticas: Maestría Elemental, Recarga de Energía.', null, 'Game8', '{"rol":"Apoyo y escudo","armas":{"ideales":["gi-w-14517"],"alternativas":["gi-w-14511","gi-w-14416","gi-w-14403","gi-w-14302","gi-w-14407","gi-w-14301"]},"artefactos":[{"conjuntos":["gi-artifact-15037"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Maestría Elemental"],"caliz":["Maestría Elemental"],"tiara":["Maestría Elemental"]},"secundarias":["Maestría Elemental","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-clorinde', 'General', 'Arma ideal: Expiadora.
Otras armas que le van bien: Luna Ondulante de Futsu, Cortador de Jade Primordial, Espada Negra o Réquiem Abisal.
Artefactos: Fragmento de la Armonía Fantasiosa (4) o Furia del Trueno (4).', 'Arenas del Eón: ATQ % o Maestría Elemental.
Cáliz de Eonothem: Bono de Daño Electro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Prob. CRIT, Daño CRIT, Recarga de Energía, ATQ %.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-11515"],"alternativas":["gi-w-11510","gi-w-11505","gi-w-11409","gi-w-11425"]},"artefactos":[{"conjuntos":["gi-artifact-15035"],"piezas":"4"},{"conjuntos":["gi-artifact-15005"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %","Maestría Elemental"],"caliz":["Bono de Daño Electro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Prob. CRIT","Daño CRIT","Recarga de Energía","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-collei', 'General', 'Arma ideal: Estrella Invernal.
Otras armas que le van bien: Aqua Simulacra, Elegía del Fin o Arco de Favonius.
Artefactos: Recuerdos del Bosque (4).', 'Arenas del Eón: Recarga de Energía, ATQ % o Maestría Elemental.
Cáliz de Eonothem: Bono de Daño Dendro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Recarga de Energía, Prob. CRIT, Daño CRIT, ATQ %, Maestría Elemental.', null, 'Game8', '{"rol":"DPS secundario","armas":{"ideales":["gi-w-15507"],"alternativas":["gi-w-15508","gi-w-15503","gi-w-15401"]},"artefactos":[{"conjuntos":["gi-artifact-15025"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Recarga de Energía","ATQ %","Maestría Elemental"],"caliz":["Bono de Daño Dendro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Recarga de Energía","Prob. CRIT","Daño CRIT","ATQ %","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-columbina', 'General', 'Arma ideal: Nocturno tras el Velo.
Otras armas que le van bien: Relicario de la Verdad, Jade Sacrificial, Prototipo Ámbar, Códice de Favonius, Hora de Surfear, Escrituras del Fluir Sempiterno o Volver de las Olas.
Artefactos: Serenata de la Luna Tejida (4) o Alborada de la Estrella del Alba y la Luna (4).', 'Arenas del Eón: Vida % o Recarga de Energía.
Cáliz de Eonothem: Vida %.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Vida %, Recarga de Energía, Prob. CRIT, Maestría Elemental.', null, 'Game8', '{"rol":"Apoyo (Lunar Reactions)","armas":{"ideales":["gi-w-14522"],"alternativas":["gi-w-14521","gi-w-14424","gi-w-14406","gi-w-14401","gi-w-14516","gi-w-14514","gi-w-14430"]},"artefactos":[{"conjuntos":["gi-artifact-15042"],"piezas":"4"},{"conjuntos":["gi-artifact-15043"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Vida %","Recarga de Energía"],"caliz":["Vida %"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Vida %","Recarga de Energía","Prob. CRIT","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-cyno', 'General', 'Arma ideal: Báculo de las Arenas Escarlatas.
Otras armas que le van bien: Báculo de Homa, Halcón de Jade, Balada de los Fiordos o Borla Blanca.
Artefactos: Desilusión Congelada en las Sombras (4).
Alternativas: Sueños Áureos (4) o Furia del Trueno (4).', 'Arenas del Eón: Maestría Elemental.
Cáliz de Eonothem: Bono de Daño Electro.
Tiara de Logos: Daño CRIT o Prob. CRIT.
Subestadísticas: Daño CRIT, Prob. CRIT, Recarga de Energía, Maestría Elemental.', null, 'Game8', '{"rol":"DPS principal (Stellar Conduct)","armas":{"ideales":["gi-w-13511"],"alternativas":["gi-w-13501","gi-w-13505","gi-w-13424","gi-w-13301"]},"artefactos":[{"conjuntos":["gi-artifact-15046"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15026"],"piezas":"4"},{"conjuntos":["gi-artifact-15005"],"piezas":"4"}],"principales":{"arenas":["Maestría Elemental"],"caliz":["Bono de Daño Electro"],"tiara":["Daño CRIT","Prob. CRIT"]},"secundarias":["Daño CRIT","Prob. CRIT","Recarga de Energía","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-dahlia', 'General', 'Arma ideal: Espada de Favonius.
Otras armas que le van bien: Llave de la Coronación, Hoja Afilada Celestial, Espada de Sacrificio, Sable de la Dársena o Vado del Río Ceniciento.
Artefactos: Ritual Antiguo de la Nobleza (4) o Emblema del Destino (2) + Tenacidad de la Geoarmada (2).', 'Arenas del Eón: Vida % o Recarga de Energía.
Cáliz de Eonothem: Vida %.
Tiara de Logos: Vida % o Prob. CRIT.
Subestadísticas: Recarga de Energía, Vida %.', null, 'Game8', '{"rol":"Apoyo y escudo","armas":{"ideales":["gi-w-11401"],"alternativas":["gi-w-11511","gi-w-11502","gi-w-11403","gi-w-11427","gi-w-11426"]},"artefactos":[{"conjuntos":["gi-artifact-15007"],"piezas":"4"},{"conjuntos":["gi-artifact-15020","gi-artifact-15017"],"piezas":"2+2"}],"artefactosAlternativos":[],"principales":{"arenas":["Vida %","Recarga de Energía"],"caliz":["Vida %"],"tiara":["Vida %","Prob. CRIT"]},"secundarias":["Recarga de Energía","Vida %"]}'::jsonb),
  ('genshin-impact', 'gi-dehya', 'General', 'Arma ideal: Gran Espada de Favonius.
Otras armas que le van bien: Fierro Floriorlado, Májaira Aguamarina o Terragitador.
Artefactos: Pergamino del Héroe de la Ciudad de las Cenizas (4).', 'Arenas del Eón: Vida % o Maestría Elemental.
Cáliz de Eonothem: Vida % o Maestría Elemental.
Tiara de Logos: Vida %, Maestría Elemental o Prob. CRIT.
Subestadísticas: Vida %, Maestría Elemental.', null, 'Game8', '{"rol":"DPS secundario","armas":{"ideales":["gi-w-12401"],"alternativas":["gi-w-12418","gi-w-12415","gi-w-12431"]},"artefactos":[{"conjuntos":["gi-artifact-15037"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Vida %","Maestría Elemental"],"caliz":["Vida %","Maestría Elemental"],"tiara":["Vida %","Maestría Elemental","Prob. CRIT"]},"secundarias":["Vida %","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-diluc', 'General', 'Arma ideal: Espadón Cornirrojo.
Otras armas que le van bien: Emblema del Mar de Juncos, Mil Soles Abrasadores, Lápida del Lobo, Médula de la Serpiente Marina o Segadora de la Lluvia.
Artefactos: Bruja Carmesí en Llamas (4) o Cazador Fantasmal (4).', 'Arenas del Eón: Maestría Elemental o ATQ %.
Cáliz de Eonothem: Bono de Daño Pyro.
Tiara de Logos: Daño CRIT o Prob. CRIT.
Subestadísticas: Daño CRIT, Prob. CRIT, Maestría Elemental, Recarga de Energía, ATQ %.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-12510"],"alternativas":["gi-w-12511","gi-w-12514","gi-w-12502","gi-w-12409","gi-w-12405"]},"artefactos":[{"conjuntos":["gi-artifact-15006"],"piezas":"4"},{"conjuntos":["gi-artifact-15031"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Maestría Elemental","ATQ %"],"caliz":["Bono de Daño Pyro"],"tiara":["Daño CRIT","Prob. CRIT"]},"secundarias":["Daño CRIT","Prob. CRIT","Maestría Elemental","Recarga de Energía","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-diona', 'General', 'Arma ideal: Elegía del Fin.
Otras armas que le van bien: Arco del Sacrificio, Arco de Favonius o Arco Recurvo.
Artefactos: Ritual Antiguo de la Nobleza (4).', 'Arenas del Eón: Vida %.
Cáliz de Eonothem: Vida %.
Tiara de Logos: Vida %, Bono de Curación o Prob. CRIT.
Subestadísticas: Recarga de Energía, Vida %, Prob. CRIT.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-15503"],"alternativas":["gi-w-15403","gi-w-15401","gi-w-15303"]},"artefactos":[{"conjuntos":["gi-artifact-15007"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Vida %"],"caliz":["Vida %"],"tiara":["Vida %","Bono de Curación","Prob. CRIT"]},"secundarias":["Recarga de Energía","Vida %","Prob. CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-dori', 'General', 'Arma ideal: Gran Espada de Favonius.
Otras armas que le van bien: Lápida del Lobo, Espada Real del Bosque o Espada del Tiempo.
Artefactos: Ritual Antiguo de la Nobleza (4).', 'Arenas del Eón: Recarga de Energía o Vida %.
Cáliz de Eonothem: Vida %.
Tiara de Logos: Vida % o Bono de Curación.
Subestadísticas: Recarga de Energía, Vida %, ATQ %, Prob. CRIT.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-12401"],"alternativas":["gi-w-12502","gi-w-12417","gi-w-12402"]},"artefactos":[{"conjuntos":["gi-artifact-15007"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Recarga de Energía","Vida %"],"caliz":["Vida %"],"tiara":["Vida %","Bono de Curación"]},"secundarias":["Recarga de Energía","Vida %","ATQ %","Prob. CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-durin', 'General', 'Arma ideal: Athame Artis.
Otras armas que le van bien: Juramento por la Libertad, Expiadora, Cortador de Jade Primordial, Fulgor Cerúleo, Rugido del León, Colmillo Lupino, Espada Amenoma Gemela o Espada del Alba.
Artefactos: Día de los Vientos Alzantes (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Pyro o ATQ %.
Tiara de Logos: Daño CRIT o Prob. CRIT.
Subestadísticas: ATQ %, Maestría Elemental, Prob. CRIT, Daño CRIT.', null, 'Game8', '{"rol":"DPS secundario","armas":{"ideales":["gi-w-11518"],"alternativas":["gi-w-11503","gi-w-11515","gi-w-11505","gi-w-11517","gi-w-11405","gi-w-11424","gi-w-11414","gi-w-11302"]},"artefactos":[{"conjuntos":["gi-artifact-15044"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Pyro","ATQ %"],"tiara":["Daño CRIT","Prob. CRIT"]},"secundarias":["ATQ %","Maestría Elemental","Prob. CRIT","Daño CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-emilie', 'General', 'Arma ideal: Elegía Lumidulce.
Otras armas que le van bien: Pacificadora del Desastre, Halcón de Jade, Lanza del Duelo, Taladradora de Prospección o Charla en el Pabellón.
Artefactos: Ensoñación Inacabada (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Dendro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: ATQ %, Prob. CRIT, Daño CRIT, Recarga de Energía.', null, 'Game8', '{"rol":"DPS secundario (Burn)","armas":{"ideales":["gi-w-13513"],"alternativas":["gi-w-13507","gi-w-13505","gi-w-13405","gi-w-13427","gi-w-13432"]},"artefactos":[{"conjuntos":["gi-artifact-15036"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Dendro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["ATQ %","Prob. CRIT","Daño CRIT","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-escoffier', 'General', 'Arma ideal: Sinfonista de Aromas.
Otras armas que le van bien: Báculo Rutilante de la Sacerdotisa, Báculo de Homa, Luz del Segador, Taladradora de Prospección, Charla en el Pabellón o Lanza de Favonius.
Artefactos: Compañía Dorada (4).', 'Arenas del Eón: ATQ % o Recarga de Energía.
Cáliz de Eonothem: Bono de Daño Cryo o ATQ %.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, Recarga de Energía.', null, 'Game8', '{"rol":"DPS secundario (Freeze)","armas":{"ideales":["gi-w-13514"],"alternativas":["gi-w-13434","gi-w-13501","gi-w-13509","gi-w-13427","gi-w-13432","gi-w-13407"]},"artefactos":[{"conjuntos":["gi-artifact-15032"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %","Recarga de Energía"],"caliz":["Bono de Daño Cryo","ATQ %"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-eula', 'General', 'Arma ideal: Oda de los Pinos.
Otras armas que le van bien: Cantar de Gesta del Lobo, Emblema del Mar de Juncos, Lápida del Lobo o Médula de la Serpiente Marina.
Artefactos: Llamas Albinas (4).
Alternativas: Llamas Albinas (2) + Caballería Sanguinaria (2).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Físico.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Recarga de Energía, Daño CRIT, Prob. CRIT, ATQ %.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-12503"],"alternativas":["gi-w-12515","gi-w-12511","gi-w-12502","gi-w-12409"]},"artefactos":[{"conjuntos":["gi-artifact-15018"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15018","gi-artifact-15008"],"piezas":"2+2"}],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Físico"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Recarga de Energía","Daño CRIT","Prob. CRIT","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-faruzan', 'General', 'Arma ideal: Arco de Favonius.
Otras armas que le van bien: Alas Celestiales, Elegía del Fin, Arco del Sacrificio, Desvanecimiento del Crepúsculo o Fin de las Aguas.
Artefactos: Ritual Antiguo de la Nobleza (4).', 'Arenas del Eón: Recarga de Energía o ATQ %.
Cáliz de Eonothem: Bono de Daño Anemo.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Recarga de Energía, Prob. CRIT, Daño CRIT.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-15401"],"alternativas":["gi-w-15501","gi-w-15503","gi-w-15403","gi-w-15411","gi-w-15418"]},"artefactos":[{"conjuntos":["gi-artifact-15007"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Recarga de Energía","ATQ %"],"caliz":["Bono de Daño Anemo"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Recarga de Energía","Prob. CRIT","Daño CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-fischl', 'General', 'Arma ideal: Estrella Invernal.
Otras armas que le van bien: Aqua Simulacra, Alas Celestiales o Último Acorde.
Artefactos: Compañía Dorada (4).', 'Arenas del Eón: ATQ % o Maestría Elemental.
Cáliz de Eonothem: Bono de Daño Electro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %.', null, 'Game8', '{"rol":"DPS secundario (Hexerei)","armas":{"ideales":["gi-w-15507"],"alternativas":["gi-w-15508","gi-w-15501","gi-w-15402"]},"artefactos":[{"conjuntos":["gi-artifact-15032"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %","Maestría Elemental"],"caliz":["Bono de Daño Electro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-flins', 'General', 'Arma ideal: Ruinas Ensangrentadas.
Otras armas que le van bien: Báculo de las Arenas Escarlatas, Halcón de Jade, Halo Fracturado, Alabarda del Viento Epistolar o Azada Excavatesoros.
Artefactos: Noche de la Revelación del Cielo (4).
Alternativas: Sueños Áureos (2) + Final del Gladiador (2).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: ATQ %.
Tiara de Logos: Daño CRIT o Prob. CRIT.
Subestadísticas: Recarga de Energía, ATQ %, Daño CRIT, Prob. CRIT, Maestría Elemental.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-13516"],"alternativas":["gi-w-13511","gi-w-13505","gi-w-13515","gi-w-13419","gi-w-13433"]},"artefactos":[{"conjuntos":["gi-artifact-15041"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15026","gi-artifact-15001"],"piezas":"2+2"}],"principales":{"arenas":["ATQ %"],"caliz":["ATQ %"],"tiara":["Daño CRIT","Prob. CRIT"]},"secundarias":["Recarga de Energía","ATQ %","Daño CRIT","Prob. CRIT","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-freminet', 'General', 'Arma ideal: Oda de los Pinos.
Otras armas que le van bien: Lápida del Lobo, Prototipo Arcaico, Argento Estelar de las Nieves o Médula de la Serpiente Marina.
Artefactos: Llamas Albinas (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Físico o ATQ %.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: ATQ %, Prob. CRIT, Daño CRIT, Maestría Elemental.', null, 'Game8', '{"rol":null,"armas":{"ideales":["gi-w-12503"],"alternativas":["gi-w-12502","gi-w-12406","gi-w-12411","gi-w-12409"]},"artefactos":[{"conjuntos":["gi-artifact-15018"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Físico","ATQ %"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["ATQ %","Prob. CRIT","Daño CRIT","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-furina', 'General', 'Arma ideal: Fulgor de las Aguas Calmas.
Otras armas que le van bien: Llave de la Coronación, Cortatelones de Urakusai, Deseo Ponzoñoso, Vado del Río Ceniciento o Espada de Favonius.
Artefactos: Compañía Dorada (4).
Alternativas: Tenacidad de la Geoarmada (4).', 'Arenas del Eón: Vida % o Recarga de Energía.
Cáliz de Eonothem: Vida % o Bono de Daño Hydro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Vida %, Recarga de Energía, ATQ %, Maestría Elemental.', null, 'Game8', '{"rol":"DPS secundario y apoyo","armas":{"ideales":["gi-w-11513"],"alternativas":["gi-w-11511","gi-w-11514","gi-w-11413","gi-w-11426","gi-w-11401"]},"artefactos":[{"conjuntos":["gi-artifact-15032"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15017"],"piezas":"4"}],"principales":{"arenas":["Vida %","Recarga de Energía"],"caliz":["Vida %","Bono de Daño Hydro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Vida %","Recarga de Energía","ATQ %","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-gaming', 'General', 'Arma ideal: Médula de la Serpiente Marina.
Otras armas que le van bien: Espadón Cornirrojo, Emblema del Mar de Juncos, Sentenciadora, Segadora de la Lluvia, Gancho del Triunfo o Superespada Mágica Suprema.
Artefactos: Cazador Fantasmal (4).', 'Arenas del Eón: Maestría Elemental o ATQ %.
Cáliz de Eonothem: Bono de Daño Pyro.
Tiara de Logos: Daño CRIT.
Subestadísticas: Daño CRIT, Recarga de Energía, Maestría Elemental, Prob. CRIT, ATQ %.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-12409"],"alternativas":["gi-w-12510","gi-w-12511","gi-w-12512","gi-w-12405","gi-w-12430","gi-w-12426"]},"artefactos":[{"conjuntos":["gi-artifact-15031"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Maestría Elemental","ATQ %"],"caliz":["Bono de Daño Pyro"],"tiara":["Daño CRIT"]},"secundarias":["Daño CRIT","Recarga de Energía","Maestría Elemental","Prob. CRIT","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-ganyu', 'General', 'Arma ideal: El Primer Gran Número de Magia.
Otras armas que le van bien: Pluma Carmesí Buitreastral, Aqua Simulacra, Arco de Amos o Prototipo Luz de Luna.
Artefactos: Nómada del Invierno (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Cryo.
Tiara de Logos: Daño CRIT o Prob. CRIT.
Subestadísticas: ATQ %, Prob. CRIT, Daño CRIT, Maestría Elemental.', null, 'Game8', '{"rol":"DPS principal (Freeze)","armas":{"ideales":["gi-w-15512"],"alternativas":["gi-w-15514","gi-w-15508","gi-w-15502","gi-w-15406"]},"artefactos":[{"conjuntos":["gi-artifact-14001"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Cryo"],"tiara":["Daño CRIT","Prob. CRIT"]},"secundarias":["ATQ %","Prob. CRIT","Daño CRIT","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-gorou', 'General', 'Arma ideal: Elegía del Fin.
Otras armas que le van bien: Arco de Favonius o Arco del Sacrificio.
Artefactos: Cáscara de Sueños Opulentos (2) + Emblema del Destino (2).', 'Arenas del Eón: DEF % o Recarga de Energía.
Cáliz de Eonothem: DEF %.
Tiara de Logos: DEF % o Prob. CRIT.
Subestadísticas: DEF %, Recarga de Energía, Prob. CRIT.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-15503"],"alternativas":["gi-w-15401","gi-w-15403"]},"artefactos":[{"conjuntos":["gi-artifact-15021","gi-artifact-15020"],"piezas":"2+2"}],"artefactosAlternativos":[],"principales":{"arenas":["DEF %","Recarga de Energía"],"caliz":["DEF %"],"tiara":["DEF %","Prob. CRIT"]},"secundarias":["DEF %","Recarga de Energía","Prob. CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-heizou', 'General', 'Arma ideal: Reminiscencia de Tulaytulah.
Otras armas que le van bien: Axioma de la Kagura, Oración Perdida a los Vientos Sagrados o Sinfonía de los Merodeadores.
Artefactos: Sombra Verde Esmeralda (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Anemo.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, Maestría Elemental.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-14512"],"alternativas":["gi-w-14509","gi-w-14502","gi-w-14402"]},"artefactos":[{"conjuntos":["gi-artifact-15002"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Anemo"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-hu-tao', 'General', 'Arma ideal: Báculo de Homa.
Otras armas que le van bien: Báculo de las Arenas Escarlatas, Balada de los Fiordos o Perdición del Dragón.
Artefactos: Bruja Carmesí en Llamas (4).', 'Arenas del Eón: Vida %.
Cáliz de Eonothem: Bono de Daño Pyro.
Tiara de Logos: Daño CRIT o Prob. CRIT.
Subestadísticas: Prob. CRIT, Daño CRIT, Vida %, Maestría Elemental.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-13501"],"alternativas":["gi-w-13511","gi-w-13424","gi-w-13401"]},"artefactos":[{"conjuntos":["gi-artifact-15006"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Vida %"],"caliz":["Bono de Daño Pyro"],"tiara":["Daño CRIT","Prob. CRIT"]},"secundarias":["Prob. CRIT","Daño CRIT","Vida %","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-iansan', 'General', 'Arma ideal: Sinfonista de Aromas.
Otras armas que le van bien: Pacificadora del Desastre, Charla en el Pabellón o Lanza de Favonius.
Artefactos: Pergamino del Héroe de la Ciudad de las Cenizas (4).', 'Arenas del Eón: ATQ % o Recarga de Energía.
Cáliz de Eonothem: ATQ %.
Tiara de Logos: ATQ %.
Subestadísticas: Recarga de Energía, ATQ %.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-13514"],"alternativas":["gi-w-13507","gi-w-13432","gi-w-13407"]},"artefactos":[{"conjuntos":["gi-artifact-15037"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %","Recarga de Energía"],"caliz":["ATQ %"],"tiara":["ATQ %"]},"secundarias":["Recarga de Energía","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-ifa', 'General', 'Arma ideal: Hibernación Matutina de Año Nuevo.
Otras armas que le van bien: Sueños de las Mil Noches, Estrella Errabunda, Memorias de Sacrificios o Carta Náutica.
Artefactos: Sombra Verde Esmeralda (4).', 'Arenas del Eón: Maestría Elemental.
Cáliz de Eonothem: Maestría Elemental.
Tiara de Logos: Maestría Elemental.
Subestadísticas: Maestría Elemental, Recarga de Energía.', null, 'Game8', '{"rol":"DPS principal (Swirl)","armas":{"ideales":["gi-w-14518"],"alternativas":["gi-w-14511","gi-w-14416","gi-w-14403","gi-w-14407"]},"artefactos":[{"conjuntos":["gi-artifact-15002"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Maestría Elemental"],"caliz":["Maestría Elemental"],"tiara":["Maestría Elemental"]},"secundarias":["Maestría Elemental","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-illuga', 'General', 'Arma ideal: Lanza de Favonius.
Otras armas que le van bien: Perdición del Dragón, Cruz de Kitain o Báculo de las Arenas Escarlatas.
Artefactos: Serenata de la Luna Tejida (4).', 'Arenas del Eón: Maestría Elemental o Recarga de Energía.
Cáliz de Eonothem: Maestría Elemental.
Tiara de Logos: Maestría Elemental.
Subestadísticas: Maestría Elemental, Recarga de Energía, DEF %.', null, 'Game8', '{"rol":"Apoyo (Lunar Crystallize)","armas":{"ideales":["gi-w-13407"],"alternativas":["gi-w-13401","gi-w-13414","gi-w-13511"]},"artefactos":[{"conjuntos":["gi-artifact-15042"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Maestría Elemental","Recarga de Energía"],"caliz":["Maestría Elemental"],"tiara":["Maestría Elemental"]},"secundarias":["Maestría Elemental","Recarga de Energía","DEF %"]}'::jsonb),
  ('genshin-impact', 'gi-ineffa', 'General', 'Arma ideal: Halo Fracturado.
Otras armas que le van bien: Báculo de las Arenas Escarlatas, Ruinas Ensangrentadas, Azada Excavatesoros o Lanza del Duelo.
Artefactos: Alborada de la Estrella del Alba y la Luna (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: ATQ %.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Daño CRIT, Prob. CRIT, ATQ %, Maestría Elemental.', null, 'Game8', '{"rol":null,"armas":{"ideales":["gi-w-13515"],"alternativas":["gi-w-13511","gi-w-13516","gi-w-13433","gi-w-13405"]},"artefactos":[{"conjuntos":["gi-artifact-15043"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["ATQ %"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Daño CRIT","Prob. CRIT","ATQ %","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-jahoda', 'General', 'Arma ideal: Elegía del Fin.
Otras armas que le van bien: Aqua Simulacra, Arco de Favonius, Gancho Trampero, Arco del Sacrificio, Cazador del Callejón, Fin de las Aguas o Oda a las Flores de Viento.
Artefactos: Sombra Verde Esmeralda (4).', 'Arenas del Eón: Recarga de Energía o ATQ %.
Cáliz de Eonothem: ATQ %.
Tiara de Logos: ATQ %, Bono de Curación o Prob. CRIT.
Subestadísticas: Recarga de Energía, ATQ %, Prob. CRIT, Daño CRIT, Maestría Elemental.', null, 'Game8', '{"rol":null,"armas":{"ideales":["gi-w-15503"],"alternativas":["gi-w-15508","gi-w-15401","gi-w-15433","gi-w-15403","gi-w-15410","gi-w-15418","gi-w-15413"]},"artefactos":[{"conjuntos":["gi-artifact-15002"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Recarga de Energía","ATQ %"],"caliz":["ATQ %"],"tiara":["ATQ %","Bono de Curación","Prob. CRIT"]},"secundarias":["Recarga de Energía","ATQ %","Prob. CRIT","Daño CRIT","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-jean', 'General', 'Arma ideal: Cortador de Jade Primordial.
Otras armas que le van bien: Espada de Sacrificio, Deseo Ponzoñoso o Espada Amenoma Gemela.
Artefactos: Final del Gladiador (2) + Sombra Verde Esmeralda (2).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Anemo.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: ATQ %, Recarga de Energía, Daño CRIT, Prob. CRIT, Maestría Elemental.', null, 'Game8', '{"rol":"DPS secundario","armas":{"ideales":["gi-w-11505"],"alternativas":["gi-w-11403","gi-w-11413","gi-w-11414"]},"artefactos":[{"conjuntos":["gi-artifact-15001","gi-artifact-15002"],"piezas":"2+2"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Anemo"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["ATQ %","Recarga de Energía","Daño CRIT","Prob. CRIT","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-kachina', 'General', 'Arma ideal: Estela Iridiscente.
Otras armas que le van bien: Luz del Segador, Lanza de Favonius o Lanza del Duelo.
Artefactos: Pergamino del Héroe de la Ciudad de las Cenizas (4).', 'Arenas del Eón: DEF %.
Cáliz de Eonothem: Bono de Daño Geo.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Daño CRIT, Prob. CRIT, DEF %, Recarga de Energía.', null, 'Game8', '{"rol":"DPS secundario","armas":{"ideales":["gi-w-13431"],"alternativas":["gi-w-13509","gi-w-13407","gi-w-13405"]},"artefactos":[{"conjuntos":["gi-artifact-15037"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["DEF %"],"caliz":["Bono de Daño Geo"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Daño CRIT","Prob. CRIT","DEF %","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-kaeya', 'General', 'Arma ideal: Reflejo de las Tinieblas.
Otras armas que le van bien: Cortador de Jade Primordial, Colmillo Lupino o Espada Negra.
Artefactos: Nómada del Invierno (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Cryo.
Tiara de Logos: Daño CRIT.
Subestadísticas: Daño CRIT, ATQ %, Prob. CRIT.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-11509"],"alternativas":["gi-w-11505","gi-w-11424","gi-w-11409"]},"artefactos":[{"conjuntos":["gi-artifact-14001"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Cryo"],"tiara":["Daño CRIT"]},"secundarias":["Daño CRIT","ATQ %","Prob. CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-kaveh', 'General', 'Arma ideal: Fierro Floriorlado.
Otras armas que le van bien: Májaira Aguamarina, Segadora de la Lluvia o Espada Real del Bosque.
Artefactos: Flor Olvidada del Paraíso (4).', 'Arenas del Eón: Maestría Elemental.
Cáliz de Eonothem: Maestría Elemental.
Tiara de Logos: Maestría Elemental.
Subestadísticas: Recarga de Energía, Maestría Elemental, Prob. CRIT, Daño CRIT, ATQ %.', null, 'Game8', '{"rol":"DPS principal (Bloom)","armas":{"ideales":["gi-w-12418"],"alternativas":["gi-w-12415","gi-w-12405","gi-w-12417"]},"artefactos":[{"conjuntos":["gi-artifact-15028"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Maestría Elemental"],"caliz":["Maestría Elemental"],"tiara":["Maestría Elemental"]},"secundarias":["Recarga de Energía","Maestría Elemental","Prob. CRIT","Daño CRIT","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-kazuha', 'General', 'Arma ideal: Juramento por la Libertad.
Otras armas que le van bien: Luz Lunar de Xifos, Espina de Hierro o Espada de Favonius.
Artefactos: Sombra Verde Esmeralda (4).', 'Arenas del Eón: Recarga de Energía o Maestría Elemental.
Cáliz de Eonothem: Maestría Elemental.
Tiara de Logos: Maestría Elemental.
Subestadísticas: Recarga de Energía, Maestría Elemental, Daño CRIT, Prob. CRIT, ATQ %.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-11503"],"alternativas":["gi-w-11418","gi-w-11407","gi-w-11401"]},"artefactos":[{"conjuntos":["gi-artifact-15002"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Recarga de Energía","Maestría Elemental"],"caliz":["Maestría Elemental"],"tiara":["Maestría Elemental"]},"secundarias":["Recarga de Energía","Maestría Elemental","Daño CRIT","Prob. CRIT","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-keqing', 'General', 'Arma ideal: Reflejo de las Tinieblas.
Otras armas que le van bien: Cortador de Jade Primordial, Espada Negra o Espada Amenoma Gemela.
Artefactos: Furia del Trueno (4).', 'Arenas del Eón: ATQ % o Maestría Elemental.
Cáliz de Eonothem: Bono de Daño Electro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, Maestría Elemental.', null, 'Game8', '{"rol":"DPS principal (Aggravate)","armas":{"ideales":["gi-w-11509"],"alternativas":["gi-w-11505","gi-w-11409","gi-w-11414"]},"artefactos":[{"conjuntos":["gi-artifact-15005"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %","Maestría Elemental"],"caliz":["Bono de Daño Electro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-kinich', 'General', 'Arma ideal: Colmillo del Rey de la Montaña.
Otras armas que le van bien: Emblema del Mar de Juncos, Médula de la Serpiente Marina o Terragitador.
Artefactos: Códice de Obsidiana (4) o Ensoñación Inacabada (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Dendro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Daño CRIT, Prob. CRIT, ATQ %, Recarga de Energía, Maestría Elemental.', null, 'Game8', '{"rol":"DPS principal (Burn)","armas":{"ideales":["gi-w-12513"],"alternativas":["gi-w-12511","gi-w-12409","gi-w-12431"]},"artefactos":[{"conjuntos":["gi-artifact-15038"],"piezas":"4"},{"conjuntos":["gi-artifact-15036"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Dendro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Daño CRIT","Prob. CRIT","ATQ %","Recarga de Energía","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-kirara', 'General', 'Arma ideal: Llave de la Coronación.
Otras armas que le van bien: Sable de la Dársena, Espada de Sacrificio, Espada de Favonius o Espada de Madera.
Artefactos: Tenacidad de la Geoarmada (2) + Fulgor de Vurukasha (2).', 'Arenas del Eón: Vida % o Recarga de Energía.
Cáliz de Eonothem: Vida %.
Tiara de Logos: Vida %.
Subestadísticas: Vida %, Recarga de Energía, Maestría Elemental.', null, 'Game8', '{"rol":"Apoyo y escudo","armas":{"ideales":["gi-w-11511"],"alternativas":["gi-w-11427","gi-w-11403","gi-w-11401","gi-w-11417"]},"artefactos":[{"conjuntos":["gi-artifact-15017","gi-artifact-15030"],"piezas":"2+2"}],"artefactosAlternativos":[],"principales":{"arenas":["Vida %","Recarga de Energía"],"caliz":["Vida %"],"tiara":["Vida %"]},"secundarias":["Vida %","Recarga de Energía","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-klee', 'General', 'Arma ideal: Oración Perdida a los Vientos Sagrados.
Otras armas que le van bien: Escrituras del Fluir Sempiterno, Cuentos de Dodoco, Sinfonía de los Merodeadores, Fluencia Impoluta, Perla Solar, Memorias de Sacrificios o Oda al Vasto Azul.
Artefactos: Día de los Vientos Alzantes (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Pyro.
Tiara de Logos: Daño CRIT o Prob. CRIT.
Subestadísticas: Daño CRIT, Prob. CRIT, ATQ %, Maestría Elemental.', null, 'Game8', '{"rol":null,"armas":{"ideales":["gi-w-14502"],"alternativas":["gi-w-14514","gi-w-14413","gi-w-14402","gi-w-14425","gi-w-14405","gi-w-14403","gi-w-14426"]},"artefactos":[{"conjuntos":["gi-artifact-15044"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Pyro"],"tiara":["Daño CRIT","Prob. CRIT"]},"secundarias":["Daño CRIT","Prob. CRIT","ATQ %","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-kokomi', 'General', 'Arma ideal: Luna Inalterable.
Otras armas que le van bien: Prototipo Ámbar, Anillo del Yaxché o Cuentos de Cazadores de Dragones.
Artefactos: Flor Olvidada del Paraíso (4).', 'Arenas del Eón: Maestría Elemental.
Cáliz de Eonothem: Maestría Elemental.
Tiara de Logos: Maestría Elemental.
Subestadísticas: Vida %, Recarga de Energía, Maestría Elemental.', null, 'Game8', '{"rol":"DPS principal (Bloom)","armas":{"ideales":["gi-w-14506"],"alternativas":["gi-w-14406","gi-w-14431","gi-w-14302"]},"artefactos":[{"conjuntos":["gi-artifact-15028"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Maestría Elemental"],"caliz":["Maestría Elemental"],"tiara":["Maestría Elemental"]},"secundarias":["Vida %","Recarga de Energía","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-kujou-sara', 'General', 'Arma ideal: Elegía del Fin.
Otras armas que le van bien: Alas Celestiales, Estrella Invernal, Rompecadenas o Arco del Sacrificio.
Artefactos: Emblema del Destino (4).', 'Arenas del Eón: Recarga de Energía o ATQ %.
Cáliz de Eonothem: Bono de Daño Electro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Recarga de Energía, Prob. CRIT, Daño CRIT, ATQ %.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-15503"],"alternativas":["gi-w-15501","gi-w-15507","gi-w-15431","gi-w-15403"]},"artefactos":[{"conjuntos":["gi-artifact-15020"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Recarga de Energía","ATQ %"],"caliz":["Bono de Daño Electro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Recarga de Energía","Prob. CRIT","Daño CRIT","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-kuki-shinobu', 'General', 'Arma ideal: Juramento por la Libertad.
Otras armas que le van bien: Luz Lunar de Xifos, Espina de Hierro o Diluvio Florífero.
Artefactos: Flor Olvidada del Paraíso (4).', 'Arenas del Eón: Maestría Elemental.
Cáliz de Eonothem: Maestría Elemental.
Tiara de Logos: Maestría Elemental.
Subestadísticas: Maestría Elemental, Vida %, Recarga de Energía.', null, 'Game8', '{"rol":null,"armas":{"ideales":["gi-w-11503"],"alternativas":["gi-w-11418","gi-w-11407","gi-w-11422"]},"artefactos":[{"conjuntos":["gi-artifact-15028"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Maestría Elemental"],"caliz":["Maestría Elemental"],"tiara":["Maestría Elemental"]},"secundarias":["Maestría Elemental","Vida %","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-lan-yan', 'General', 'Arma ideal: Candado Terrenal.
Otras armas que le van bien: Pergamino Celestial, Ojo del Juramento, Códice de Favonius o Cuentos de Cazadores de Dragones.
Artefactos: Sombra Verde Esmeralda (4) o Final del Gladiador (2) + Reminiscencia de la Purificación (2).', 'Arenas del Eón: ATQ % o Recarga de Energía.
Cáliz de Eonothem: ATQ %.
Tiara de Logos: ATQ %.
Subestadísticas: ATQ %, Recarga de Energía, Maestría Elemental.', null, 'Game8', '{"rol":"Apoyo y escudo","armas":{"ideales":["gi-w-14504"],"alternativas":["gi-w-14501","gi-w-14415","gi-w-14401","gi-w-14302"]},"artefactos":[{"conjuntos":["gi-artifact-15002"],"piezas":"4"},{"conjuntos":["gi-artifact-15001","gi-artifact-15019"],"piezas":"2+2"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %","Recarga de Energía"],"caliz":["ATQ %"],"tiara":["ATQ %"]},"secundarias":["ATQ %","Recarga de Energía","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-lauma', 'General', 'Arma ideal: Espejo Tejenoches.
Otras armas que le van bien: Laúd de la Luz Celestial, Sueños de las Mil Noches, Hibernación Matutina de Año Nuevo, Vigía de las Estrellas, Lámpara Medulaoscura o Memorias de Sacrificios.
Artefactos: Recuerdos del Bosque (4) o Serenata de la Luna Tejida (4).', 'Arenas del Eón: Maestría Elemental.
Cáliz de Eonothem: Maestría Elemental.
Tiara de Logos: Maestría Elemental, Prob. CRIT o Daño CRIT.
Subestadísticas: Maestría Elemental, Prob. CRIT, Daño CRIT, Recarga de Energía.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-14520"],"alternativas":["gi-w-14432","gi-w-14511","gi-w-14518","gi-w-14517","gi-w-14433","gi-w-14403"]},"artefactos":[{"conjuntos":["gi-artifact-15025"],"piezas":"4"},{"conjuntos":["gi-artifact-15042"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Maestría Elemental"],"caliz":["Maestría Elemental"],"tiara":["Maestría Elemental","Prob. CRIT","Daño CRIT"]},"secundarias":["Maestría Elemental","Prob. CRIT","Daño CRIT","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-layla', 'General', 'Arma ideal: Llave de la Coronación.
Otras armas que le van bien: Espada de Favonius, Juramento por la Libertad, Sable de la Dársena o Vado del Río Ceniciento.
Artefactos: Tenacidad de la Geoarmada (4).', 'Arenas del Eón: Vida %.
Cáliz de Eonothem: Vida % o Bono de Daño Cryo.
Tiara de Logos: Vida %, Prob. CRIT o Daño CRIT.
Subestadísticas: Vida %, Prob. CRIT, Daño CRIT, Recarga de Energía.', null, 'Game8', '{"rol":"Apoyo y escudo","armas":{"ideales":["gi-w-11511"],"alternativas":["gi-w-11401","gi-w-11503","gi-w-11427","gi-w-11426"]},"artefactos":[{"conjuntos":["gi-artifact-15017"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Vida %"],"caliz":["Vida %","Bono de Daño Cryo"],"tiara":["Vida %","Prob. CRIT","Daño CRIT"]},"secundarias":["Vida %","Prob. CRIT","Daño CRIT","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-linnea', 'General', 'Arma ideal: Rama del Juramento Escarchado.
Otras armas que le van bien: Aqua Simulacra, Estrella Invernal, Tirachinas, Último Acorde o Arco de Favonius.
Artefactos: Alborada de la Estrella del Alba y la Luna (4) o Cáscara de Sueños Opulentos (4).', 'Arenas del Eón: DEF %.
Cáliz de Eonothem: DEF %.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Prob. CRIT, Daño CRIT, DEF %, Maestría Elemental, Recarga de Energía.', null, 'Game8', '{"rol":"DPS secundario (Lunar Crystallize)","armas":{"ideales":["gi-w-15516"],"alternativas":["gi-w-15508","gi-w-15507","gi-w-15304","gi-w-15402","gi-w-15401"]},"artefactos":[{"conjuntos":["gi-artifact-15043"],"piezas":"4"},{"conjuntos":["gi-artifact-15021"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["DEF %"],"caliz":["DEF %"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Prob. CRIT","Daño CRIT","DEF %","Maestría Elemental","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-lisa', 'General', 'Arma ideal: Axioma de la Kagura.
Otras armas que le van bien: Pergamino Celestial, Sinfonía de los Merodeadores o Anillo de Hakushin.
Artefactos: Sueños Áureos (4).', 'Arenas del Eón: Maestría Elemental o ATQ %.
Cáliz de Eonothem: Bono de Daño Electro o Maestría Elemental.
Tiara de Logos: Prob. CRIT, Daño CRIT o Maestría Elemental.
Subestadísticas: Recarga de Energía, Maestría Elemental, Prob. CRIT, Daño CRIT.', null, 'Game8', '{"rol":"DPS secundario","armas":{"ideales":["gi-w-14509"],"alternativas":["gi-w-14501","gi-w-14402","gi-w-14414"]},"artefactos":[{"conjuntos":["gi-artifact-15026"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Maestría Elemental","ATQ %"],"caliz":["Bono de Daño Electro","Maestría Elemental"],"tiara":["Prob. CRIT","Daño CRIT","Maestría Elemental"]},"secundarias":["Recarga de Energía","Maestría Elemental","Prob. CRIT","Daño CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-lohen', 'General', 'Arma ideal: Desastre y Arrepentimiento.
Otras armas que le van bien: Báculo de Homa, Halo Fracturado, Halcón de Jade, Báculo Rutilante de la Sacerdotisa, Lanza del Duelo o Borla Blanca.
Artefactos: Día de los Vientos Alzantes (4).
Alternativas: Nómada del Invierno (2) + Reminiscencia de la Purificación (2).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Cryo o ATQ %.
Tiara de Logos: Daño CRIT o Prob. CRIT.
Subestadísticas: Daño CRIT, Prob. CRIT, ATQ %, Recarga de Energía.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-13517"],"alternativas":["gi-w-13501","gi-w-13515","gi-w-13505","gi-w-13434","gi-w-13405","gi-w-13301"]},"artefactos":[{"conjuntos":["gi-artifact-15044"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-14001","gi-artifact-15019"],"piezas":"2+2"}],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Cryo","ATQ %"],"tiara":["Daño CRIT","Prob. CRIT"]},"secundarias":["Daño CRIT","Prob. CRIT","ATQ %","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-lynette', 'General', 'Arma ideal: Espada de Favonius.
Otras armas que le van bien: Espada de Sacrificio, Juramento por la Libertad o Espada Amenoma Gemela.
Artefactos: Sombra Verde Esmeralda (4).
Alternativas: Emblema del Destino (4).', 'Arenas del Eón: ATQ % o Maestría Elemental.
Cáliz de Eonothem: Bono de Daño Anemo o Maestría Elemental.
Tiara de Logos: Prob. CRIT o Maestría Elemental.
Subestadísticas: Recarga de Energía, Prob. CRIT, ATQ %.', null, 'Game8', '{"rol":"DPS secundario","armas":{"ideales":["gi-w-11401"],"alternativas":["gi-w-11403","gi-w-11503","gi-w-11414"]},"artefactos":[{"conjuntos":["gi-artifact-15002"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15020"],"piezas":"4"}],"principales":{"arenas":["ATQ %","Maestría Elemental"],"caliz":["Bono de Daño Anemo","Maestría Elemental"],"tiara":["Prob. CRIT","Maestría Elemental"]},"secundarias":["Recarga de Energía","Prob. CRIT","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-lyney', 'General', 'Arma ideal: El Primer Gran Número de Magia.
Otras armas que le van bien: Aqua Simulacra, Agitador del Relámpago, Descendientes del Sol Abrasador o Serenata del Sosiego.
Artefactos: Cazador Fantasmal (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Pyro.
Tiara de Logos: Daño CRIT.
Subestadísticas: Daño CRIT, Recarga de Energía, Prob. CRIT, ATQ %.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-15512"],"alternativas":["gi-w-15508","gi-w-15509","gi-w-15424","gi-w-15425"]},"artefactos":[{"conjuntos":["gi-artifact-15031"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Pyro"],"tiara":["Daño CRIT"]},"secundarias":["Daño CRIT","Recarga de Energía","Prob. CRIT","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-mavuika', 'General', 'Arma ideal: Mil Soles Abrasadores.
Otras armas que le van bien: Emblema del Mar de Juncos, Lápida del Lobo, Llave de la Trascendencia, Médula de la Serpiente Marina, Fierro Floriorlado o Sombra de la Marea.
Artefactos: Códice de Obsidiana (4).
Alternativas: Pergamino del Héroe de la Ciudad de las Cenizas (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Pyro.
Tiara de Logos: Daño CRIT o Prob. CRIT.
Subestadísticas: Daño CRIT, Prob. CRIT, ATQ %, Maestría Elemental.', null, 'Game8', '{"rol":"DPS secundario","armas":{"ideales":["gi-w-12514"],"alternativas":["gi-w-12511","gi-w-12502","gi-w-12516","gi-w-12409","gi-w-12418","gi-w-12425"]},"artefactos":[{"conjuntos":["gi-artifact-15038"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15037"],"piezas":"4"}],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Pyro"],"tiara":["Daño CRIT","Prob. CRIT"]},"secundarias":["Daño CRIT","Prob. CRIT","ATQ %","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-mika', 'General', 'Arma ideal: Lanza de Favonius.
Otras armas que le van bien: Discusión de los Sabios del Desierto, Retribución de la Justicia o Borla Negra.
Artefactos: Ritual Antiguo de la Nobleza (4).', 'Arenas del Eón: Recarga de Energía o Vida %.
Cáliz de Eonothem: Vida %.
Tiara de Logos: Vida %, Bono de Curación o Prob. CRIT.
Subestadísticas: Recarga de Energía, Vida %.', null, 'Game8', '{"rol":"Apoyo y sanación","armas":{"ideales":["gi-w-13407"],"alternativas":["gi-w-13426","gi-w-13425","gi-w-13303"]},"artefactos":[{"conjuntos":["gi-artifact-15007"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Recarga de Energía","Vida %"],"caliz":["Vida %"],"tiara":["Vida %","Bono de Curación","Prob. CRIT"]},"secundarias":["Recarga de Energía","Vida %"]}'::jsonb),
  ('genshin-impact', 'gi-mizuki', 'General', 'Arma ideal: Hibernación Matutina de Año Nuevo.
Otras armas que le van bien: Relicario de la Verdad, Sueños de las Mil Noches, Sinfonía de los Merodeadores o Laúd de la Luz Celestial.
Artefactos: Sueños Áureos (4).
Alternativas: Testimonio Escarlata (4).', 'Arenas del Eón: Maestría Elemental.
Cáliz de Eonothem: Maestría Elemental.
Tiara de Logos: Maestría Elemental.
Subestadísticas: Prob. CRIT, Maestría Elemental, Recarga de Energía.', null, 'Game8', '{"rol":"DPS principal (Stellar Swirl)","armas":{"ideales":["gi-w-14518"],"alternativas":["gi-w-14521","gi-w-14511","gi-w-14402","gi-w-14432"]},"artefactos":[{"conjuntos":["gi-artifact-15026"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15047"],"piezas":"4"}],"principales":{"arenas":["Maestría Elemental"],"caliz":["Maestría Elemental"],"tiara":["Maestría Elemental"]},"secundarias":["Prob. CRIT","Maestría Elemental","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-mona', 'General', 'Arma ideal: Cuentos de Cazadores de Dragones.
Otras armas que le van bien: Prototipo Ámbar, Anillo de Hakushin o Códice de Favonius.
Artefactos: Ritual Antiguo de la Nobleza (4) o Son de Antaño (4).', 'Arenas del Eón: Recarga de Energía.
Cáliz de Eonothem: ATQ %.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Recarga de Energía, Prob. CRIT, Daño CRIT, ATQ %.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-14302"],"alternativas":["gi-w-14406","gi-w-14414","gi-w-14401"]},"artefactos":[{"conjuntos":["gi-artifact-15007"],"piezas":"4"},{"conjuntos":["gi-artifact-15033"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Recarga de Energía"],"caliz":["ATQ %"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Recarga de Energía","Prob. CRIT","Daño CRIT","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-mualani', 'General', 'Arma ideal: Hora de Surfear.
Otras armas que le van bien: Jade Sacrificial, Anillo del Yaxché, Escrituras del Fluir Sempiterno, Sueños de las Mil Noches o Cuerno Veteazulado.
Artefactos: Códice de Obsidiana (4) o Corazón de las Profundidades (4).', 'Arenas del Eón: Vida % o Maestría Elemental.
Cáliz de Eonothem: Bono de Daño Hydro o Vida %.
Tiara de Logos: Daño CRIT.
Subestadísticas: Daño CRIT, Vida %, Maestría Elemental, Prob. CRIT, Recarga de Energía.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-14516"],"alternativas":["gi-w-14424","gi-w-14431","gi-w-14514","gi-w-14511","gi-w-14427"]},"artefactos":[{"conjuntos":["gi-artifact-15038"],"piezas":"4"},{"conjuntos":["gi-artifact-15016"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Vida %","Maestría Elemental"],"caliz":["Bono de Daño Hydro","Vida %"],"tiara":["Daño CRIT"]},"secundarias":["Daño CRIT","Vida %","Maestría Elemental","Prob. CRIT","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-nahida', 'General', 'Arma ideal: Sueños de las Mil Noches.
Otras armas que le van bien: Memorias de Sacrificios, Guía Mágica, Estrella Errabunda, Carta Náutica o Sinfonía de los Merodeadores.
Artefactos: Recuerdos del Bosque (4).', 'Arenas del Eón: Maestría Elemental.
Cáliz de Eonothem: Maestría Elemental.
Tiara de Logos: Maestría Elemental, Prob. CRIT o Daño CRIT.
Subestadísticas: Maestría Elemental, Prob. CRIT, Daño CRIT, Recarga de Energía.', null, 'Game8', '{"rol":"DPS secundario y apoyo","armas":{"ideales":["gi-w-14511"],"alternativas":["gi-w-14403","gi-w-14301","gi-w-14416","gi-w-14407","gi-w-14402"]},"artefactos":[{"conjuntos":["gi-artifact-15025"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Maestría Elemental"],"caliz":["Maestría Elemental"],"tiara":["Maestría Elemental","Prob. CRIT","Daño CRIT"]},"secundarias":["Maestría Elemental","Prob. CRIT","Daño CRIT","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-navia', 'General', 'Arma ideal: Sentenciadora.
Otras armas que le van bien: Médula de la Serpiente Marina, Espada de la Desidia, Lápida del Lobo o Superespada Mágica Suprema.
Artefactos: Final del Gladiador (2) + Petra Arcaica (2).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Geo.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Daño CRIT, Prob. CRIT, Recarga de Energía, ATQ %.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-12512"],"alternativas":["gi-w-12409","gi-w-12504","gi-w-12502","gi-w-12426"]},"artefactos":[{"conjuntos":["gi-artifact-15001","gi-artifact-15014"],"piezas":"2+2"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Geo"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Daño CRIT","Prob. CRIT","Recarga de Energía","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-nefer', 'General', 'Arma ideal: Relicario de la Verdad.
Otras armas que le van bien: Espejo Tejenoches, Escrituras del Fluir Sempiterno, Supervisor Flujoáurico, Escarcha del Albor o Lámpara Medulaoscura.
Artefactos: Noche de la Revelación del Cielo (4).', 'Arenas del Eón: Maestría Elemental.
Cáliz de Eonothem: Maestría Elemental.
Tiara de Logos: Daño CRIT o Prob. CRIT.
Subestadísticas: Maestría Elemental, Prob. CRIT, Daño CRIT.', null, 'Game8', '{"rol":"DPS principal (Lunar Bloom)","armas":{"ideales":["gi-w-14521"],"alternativas":["gi-w-14520","gi-w-14514","gi-w-14513","gi-w-14434","gi-w-14433"]},"artefactos":[{"conjuntos":["gi-artifact-15041"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Maestría Elemental"],"caliz":["Maestría Elemental"],"tiara":["Daño CRIT","Prob. CRIT"]},"secundarias":["Maestría Elemental","Prob. CRIT","Daño CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-neuvillette', 'General', 'Arma ideal: Escrituras del Fluir Sempiterno.
Otras armas que le van bien: Jade Sacrificial, Hora de Surfear, Oración Perdida a los Vientos Sagrados o Prototipo Ámbar.
Artefactos: Cazador Fantasmal (4).
Alternativas: Corazón de las Profundidades (4).', 'Arenas del Eón: Vida %.
Cáliz de Eonothem: Bono de Daño Hydro o Vida %.
Tiara de Logos: Prob. CRIT o Vida %.
Subestadísticas: ATQ %, Recarga de Energía.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-14514"],"alternativas":["gi-w-14424","gi-w-14516","gi-w-14502","gi-w-14406"]},"artefactos":[{"conjuntos":["gi-artifact-15031"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15016"],"piezas":"4"}],"principales":{"arenas":["Vida %"],"caliz":["Bono de Daño Hydro","Vida %"],"tiara":["Prob. CRIT","Vida %"]},"secundarias":["ATQ %","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-nicole', 'General', 'Arma ideal: Heptadas de los Ángeles.
Otras armas que le van bien: Vigía de las Estrellas, Cuentos de Cazadores de Dragones, Pergamino Celestial, Ojo del Juramento o Fluencia Impoluta.
Artefactos: Dádiva Celestial (4).
Alternativas: Ritual Antiguo de la Nobleza (4) o Pergamino del Héroe de la Ciudad de las Cenizas (4).', 'Arenas del Eón: ATQ % o Recarga de Energía.
Cáliz de Eonothem: ATQ %.
Tiara de Logos: ATQ %.
Subestadísticas: ATQ %, Recarga de Energía.', null, 'Game8', '{"rol":"Apoyo y escudo","armas":{"ideales":["gi-w-14523"],"alternativas":["gi-w-14517","gi-w-14302","gi-w-14501","gi-w-14415","gi-w-14425"]},"artefactos":[{"conjuntos":["gi-artifact-15045"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15007"],"piezas":"4"},{"conjuntos":["gi-artifact-15037"],"piezas":"4"}],"principales":{"arenas":["ATQ %","Recarga de Energía"],"caliz":["ATQ %"],"tiara":["ATQ %"]},"secundarias":["ATQ %","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-nilou', 'General', 'Arma ideal: Llave de la Coronación.
Otras armas que le van bien: Juramento por la Libertad, Espada de Favonius, Luz Lunar de Xifos, Sable de la Dársena o Silbido Melifluo.
Artefactos: Fulgor de Vurukasha (2) + Tenacidad de la Geoarmada (2).
Alternativas: Serenata de la Luna Tejida (4).', 'Arenas del Eón: Vida % o Recarga de Energía.
Cáliz de Eonothem: Vida %.
Tiara de Logos: Vida %.
Subestadísticas: Vida %, Recarga de Energía, Maestría Elemental.', null, 'Game8', '{"rol":null,"armas":{"ideales":["gi-w-11511"],"alternativas":["gi-w-11503","gi-w-11401","gi-w-11418","gi-w-11427","gi-w-11433"]},"artefactos":[{"conjuntos":["gi-artifact-15030","gi-artifact-15017"],"piezas":"2+2"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15042"],"piezas":"4"}],"principales":{"arenas":["Vida %","Recarga de Energía"],"caliz":["Vida %"],"tiara":["Vida %"]},"secundarias":["Vida %","Recarga de Energía","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-ningguang', 'General', 'Arma ideal: Oración Perdida a los Vientos Sagrados.
Otras armas que le van bien: Pergamino Celestial, Perla Solar o Carta Náutica.
Artefactos: Murmullo del Bosque Reverberante (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Geo.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-14502"],"alternativas":["gi-w-14501","gi-w-14405","gi-w-14407"]},"artefactos":[{"conjuntos":["gi-artifact-15034"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Geo"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-noelle', 'General', 'Arma ideal: Espadón Cornirrojo.
Otras armas que le van bien: Médula de la Serpiente Marina o Sombra Blanca.
Artefactos: Cáscara de Sueños Opulentos (4) o Cazador Fantasmal (4).', 'Arenas del Eón: DEF %.
Cáliz de Eonothem: Bono de Daño Geo.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: DEF %, Daño CRIT, Prob. CRIT, ATQ %.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-12510"],"alternativas":["gi-w-12409","gi-w-12407"]},"artefactos":[{"conjuntos":["gi-artifact-15021"],"piezas":"4"},{"conjuntos":["gi-artifact-15031"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["DEF %"],"caliz":["Bono de Daño Geo"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["DEF %","Daño CRIT","Prob. CRIT","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-odette', 'General', 'Arma ideal: Pluma Invernal Lagoblanco.
Otras armas que le van bien: Juramento por la Libertad, Réquiem Abisal, Fulgor Cerúleo, Aquila Favonia o Espada del Alba.
Artefactos: Corazón Forjado (4).
Alternativas: Desilusión Congelada en las Sombras (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: ATQ %.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Daño CRIT, Prob. CRIT, ATQ %, Maestría Elemental.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-11520"],"alternativas":["gi-w-11503","gi-w-11425","gi-w-11517","gi-w-11501","gi-w-11302"]},"artefactos":[{"conjuntos":["gi-artifact-15048"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15046"],"piezas":"4"}],"principales":{"arenas":["ATQ %"],"caliz":["ATQ %"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Daño CRIT","Prob. CRIT","ATQ %","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-ororon', 'General', 'Arma ideal: Elegía del Fin.
Otras armas que le van bien: Aqua Simulacra, Arco de Amos, Último Acorde o Pluvioarco de la Serpiente Arcoíris.
Artefactos: Pergamino del Héroe de la Ciudad de las Cenizas (4).', 'Arenas del Eón: ATQ % o Recarga de Energía.
Cáliz de Eonothem: Bono de Daño Electro.
Tiara de Logos: Daño CRIT o Prob. CRIT.
Subestadísticas: ATQ %, Prob. CRIT, Daño CRIT, Recarga de Energía.', null, 'Game8', '{"rol":"DPS secundario","armas":{"ideales":["gi-w-15503"],"alternativas":["gi-w-15508","gi-w-15502","gi-w-15402","gi-w-15434"]},"artefactos":[{"conjuntos":["gi-artifact-15037"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %","Recarga de Energía"],"caliz":["Bono de Daño Electro"],"tiara":["Daño CRIT","Prob. CRIT"]},"secundarias":["ATQ %","Prob. CRIT","Daño CRIT","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-prune', 'General', 'Arma ideal: Pergamino Celestial.
Otras armas que le van bien: Candado Terrenal, Cuentos de Cazadores de Dragones, Ojo del Juramento, Códice de Favonius, Fluencia Impoluta o Anillo de Hakushin.
Artefactos: Sombra Verde Esmeralda (4).
Alternativas: Día de los Vientos Alzantes (4) o Ritual Antiguo de la Nobleza (4).', 'Arenas del Eón: ATQ % o Recarga de Energía.
Cáliz de Eonothem: ATQ %.
Tiara de Logos: ATQ %.
Subestadísticas: ATQ %, Recarga de Energía.', null, 'Game8', '{"rol":"DPS secundario y apoyo","armas":{"ideales":["gi-w-14501"],"alternativas":["gi-w-14504","gi-w-14302","gi-w-14415","gi-w-14401","gi-w-14425","gi-w-14414"]},"artefactos":[{"conjuntos":["gi-artifact-15002"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15044"],"piezas":"4"},{"conjuntos":["gi-artifact-15007"],"piezas":"4"}],"principales":{"arenas":["ATQ %","Recarga de Energía"],"caliz":["ATQ %"],"tiara":["ATQ %"]},"secundarias":["ATQ %","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-qiqi', 'General', 'Arma ideal: Hoja Afilada Celestial.
Otras armas que le van bien: Cortador de Jade Primordial, Rompemontañas, Espada de Sacrificio o Espada de Favonius.
Artefactos: Tenacidad de la Geoarmada (4).', 'Arenas del Eón: ATQ % o Recarga de Energía.
Cáliz de Eonothem: ATQ %.
Tiara de Logos: ATQ %, Bono de Curación o Prob. CRIT.
Subestadísticas: Recarga de Energía, ATQ %, Prob. CRIT, Daño CRIT.', null, 'Game8', '{"rol":"Apoyo y sanación (Stellar Conduct)","armas":{"ideales":["gi-w-11502"],"alternativas":["gi-w-11505","gi-w-11504","gi-w-11403","gi-w-11401"]},"artefactos":[{"conjuntos":["gi-artifact-15017"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %","Recarga de Energía"],"caliz":["ATQ %"],"tiara":["ATQ %","Bono de Curación","Prob. CRIT"]},"secundarias":["Recarga de Energía","ATQ %","Prob. CRIT","Daño CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-raiden', 'General', 'Arma ideal: Luz del Segador.
Otras armas que le van bien: Báculo de Homa, Aleta Cortaolas o La Captura.
Artefactos: Emblema del Destino (4).', 'Arenas del Eón: Recarga de Energía o ATQ %.
Cáliz de Eonothem: ATQ % o Bono de Daño Electro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Daño CRIT, Prob. CRIT, ATQ %, Recarga de Energía, Maestría Elemental.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-13509"],"alternativas":["gi-w-13501","gi-w-13416","gi-w-13415"]},"artefactos":[{"conjuntos":["gi-artifact-15020"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Recarga de Energía","ATQ %"],"caliz":["ATQ %","Bono de Daño Electro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Daño CRIT","Prob. CRIT","ATQ %","Recarga de Energía","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-razor', 'General', 'Arma ideal: Mil Soles Abrasadores.
Otras armas que le van bien: Espadón Cornirrojo, Emblema del Mar de Juncos o Médula de la Serpiente Marina.
Artefactos: Día de los Vientos Alzantes (4) o Eco del Sacrificio (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Electro.
Tiara de Logos: Daño CRIT o Prob. CRIT.
Subestadísticas: ATQ %, Prob. CRIT, Daño CRIT, Recarga de Energía.', null, 'Game8', '{"rol":"DPS principal (Hexerei)","armas":{"ideales":["gi-w-12514"],"alternativas":["gi-w-12510","gi-w-12511","gi-w-12409"]},"artefactos":[{"conjuntos":["gi-artifact-15044"],"piezas":"4"},{"conjuntos":["gi-artifact-15024"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Electro"],"tiara":["Daño CRIT","Prob. CRIT"]},"secundarias":["ATQ %","Prob. CRIT","Daño CRIT","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-rosaria', 'General', 'Arma ideal: Báculo de las Arenas Escarlatas.
Otras armas que le van bien: Báculo de Homa, Halo Fracturado o Elegía Lumidulce.
Artefactos: Sueños Áureos (4).', 'Arenas del Eón: Maestría Elemental o ATQ %.
Cáliz de Eonothem: Bono de Daño Cryo.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Recarga de Energía, Prob. CRIT, Daño CRIT, Maestría Elemental, ATQ %.', null, 'Game8', '{"rol":"DPS principal (Melt)","armas":{"ideales":["gi-w-13511"],"alternativas":["gi-w-13501","gi-w-13515","gi-w-13513"]},"artefactos":[{"conjuntos":["gi-artifact-15026"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Maestría Elemental","ATQ %"],"caliz":["Bono de Daño Cryo"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Recarga de Energía","Prob. CRIT","Daño CRIT","Maestría Elemental","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-sandrone', 'General', 'Arma ideal: Llave de la Trascendencia.
Otras armas que le van bien: Mil Soles Abrasadores, Espadón Cornirrojo, Sentenciadora, Fierro Floriorlado o Sombra de la Marea.
Artefactos: Desilusión Congelada en las Sombras (4).
Alternativas: Sueños Áureos (4).', 'Arenas del Eón: ATQ % o Maestría Elemental.
Cáliz de Eonothem: ATQ % o Maestría Elemental.
Tiara de Logos: Daño CRIT o Prob. CRIT.
Subestadísticas: Recarga de Energía, Daño CRIT, Prob. CRIT, ATQ %, Maestría Elemental.', null, 'Game8', '{"rol":null,"armas":{"ideales":["gi-w-12516"],"alternativas":["gi-w-12514","gi-w-12510","gi-w-12512","gi-w-12418","gi-w-12425"]},"artefactos":[{"conjuntos":["gi-artifact-15046"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15026"],"piezas":"4"}],"principales":{"arenas":["ATQ %","Maestría Elemental"],"caliz":["ATQ %","Maestría Elemental"],"tiara":["Daño CRIT","Prob. CRIT"]},"secundarias":["Recarga de Energía","Daño CRIT","Prob. CRIT","ATQ %","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-sayu', 'General', 'Arma ideal: Májaira Aguamarina.
Otras armas que le van bien: Fierro Floriorlado, Segadora de la Lluvia o Gran Espada de Sacrificio.
Artefactos: Sombra Verde Esmeralda (4).', 'Arenas del Eón: Recarga de Energía o Maestría Elemental.
Cáliz de Eonothem: Maestría Elemental.
Tiara de Logos: Maestría Elemental.
Subestadísticas: Recarga de Energía, ATQ %, Maestría Elemental.', null, 'Game8', '{"rol":"DPS principal (Swirl)","armas":{"ideales":["gi-w-12415"],"alternativas":["gi-w-12418","gi-w-12405","gi-w-12403"]},"artefactos":[{"conjuntos":["gi-artifact-15002"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Recarga de Energía","Maestría Elemental"],"caliz":["Maestría Elemental"],"tiara":["Maestría Elemental"]},"secundarias":["Recarga de Energía","ATQ %","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-sethos', 'General', 'Arma ideal: Senda de la Cazadora.
Otras armas que le van bien: El Primer Gran Número de Magia, Arco de Amos, Cimentador de Nubes, Descendientes del Sol Abrasador o Tirachinas.
Artefactos: Orquesta del Errante (4) o Sueños Áureos (4).', 'Arenas del Eón: Maestría Elemental.
Cáliz de Eonothem: Bono de Daño Electro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Prob. CRIT, Daño CRIT, Recarga de Energía, Maestría Elemental.', null, 'Game8', '{"rol":"DPS principal (Aggravate)","armas":{"ideales":["gi-w-15511"],"alternativas":["gi-w-15512","gi-w-15502","gi-w-15426","gi-w-15424","gi-w-15304"]},"artefactos":[{"conjuntos":["gi-artifact-15003"],"piezas":"4"},{"conjuntos":["gi-artifact-15026"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Maestría Elemental"],"caliz":["Bono de Daño Electro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Prob. CRIT","Daño CRIT","Recarga de Energía","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-shenhe', 'General', 'Arma ideal: Pacificadora del Desastre.
Otras armas que le van bien: Luz del Segador o Lanza de Favonius.
Artefactos: Final del Gladiador (2) + Reminiscencia de la Purificación (2).', 'Arenas del Eón: ATQ % o Recarga de Energía.
Cáliz de Eonothem: ATQ %.
Tiara de Logos: ATQ %.
Subestadísticas: ATQ %, Recarga de Energía.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-13507"],"alternativas":["gi-w-13509","gi-w-13407"]},"artefactos":[{"conjuntos":["gi-artifact-15001","gi-artifact-15019"],"piezas":"2+2"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %","Recarga de Energía"],"caliz":["ATQ %"],"tiara":["ATQ %"]},"secundarias":["ATQ %","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-sigewinne', 'General', 'Arma ideal: Corazón de la Lluvia.
Otras armas que le van bien: Arco Recurvo, Aqua Simulacra, Arco del Sacrificio, Arco de Favonius o Elegía del Fin.
Artefactos: Perla Oceánica (4) o Son de Antaño (4).', 'Arenas del Eón: Vida %.
Cáliz de Eonothem: Vida %.
Tiara de Logos: Vida % o Bono de Curación.
Subestadísticas: Vida %, Recarga de Energía.', null, 'Game8', '{"rol":"Apoyo y sanación","armas":{"ideales":["gi-w-15513"],"alternativas":["gi-w-15303","gi-w-15508","gi-w-15403","gi-w-15401","gi-w-15503"]},"artefactos":[{"conjuntos":["gi-artifact-15022"],"piezas":"4"},{"conjuntos":["gi-artifact-15033"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Vida %"],"caliz":["Vida %"],"tiara":["Vida %","Bono de Curación"]},"secundarias":["Vida %","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-skirk', 'General', 'Arma ideal: Fulgor Cerúleo.
Otras armas que le van bien: Luna Ondulante de Futsu, Reflejo de las Tinieblas, Cortador de Jade Primordial, Réquiem Abisal o Calamidad de Eshu.
Artefactos: Réquiem del Corredor (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Cryo.
Tiara de Logos: Daño CRIT o Prob. CRIT.
Subestadísticas: ATQ %, Prob. CRIT, Daño CRIT.', null, 'Game8', '{"rol":"DPS principal (Freeze)","armas":{"ideales":["gi-w-11517"],"alternativas":["gi-w-11510","gi-w-11509","gi-w-11505","gi-w-11425","gi-w-11432"]},"artefactos":[{"conjuntos":["gi-artifact-15040"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Cryo"],"tiara":["Daño CRIT","Prob. CRIT"]},"secundarias":["ATQ %","Prob. CRIT","Daño CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-sucrose', 'General', 'Arma ideal: Memorias de Sacrificios.
Otras armas que le van bien: Hibernación Matutina de Año Nuevo, Estrella Errabunda o Guía Mágica.
Artefactos: Sombra Verde Esmeralda (4).
Alternativas: Instructor (4).', 'Arenas del Eón: Maestría Elemental.
Cáliz de Eonothem: Maestría Elemental.
Tiara de Logos: Maestría Elemental.
Subestadísticas: Maestría Elemental, Recarga de Energía, Prob. CRIT.', null, 'Game8', '{"rol":"Apoyo (Hexerei)","armas":{"ideales":["gi-w-14403"],"alternativas":["gi-w-14518","gi-w-14416","gi-w-14301"]},"artefactos":[{"conjuntos":["gi-artifact-15002"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-10007"],"piezas":"4"}],"principales":{"arenas":["Maestría Elemental"],"caliz":["Maestría Elemental"],"tiara":["Maestría Elemental"]},"secundarias":["Maestría Elemental","Recarga de Energía","Prob. CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-tartaglia', 'General', 'Arma ideal: Estrella Invernal.
Otras armas que le van bien: Agitador del Relámpago, Arco de la Cazadora Esmeralda o Descendientes del Sol Abrasador.
Artefactos: Sueño de la Ninfa (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Hydro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: ATQ %, Prob. CRIT, Daño CRIT, Maestría Elemental.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-15507"],"alternativas":["gi-w-15509","gi-w-15409","gi-w-15424"]},"artefactos":[{"conjuntos":["gi-artifact-15029"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Hydro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["ATQ %","Prob. CRIT","Daño CRIT","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-thoma', 'General', 'Arma ideal: Lanza de Favonius.
Otras armas que le van bien: Retribución de la Justicia, Borla Negra o Luz del Segador.
Artefactos: Emblema del Destino (2) + Tenacidad de la Geoarmada (2).', 'Arenas del Eón: Vida % o Recarga de Energía.
Cáliz de Eonothem: Vida %.
Tiara de Logos: Vida %.
Subestadísticas: Recarga de Energía, Vida %.', null, 'Game8', '{"rol":"Apoyo y escudo","armas":{"ideales":["gi-w-13407"],"alternativas":["gi-w-13425","gi-w-13303","gi-w-13509"]},"artefactos":[{"conjuntos":["gi-artifact-15020","gi-artifact-15017"],"piezas":"2+2"}],"artefactosAlternativos":[],"principales":{"arenas":["Vida %","Recarga de Energía"],"caliz":["Vida %"],"tiara":["Vida %"]},"secundarias":["Recarga de Energía","Vida %"]}'::jsonb),
  ('genshin-impact', 'gi-tighnari', 'General', 'Arma ideal: Senda de la Cazadora.
Otras armas que le van bien: Aqua Simulacra, Alas Celestiales o Descendientes del Sol Abrasador.
Artefactos: Sueños Áureos (4).', 'Arenas del Eón: ATQ % o Maestría Elemental.
Cáliz de Eonothem: Bono de Daño Dendro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, Maestría Elemental.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-15511"],"alternativas":["gi-w-15508","gi-w-15501","gi-w-15424"]},"artefactos":[{"conjuntos":["gi-artifact-15026"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %","Maestría Elemental"],"caliz":["Bono de Daño Dendro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-traveler', 'General', 'Arma ideal: Cortador de Jade Primordial.
Otras armas que le van bien: Hoja Afilada Celestial, Espada de Sacrificio o Espina de Hierro.
Artefactos: Sombra Verde Esmeralda (4).', 'Arenas del Eón: Recarga de Energía.
Cáliz de Eonothem: Bono de Daño Anemo.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Recarga de Energía, Prob. CRIT.', null, 'Game8', '{"rol":"DPS secundario","armas":{"ideales":["gi-w-11505"],"alternativas":["gi-w-11502","gi-w-11403","gi-w-11407"]},"artefactos":[{"conjuntos":["gi-artifact-15002"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Recarga de Energía"],"caliz":["Bono de Daño Anemo"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Recarga de Energía","Prob. CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-varesa', 'General', 'Arma ideal: Reflexión Iridiscente.
Otras armas que le van bien: Axioma de la Kagura, Oración Perdida a los Vientos Sagrados, Reverberación de la Grulla, Sinfonía de los Merodeadores o Fluencia Impoluta.
Artefactos: Juramento de la Noche (4).
Alternativas: Códice de Obsidiana (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Electro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Recarga de Energía, Daño CRIT, Prob. CRIT, ATQ %, Maestría Elemental.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-14519"],"alternativas":["gi-w-14509","gi-w-14502","gi-w-14515","gi-w-14402","gi-w-14425"]},"artefactos":[{"conjuntos":["gi-artifact-15039"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15038"],"piezas":"4"}],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Electro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Recarga de Energía","Daño CRIT","Prob. CRIT","ATQ %","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-varka', 'General', 'Arma ideal: Cantar de Gesta del Lobo.
Otras armas que le van bien: Mil Soles Abrasadores, Espadón Cornirrojo, Lápida del Lobo, Médula de la Serpiente Marina o Sombra de la Marea.
Artefactos: Día de los Vientos Alzantes (4).
Alternativas: Sombra Verde Esmeralda (2) + Bruja Carmesí en Llamas (2).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: ATQ %.
Tiara de Logos: Daño CRIT o Prob. CRIT.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, Recarga de Energía, Maestría Elemental.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-12515"],"alternativas":["gi-w-12514","gi-w-12510","gi-w-12502","gi-w-12409","gi-w-12425"]},"artefactos":[{"conjuntos":["gi-artifact-15044"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15002","gi-artifact-15006"],"piezas":"2+2"}],"principales":{"arenas":["ATQ %"],"caliz":["ATQ %"],"tiara":["Daño CRIT","Prob. CRIT"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","Recarga de Energía","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-venti', 'General', 'Arma ideal: Albores de la Historia.
Otras armas que le van bien: Pluma Carmesí Buitreastral, Aqua Simulacra o Arco Compuesto.
Artefactos: Día de los Vientos Alzantes (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Anemo.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Maestría Elemental, Recarga de Energía, ATQ %, Prob. CRIT, Daño CRIT.', null, 'Game8', '{"rol":"DPS principal (Hexerei)","armas":{"ideales":["gi-w-15515"],"alternativas":["gi-w-15514","gi-w-15508","gi-w-15407"]},"artefactos":[{"conjuntos":["gi-artifact-15044"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Anemo"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Maestría Elemental","Recarga de Energía","ATQ %","Prob. CRIT","Daño CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-wanderer', 'General', 'Arma ideal: Reminiscencia de Tulaytulah.
Otras armas que le van bien: Oración Perdida a los Vientos Sagrados, Supervisor Flujoáurico, Sinfonía de los Merodeadores, Oda al Vasto Azul o Carta Náutica.
Artefactos: Épica del Pabellón del Desierto (4) o Reminiscencia de la Purificación (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Anemo.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Prob. CRIT, Daño CRIT, Recarga de Energía, ATQ %.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-14512"],"alternativas":["gi-w-14502","gi-w-14513","gi-w-14402","gi-w-14426","gi-w-14407"]},"artefactos":[{"conjuntos":["gi-artifact-15027"],"piezas":"4"},{"conjuntos":["gi-artifact-15019"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Anemo"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Prob. CRIT","Daño CRIT","Recarga de Energía","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-wriothesley', 'General', 'Arma ideal: Supervisor Flujoáurico.
Otras armas que le van bien: Reminiscencia de Tulaytulah, Oración Perdida a los Vientos Sagrados, Sinfonía de los Merodeadores, Oda al Vasto Azul o Fluencia Impoluta.
Artefactos: Desilusión Congelada en las Sombras (4).
Alternativas: Cazador Fantasmal (4) o Nómada del Invierno (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Cryo.
Tiara de Logos: Daño CRIT o Prob. CRIT.
Subestadísticas: Daño CRIT, Prob. CRIT, ATQ %, Recarga de Energía.', null, 'Game8', '{"rol":null,"armas":{"ideales":["gi-w-14513"],"alternativas":["gi-w-14512","gi-w-14502","gi-w-14402","gi-w-14426","gi-w-14425"]},"artefactos":[{"conjuntos":["gi-artifact-15046"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15031"],"piezas":"4"},{"conjuntos":["gi-artifact-14001"],"piezas":"4"}],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Cryo"],"tiara":["Daño CRIT","Prob. CRIT"]},"secundarias":["Daño CRIT","Prob. CRIT","ATQ %","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-xiangling', 'General', 'Arma ideal: Luz del Segador.
Otras armas que le van bien: Báculo de las Arenas Escarlatas, Báculo de Homa, La Captura o Lanza de Favonius.
Artefactos: Emblema del Destino (4).
Alternativas: Bruja Carmesí en Llamas (4) o Ritual Antiguo de la Nobleza (4).', 'Arenas del Eón: ATQ %, Recarga de Energía o Maestría Elemental.
Cáliz de Eonothem: Bono de Daño Pyro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Recarga de Energía, Prob. CRIT, Daño CRIT, Maestría Elemental.', null, 'Game8', '{"rol":"DPS secundario","armas":{"ideales":["gi-w-13509"],"alternativas":["gi-w-13511","gi-w-13501","gi-w-13415","gi-w-13407"]},"artefactos":[{"conjuntos":["gi-artifact-15020"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15006"],"piezas":"4"},{"conjuntos":["gi-artifact-15007"],"piezas":"4"}],"principales":{"arenas":["ATQ %","Recarga de Energía","Maestría Elemental"],"caliz":["Bono de Daño Pyro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Recarga de Energía","Prob. CRIT","Daño CRIT","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-xianyun', 'General', 'Arma ideal: Reverberación de la Grulla.
Otras armas que le van bien: Pergamino Celestial, Candado Terrenal, Ojo del Juramento, Fluencia Impoluta o Códice de Favonius.
Artefactos: Sombra Verde Esmeralda (4) o Son de Antaño (4).', 'Arenas del Eón: Recarga de Energía o ATQ %.
Cáliz de Eonothem: ATQ %.
Tiara de Logos: ATQ % o Bono de Curación.
Subestadísticas: Recarga de Energía, ATQ %.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-14515"],"alternativas":["gi-w-14501","gi-w-14504","gi-w-14415","gi-w-14425","gi-w-14401"]},"artefactos":[{"conjuntos":["gi-artifact-15002"],"piezas":"4"},{"conjuntos":["gi-artifact-15033"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Recarga de Energía","ATQ %"],"caliz":["ATQ %"],"tiara":["ATQ %","Bono de Curación"]},"secundarias":["Recarga de Energía","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-xiao', 'General', 'Arma ideal: Halcón de Jade.
Otras armas que le van bien: Báculo de Homa, Halo Fracturado, Pacificadora del Desastre, Lanza del Duelo, Lanza Lítica o Lanza del Peñasco Oscuro.
Artefactos: Juramento de la Noche (4) o Deceso del Cinabrio (4).', 'Arenas del Eón: ATQ % o Recarga de Energía.
Cáliz de Eonothem: Bono de Daño Anemo.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Recarga de Energía, Prob. CRIT, Daño CRIT, ATQ %.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-13505"],"alternativas":["gi-w-13501","gi-w-13515","gi-w-13507","gi-w-13405","gi-w-13406","gi-w-13404"]},"artefactos":[{"conjuntos":["gi-artifact-15039"],"piezas":"4"},{"conjuntos":["gi-artifact-15023"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %","Recarga de Energía"],"caliz":["Bono de Daño Anemo"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Recarga de Energía","Prob. CRIT","Daño CRIT","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-xilonen', 'General', 'Arma ideal: Himno de las Cumbres.
Otras armas que le van bien: Juramento por la Libertad, Espada de Favonius o Flauta de Ezpitzal.
Artefactos: Pergamino del Héroe de la Ciudad de las Cenizas (4).', 'Arenas del Eón: Recarga de Energía.
Cáliz de Eonothem: DEF %.
Tiara de Logos: Bono de Curación o DEF %.
Subestadísticas: Recarga de Energía.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-11516"],"alternativas":["gi-w-11503","gi-w-11401","gi-w-11431"]},"artefactos":[{"conjuntos":["gi-artifact-15037"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Recarga de Energía"],"caliz":["DEF %"],"tiara":["Bono de Curación","DEF %"]},"secundarias":["Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-xingqiu', 'General', 'Arma ideal: Espada de Sacrificio.
Otras armas que le van bien: Cortador de Jade Primordial, Reflejo de las Tinieblas o Espada Amenoma Gemela.
Artefactos: Emblema del Destino (4).', 'Arenas del Eón: ATQ % o Recarga de Energía.
Cáliz de Eonothem: Bono de Daño Hydro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Recarga de Energía, Daño CRIT, Prob. CRIT, ATQ %, Maestría Elemental.', null, 'Game8', '{"rol":"DPS secundario","armas":{"ideales":["gi-w-11403"],"alternativas":["gi-w-11505","gi-w-11509","gi-w-11414"]},"artefactos":[{"conjuntos":["gi-artifact-15020"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %","Recarga de Energía"],"caliz":["Bono de Daño Hydro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Recarga de Energía","Daño CRIT","Prob. CRIT","ATQ %","Maestría Elemental"]}'::jsonb),
  ('genshin-impact', 'gi-xinyan', 'General', 'Arma ideal: Espadón Cornirrojo.
Otras armas que le van bien: Orgullo Celestial, Argento Estelar de las Nieves o Prototipo Arcaico.
Artefactos: Llamas Albinas (2) + Caballería Sanguinaria (2).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Físico.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, Recarga de Energía.', null, 'Game8', '{"rol":"DPS principal (Physical)","armas":{"ideales":["gi-w-12510"],"alternativas":["gi-w-12501","gi-w-12411","gi-w-12406"]},"artefactos":[{"conjuntos":["gi-artifact-15018","gi-artifact-15008"],"piezas":"2+2"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Físico"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-yae-miko', 'General', 'Arma ideal: Axioma de la Kagura.
Otras armas que le van bien: Sueños de las Mil Noches, Pergamino Celestial, Sinfonía de los Merodeadores, Laúd de la Luz Celestial o Fluencia Impoluta.
Artefactos: Desilusión Congelada en las Sombras (4).
Alternativas: Sueños Áureos (4).', 'Arenas del Eón: ATQ % o Maestría Elemental.
Cáliz de Eonothem: ATQ %.
Tiara de Logos: Daño CRIT o Prob. CRIT.
Subestadísticas: Daño CRIT, Prob. CRIT, Recarga de Energía, Maestría Elemental, ATQ %.', null, 'Game8', '{"rol":"DPS secundario (Stellar Conduct)","armas":{"ideales":["gi-w-14509"],"alternativas":["gi-w-14511","gi-w-14501","gi-w-14402","gi-w-14432","gi-w-14425"]},"artefactos":[{"conjuntos":["gi-artifact-15046"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15026"],"piezas":"4"}],"principales":{"arenas":["ATQ %","Maestría Elemental"],"caliz":["ATQ %"],"tiara":["Daño CRIT","Prob. CRIT"]},"secundarias":["Daño CRIT","Prob. CRIT","Recarga de Energía","Maestría Elemental","ATQ %"]}'::jsonb),
  ('genshin-impact', 'gi-yanfei', 'General', 'Arma ideal: Oración Perdida a los Vientos Sagrados.
Otras armas que le van bien: Pergamino Celestial, Fluencia Impoluta o Oda al Vasto Azul.
Artefactos: Bruja Carmesí en Llamas (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Pyro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: ATQ %, Daño CRIT, Prob. CRIT.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-14502"],"alternativas":["gi-w-14501","gi-w-14425","gi-w-14426"]},"artefactos":[{"conjuntos":["gi-artifact-15006"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Pyro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["ATQ %","Daño CRIT","Prob. CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-yaoyao', 'General', 'Arma ideal: Lanza de Favonius.
Otras armas que le van bien: Discusión de los Sabios del Desierto, Retribución de la Justicia, Borla Negra o Cruz de Kitain.
Artefactos: Recuerdos del Bosque (4).', 'Arenas del Eón: Recarga de Energía o Vida %.
Cáliz de Eonothem: Vida %.
Tiara de Logos: Prob. CRIT o Bono de Curación.
Subestadísticas: Recarga de Energía, Prob. CRIT, Maestría Elemental, Vida %, Daño CRIT.', null, 'Game8', '{"rol":"Sanación","armas":{"ideales":["gi-w-13407"],"alternativas":["gi-w-13426","gi-w-13425","gi-w-13303","gi-w-13414"]},"artefactos":[{"conjuntos":["gi-artifact-15025"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Recarga de Energía","Vida %"],"caliz":["Vida %"],"tiara":["Prob. CRIT","Bono de Curación"]},"secundarias":["Recarga de Energía","Prob. CRIT","Maestría Elemental","Vida %","Daño CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-yelan', 'General', 'Arma ideal: Aqua Simulacra.
Otras armas que le van bien: Elegía del Fin, Arco de Favonius o Tirachinas.
Artefactos: Emblema del Destino (4).', 'Arenas del Eón: Vida % o Recarga de Energía.
Cáliz de Eonothem: Bono de Daño Hydro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Recarga de Energía, Vida %, Prob. CRIT, Daño CRIT.', null, 'Game8', '{"rol":"DPS secundario","armas":{"ideales":["gi-w-15508"],"alternativas":["gi-w-15503","gi-w-15401","gi-w-15304"]},"artefactos":[{"conjuntos":["gi-artifact-15020"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Vida %","Recarga de Energía"],"caliz":["Bono de Daño Hydro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Recarga de Energía","Vida %","Prob. CRIT","Daño CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-yoimiya', 'General', 'Arma ideal: Agitador del Relámpago.
Otras armas que le van bien: Estrella Invernal, Aqua Simulacra o Herrumbre.
Artefactos: Reminiscencia de la Purificación (4).', 'Arenas del Eón: ATQ %.
Cáliz de Eonothem: Bono de Daño Pyro.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Daño CRIT, Maestría Elemental, Recarga de Energía.', null, 'Game8', '{"rol":"DPS principal","armas":{"ideales":["gi-w-15509"],"alternativas":["gi-w-15507","gi-w-15508","gi-w-15405"]},"artefactos":[{"conjuntos":["gi-artifact-15019"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["ATQ %"],"caliz":["Bono de Daño Pyro"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Daño CRIT","Maestría Elemental","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-yun-jin', 'General', 'Arma ideal: Luz del Segador.
Otras armas que le van bien: Lanza de Favonius, Estela Iridiscente, La Captura o Prototipo Estelar.
Artefactos: Cáscara de Sueños Opulentos (4).', 'Arenas del Eón: DEF % o Recarga de Energía.
Cáliz de Eonothem: DEF %.
Tiara de Logos: DEF % o Prob. CRIT.
Subestadísticas: DEF %, Recarga de Energía, Prob. CRIT.', null, 'Game8', '{"rol":"Apoyo","armas":{"ideales":["gi-w-13509"],"alternativas":["gi-w-13407","gi-w-13431","gi-w-13415","gi-w-13402"]},"artefactos":[{"conjuntos":["gi-artifact-15021"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["DEF %","Recarga de Energía"],"caliz":["DEF %"],"tiara":["DEF %","Prob. CRIT"]},"secundarias":["DEF %","Recarga de Energía","Prob. CRIT"]}'::jsonb),
  ('genshin-impact', 'gi-zhongli', 'General', 'Arma ideal: Borla Negra.
Otras armas que le van bien: Discusión de los Sabios del Desierto, Lanza de Favonius o Báculo de Homa.
Artefactos: Tenacidad de la Geoarmada (4).', 'Arenas del Eón: Vida %.
Cáliz de Eonothem: Vida %.
Tiara de Logos: Vida %.
Subestadísticas: Vida %, Recarga de Energía.', null, 'Game8', '{"rol":"Apoyo y escudo","armas":{"ideales":["gi-w-13303"],"alternativas":["gi-w-13426","gi-w-13407","gi-w-13501"]},"artefactos":[{"conjuntos":["gi-artifact-15017"],"piezas":"4"}],"artefactosAlternativos":[],"principales":{"arenas":["Vida %"],"caliz":["Vida %"],"tiara":["Vida %"]},"secundarias":["Vida %","Recarga de Energía"]}'::jsonb),
  ('genshin-impact', 'gi-zibai', 'General', 'Arma ideal: Refulgencia de la Luna.
Otras armas que le van bien: Cortatelones de Urakusai, Clorofilo Refulgente, Himno de las Cumbres, Espada del Alba, Flauta de Ezpitzal, Expiadora o Huso de Cinabrio.
Artefactos: Noche de la Revelación del Cielo (4).
Alternativas: Cáscara de Sueños Opulentos (4).', 'Arenas del Eón: DEF %.
Cáliz de Eonothem: DEF %.
Tiara de Logos: Prob. CRIT o Daño CRIT.
Subestadísticas: Prob. CRIT, Daño CRIT, DEF %, Maestría Elemental, Recarga de Energía.', null, 'Game8', '{"rol":"DPS principal (Lunar Crystallize)","armas":{"ideales":["gi-w-11519"],"alternativas":["gi-w-11514","gi-w-11512","gi-w-11516","gi-w-11302","gi-w-11431","gi-w-11515","gi-w-11415"]},"artefactos":[{"conjuntos":["gi-artifact-15041"],"piezas":"4"}],"artefactosAlternativos":[{"conjuntos":["gi-artifact-15021"],"piezas":"4"}],"principales":{"arenas":["DEF %"],"caliz":["DEF %"],"tiara":["Prob. CRIT","Daño CRIT"]},"secundarias":["Prob. CRIT","Daño CRIT","DEF %","Maestría Elemental","Recarga de Energía"]}'::jsonb)
on conflict (character_id, mode) do update
  set equipment_build = excluded.equipment_build,
      stats = excluded.stats,
      source = excluded.source,
      build = excluded.build,
      updated_at = now();

-- Comprobacion
select count(*) as builds, count(*) filter (where jsonb_array_length(build -> 'artefactos') > 0) as con_artefactos
from public.character_meta_guides
where game_id = 'genshin-impact';

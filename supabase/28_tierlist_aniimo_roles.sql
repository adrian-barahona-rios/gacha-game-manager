-- Ejecutar en Supabase -> SQL Editor -> New query -> Run.
-- Requiere 01_esquema.sql (las columnas percentile, note_es y note_en de
-- tier_lists_oficial) y 05_personajes_aniimo.sql.
--
-- Tier list de Aniimo por roles, con los datos de MetaBot.gg. Son 85 filas:
-- cada criatura aparece en el escalafon de su rol (DPS, Ruptura, Apoyo,
-- Curacion y Regeneracion), con su tier, su percentil y sus estadisticas.
--
-- MetaBot puntua solo con estadisticas base y este es su reparto:
-- 34% ATQ, 20% PV, 12% DEF F., 12% DEF M., 12% RUPT. y 10% REGEN.
-- Por eso no mide habilidades ni sinergias: mide el cuerpo de la criatura.
--
-- La tier list general (archivo 26) sigue siendo la de Game8, que si tiene en
-- cuenta habilidades y opinion de la comunidad. Conviven las dos.
--
-- Fuente: metabot.gg/en/aniimo/roles/<rol>. Consultado el 2026-09-24.
--
-- Inserta lo que falte y actualiza lo que ya exista, sin borrar nada.

insert into public.tier_lists_oficial (
  game_id, mode, character_id, rating, source, percentile, note_es, note_en
)
values
  ('aniimo', 'Apoyo', 'aniimo-079', 0, 'metabot.gg', 95, 'Puesto 1 de Apoyo en MetaBot (percentil 95). PV 110 · DEF F. 75.', 'Ranked 1st Support on MetaBot (95th percentile). HP 110 · P.DEF 75.'),
  ('aniimo', 'Apoyo', 'aniimo-008', 0, 'metabot.gg', 95, 'Puesto 2 de Apoyo en MetaBot (percentil 95). PV 113 · DEF F. 79.', 'Ranked 2nd Support on MetaBot (95th percentile). HP 113 · P.DEF 79.'),
  ('aniimo', 'Apoyo', 'aniimo-051', 0, 'metabot.gg', 87, 'Puesto 3 de Apoyo en MetaBot (percentil 87). PV 102 · DEF F. 99.', 'Ranked 3rd Support on MetaBot (87th percentile). HP 102 · P.DEF 99.'),
  ('aniimo', 'Apoyo', 'aniimo-018', 1, 'metabot.gg', 82, 'Puesto 4 de Apoyo en MetaBot (percentil 82). PV 95 · DEF F. 80.', 'Ranked 4th Support on MetaBot (82nd percentile). HP 95 · P.DEF 80.'),
  ('aniimo', 'Apoyo', 'aniimo-019', 1, 'metabot.gg', 76, 'Puesto 5 de Apoyo en MetaBot (percentil 76). PV 100 · DEF F. 77.', 'Ranked 5th Support on MetaBot (76th percentile). HP 100 · P.DEF 77.'),
  ('aniimo', 'Apoyo', 'aniimo-10002', 1, 'metabot.gg', 71, 'Puesto 6 de Apoyo en MetaBot (percentil 71). PV 100 · DEF F. 81.', 'Ranked 6th Support on MetaBot (71st percentile). HP 100 · P.DEF 81.'),
  ('aniimo', 'Apoyo', 'aniimo-032', 1, 'metabot.gg', 66, 'Puesto 7 de Apoyo en MetaBot (percentil 66). PV 100 · DEF F. 83.', 'Ranked 7th Support on MetaBot (66th percentile). HP 100 · P.DEF 83.'),
  ('aniimo', 'Apoyo', 'aniimo-039', 1, 'metabot.gg', 61, 'Puesto 8 de Apoyo en MetaBot (percentil 61). PV 84 · DEF F. 68.', 'Ranked 8th Support on MetaBot (61st percentile). HP 84 · P.DEF 68.'),
  ('aniimo', 'Apoyo', 'aniimo-035', 2, 'metabot.gg', 45, 'Puesto 10 de Apoyo en MetaBot (percentil 45). PV 95 · DEF F. 70.', 'Ranked 10th Support on MetaBot (45th percentile). HP 95 · P.DEF 70.'),
  ('aniimo', 'Apoyo', 'aniimo-058', 2, 'metabot.gg', 45, 'Puesto 11 de Apoyo en MetaBot (percentil 45). PV 91 · DEF F. 101.', 'Ranked 11th Support on MetaBot (45th percentile). HP 91 · P.DEF 101.'),
  ('aniimo', 'Apoyo', 'aniimo-076', 2, 'metabot.gg', 45, 'Puesto 12 de Apoyo en MetaBot (percentil 45). PV 90 · DEF F. 100.', 'Ranked 12th Support on MetaBot (45th percentile). HP 90 · P.DEF 100.'),
  ('aniimo', 'Apoyo', 'aniimo-078', 2, 'metabot.gg', 34, 'Puesto 13 de Apoyo en MetaBot (percentil 34). PV 99 · DEF F. 72.', 'Ranked 13th Support on MetaBot (34th percentile). HP 99 · P.DEF 72.'),
  ('aniimo', 'Apoyo', 'aniimo-017', 2, 'metabot.gg', 29, 'Puesto 14 de Apoyo en MetaBot (percentil 29). PV 80 · DEF F. 69.', 'Ranked 14th Support on MetaBot (29th percentile). HP 80 · P.DEF 69.'),
  ('aniimo', 'Apoyo', 'aniimo-038', 3, 'metabot.gg', 24, 'Puesto 15 de Apoyo en MetaBot (percentil 24). PV 71 · DEF F. 58.', 'Ranked 15th Support on MetaBot (24th percentile). HP 71 · P.DEF 58.'),
  ('aniimo', 'Apoyo', 'aniimo-007', 3, 'metabot.gg', 18, 'Puesto 16 de Apoyo en MetaBot (percentil 18). PV 97 · DEF F. 67.', 'Ranked 16th Support on MetaBot (18th percentile). HP 97 · P.DEF 67.'),
  ('aniimo', 'Apoyo', 'aniimo-077', 3, 'metabot.gg', 13, 'Puesto 17 de Apoyo en MetaBot (percentil 13). PV 83 · DEF F. 63.', 'Ranked 17th Support on MetaBot (13th percentile). HP 83 · P.DEF 63.'),
  ('aniimo', 'Apoyo', 'aniimo-075', 3, 'metabot.gg', 8, 'Puesto 18 de Apoyo en MetaBot (percentil 8). PV 77 · DEF F. 67.', 'Ranked 18th Support on MetaBot (8th percentile). HP 77 · P.DEF 67.'),
  ('aniimo', 'Apoyo', 'aniimo-031', 3, 'metabot.gg', 3, 'Puesto 19 de Apoyo en MetaBot (percentil 3). PV 70 · DEF F. 70.', 'Ranked 19th Support on MetaBot (3rd percentile). HP 70 · P.DEF 70.'),
  ('aniimo', 'Curación', 'aniimo-029', 0, 'metabot.gg', 90, 'Puesto 1 de Curación en MetaBot (percentil 90). PV 110 · DEF M. 85.', 'Ranked 1st Heal on MetaBot (90th percentile). HP 110 · M.DEF 85.'),
  ('aniimo', 'Curación', 'aniimo-015', 1, 'metabot.gg', 70, 'Puesto 2 de Curación en MetaBot (percentil 70). PV 120 · DEF M. 110.', 'Ranked 2nd Heal on MetaBot (70th percentile). HP 120 · M.DEF 110.'),
  ('aniimo', 'Curación', 'aniimo-014', 2, 'metabot.gg', 50, 'Puesto 3 de Curación en MetaBot (percentil 50). PV 109 · DEF M. 98.', 'Ranked 3rd Heal on MetaBot (50th percentile). HP 109 · M.DEF 98.'),
  ('aniimo', 'Curación', 'aniimo-028', 2, 'metabot.gg', 30, 'Puesto 4 de Curación en MetaBot (percentil 30). PV 94 · DEF M. 68.', 'Ranked 4th Heal on MetaBot (30th percentile). HP 94 · M.DEF 68.'),
  ('aniimo', 'Curación', 'aniimo-013', 3, 'metabot.gg', 10, 'Puesto 5 de Curación en MetaBot (percentil 10). PV 80 · DEF M. 76.', 'Ranked 5th Heal on MetaBot (10th percentile). HP 80 · M.DEF 76.'),
  ('aniimo', 'DPS', 'aniimo-062', 0, 'metabot.gg', 98, 'Puesto 1 de DPS en MetaBot (percentil 98). ATQ 125 · REGEN. 81.', 'Ranked 1st DPS on MetaBot (98th percentile). ATK 125 · REGEN 81.'),
  ('aniimo', 'DPS', 'aniimo-003', 0, 'metabot.gg', 94, 'Puesto 2 de DPS en MetaBot (percentil 94). ATQ 119 · REGEN. 90.', 'Ranked 2nd DPS on MetaBot (94th percentile). ATK 119 · REGEN 90.'),
  ('aniimo', 'DPS', 'aniimo-034', 0, 'metabot.gg', 94, 'Puesto 3 de DPS en MetaBot (percentil 94). ATQ 121 · REGEN. 92.', 'Ranked 3rd DPS on MetaBot (94th percentile). ATK 121 · REGEN 92.'),
  ('aniimo', 'DPS', 'aniimo-041', 0, 'metabot.gg', 89, 'Puesto 4 de DPS en MetaBot (percentil 89). ATQ 125 · REGEN. 91.', 'Ranked 4th DPS on MetaBot (89th percentile). ATK 125 · REGEN 91.'),
  ('aniimo', 'DPS', 'aniimo-057', 0, 'metabot.gg', 84, 'Puesto 5 de DPS en MetaBot (percentil 84). ATQ 114 · REGEN. 100.', 'Ranked 5th DPS on MetaBot (84th percentile). ATK 114 · REGEN 100.'),
  ('aniimo', 'DPS', 'aniimo-055', 1, 'metabot.gg', 84, 'Puesto 6 de DPS en MetaBot (percentil 84). ATQ 121 · REGEN. 88.', 'Ranked 6th DPS on MetaBot (84th percentile). ATK 121 · REGEN 88.'),
  ('aniimo', 'DPS', 'aniimo-009', 1, 'metabot.gg', 80, 'Puesto 7 de DPS en MetaBot (percentil 80). ATQ 121 · REGEN. 94.', 'Ranked 7th DPS on MetaBot (80th percentile). ATK 121 · REGEN 94.'),
  ('aniimo', 'DPS', 'aniimo-067', 1, 'metabot.gg', 77, 'Puesto 8 de DPS en MetaBot (percentil 77). ATQ 125 · REGEN. 80.', 'Ranked 8th DPS on MetaBot (77th percentile). ATK 125 · REGEN 80.'),
  ('aniimo', 'DPS', 'aniimo-044', 1, 'metabot.gg', 70, 'Puesto 10 de DPS en MetaBot (percentil 70). ATQ 118 · REGEN. 98.', 'Ranked 10th DPS on MetaBot (70th percentile). ATK 118 · REGEN 98.'),
  ('aniimo', 'DPS', 'aniimo-012', 1, 'metabot.gg', 67, 'Puesto 11 de DPS en MetaBot (percentil 67). ATQ 118 · REGEN. 94.', 'Ranked 11th DPS on MetaBot (67th percentile). ATK 118 · REGEN 94.'),
  ('aniimo', 'DPS', 'aniimo-10003', 1, 'metabot.gg', 64, 'Puesto 12 de DPS en MetaBot (percentil 64). ATQ 130 · REGEN. 105.', 'Ranked 12th DPS on MetaBot (64th percentile). ATK 130 · REGEN 105.'),
  ('aniimo', 'DPS', 'aniimo-069', 1, 'metabot.gg', 61, 'Puesto 13 de DPS en MetaBot (percentil 61). ATQ 124 · REGEN. 75.', 'Ranked 13th DPS on MetaBot (61st percentile). ATK 124 · REGEN 75.'),
  ('aniimo', 'DPS', 'aniimo-006', 2, 'metabot.gg', 58, 'Puesto 14 de DPS en MetaBot (percentil 58). ATQ 125 · REGEN. 94.', 'Ranked 14th DPS on MetaBot (58th percentile). ATK 125 · REGEN 94.'),
  ('aniimo', 'DPS', 'aniimo-060', 2, 'metabot.gg', 55, 'Puesto 15 de DPS en MetaBot (percentil 55). ATQ 125 · REGEN. 90.', 'Ranked 15th DPS on MetaBot (55th percentile). ATK 125 · REGEN 90.'),
  ('aniimo', 'DPS', 'aniimo-99996', 2, 'metabot.gg', 50, 'Puesto 17 de DPS en MetaBot (percentil 50). ATQ 116 · REGEN. 90.', 'Ranked 17th DPS on MetaBot (50th percentile). ATK 116 · REGEN 90.'),
  ('aniimo', 'DPS', 'aniimo-054', 2, 'metabot.gg', 45, 'Puesto 18 de DPS en MetaBot (percentil 45). ATQ 109 · REGEN. 79.', 'Ranked 18th DPS on MetaBot (45th percentile). ATK 109 · REGEN 79.'),
  ('aniimo', 'DPS', 'aniimo-033', 2, 'metabot.gg', 41, 'Puesto 19 de DPS en MetaBot (percentil 41). ATQ 107 · REGEN. 78.', 'Ranked 19th DPS on MetaBot (41st percentile). ATK 107 · REGEN 78.'),
  ('aniimo', 'DPS', 'aniimo-040', 2, 'metabot.gg', 41, 'Puesto 20 de DPS en MetaBot (percentil 41). ATQ 112 · REGEN. 77.', 'Ranked 20th DPS on MetaBot (41st percentile). ATK 112 · REGEN 77.'),
  ('aniimo', 'DPS', 'aniimo-002', 2, 'metabot.gg', 34, 'Puesto 21 de DPS en MetaBot (percentil 34). ATQ 111 · REGEN. 80.', 'Ranked 21st DPS on MetaBot (34th percentile). ATK 111 · REGEN 80.'),
  ('aniimo', 'DPS', 'aniimo-056', 2, 'metabot.gg', 34, 'Puesto 22 de DPS en MetaBot (percentil 34). ATQ 98 · REGEN. 85.', 'Ranked 22nd DPS on MetaBot (34th percentile). ATK 98 · REGEN 85.'),
  ('aniimo', 'DPS', 'aniimo-043', 2, 'metabot.gg', 30, 'Puesto 23 de DPS en MetaBot (percentil 30). ATQ 105 · REGEN. 81.', 'Ranked 23rd DPS on MetaBot (30th percentile). ATK 105 · REGEN 81.'),
  ('aniimo', 'DPS', 'aniimo-053', 3, 'metabot.gg', 27, 'Puesto 24 de DPS en MetaBot (percentil 27). ATQ 90 · REGEN. 66.', 'Ranked 24th DPS on MetaBot (27th percentile). ATK 90 · REGEN 66.'),
  ('aniimo', 'DPS', 'aniimo-99998', 3, 'metabot.gg', 22, 'Puesto 25 de DPS en MetaBot (percentil 22). ATQ 116 · REGEN. 90.', 'Ranked 25th DPS on MetaBot (22nd percentile). ATK 116 · REGEN 90.'),
  ('aniimo', 'DPS', 'aniimo-011', 3, 'metabot.gg', 17, 'Puesto 27 de DPS en MetaBot (percentil 17). ATQ 101 · REGEN. 71.', 'Ranked 27th DPS on MetaBot (17th percentile). ATK 101 · REGEN 71.'),
  ('aniimo', 'DPS', 'aniimo-001', 3, 'metabot.gg', 14, 'Puesto 28 de DPS en MetaBot (percentil 14). ATQ 90 · REGEN. 68.', 'Ranked 28th DPS on MetaBot (14th percentile). ATK 90 · REGEN 68.'),
  ('aniimo', 'DPS', 'aniimo-042', 3, 'metabot.gg', 11, 'Puesto 29 de DPS en MetaBot (percentil 11). ATQ 88 · REGEN. 67.', 'Ranked 29th DPS on MetaBot (11th percentile). ATK 88 · REGEN 67.'),
  ('aniimo', 'DPS', 'aniimo-005', 3, 'metabot.gg', 8, 'Puesto 30 de DPS en MetaBot (percentil 8). ATQ 106 · REGEN. 80.', 'Ranked 30th DPS on MetaBot (8th percentile). ATK 106 · REGEN 80.'),
  ('aniimo', 'DPS', 'aniimo-059', 3, 'metabot.gg', 5, 'Puesto 31 de DPS en MetaBot (percentil 5). ATQ 106 · REGEN. 77.', 'Ranked 31st DPS on MetaBot (5th percentile). ATK 106 · REGEN 77.'),
  ('aniimo', 'DPS', 'aniimo-068', 3, 'metabot.gg', 2, 'Puesto 32 de DPS en MetaBot (percentil 2). ATQ 100 · REGEN. 70.', 'Ranked 32nd DPS on MetaBot (2nd percentile). ATK 100 · REGEN 70.'),
  ('aniimo', 'Regeneración', 'aniimo-081', 0, 'metabot.gg', 94, 'Puesto 1 de Regeneración en MetaBot (percentil 94). REGEN. 110 · PV 120.', 'Ranked 1st Regen on MetaBot (94th percentile). REGEN 110 · HP 120.'),
  ('aniimo', 'Regeneración', 'aniimo-016', 1, 'metabot.gg', 69, 'Puesto 3 de Regeneración en MetaBot (percentil 69). REGEN. 106 · PV 120.', 'Ranked 3rd Regen on MetaBot (69th percentile). REGEN 106 · HP 120.'),
  ('aniimo', 'Regeneración', 'aniimo-021', 1, 'metabot.gg', 56, 'Puesto 4 de Regeneración en MetaBot (percentil 56). REGEN. 115 · PV 115.', 'Ranked 4th Regen on MetaBot (56th percentile). REGEN 115 · HP 115.'),
  ('aniimo', 'Regeneración', 'aniimo-027', 2, 'metabot.gg', 38, 'Puesto 5 de Regeneración en MetaBot (percentil 38). REGEN. 115 · PV 80.', 'Ranked 5th Regen on MetaBot (38th percentile). REGEN 115 · HP 80.'),
  ('aniimo', 'Regeneración', 'aniimo-082', 2, 'metabot.gg', 38, 'Puesto 6 de Regeneración en MetaBot (percentil 38). REGEN. 118 · PV 88.', 'Ranked 6th Regen on MetaBot (38th percentile). REGEN 118 · HP 88.'),
  ('aniimo', 'Regeneración', 'aniimo-080', 3, 'metabot.gg', 19, 'Puesto 7 de Regeneración en MetaBot (percentil 19). REGEN. 93 · PV 102.', 'Ranked 7th Regen on MetaBot (19th percentile). REGEN 93 · HP 102.'),
  ('aniimo', 'Regeneración', 'aniimo-026', 3, 'metabot.gg', 6, 'Puesto 8 de Regeneración en MetaBot (percentil 6). REGEN. 98 · PV 69.', 'Ranked 8th Regen on MetaBot (6th percentile). REGEN 98 · HP 69.'),
  ('aniimo', 'Ruptura', 'aniimo-072', 0, 'metabot.gg', 98, 'Puesto 1 de Ruptura en MetaBot (percentil 98). RUPT. 104 · ATQ 91.', 'Ranked 1st Break on MetaBot (98th percentile). BREAK 104 · ATK 91.'),
  ('aniimo', 'Ruptura', 'aniimo-037', 0, 'metabot.gg', 94, 'Puesto 2 de Ruptura en MetaBot (percentil 94). RUPT. 107 · ATQ 90.', 'Ranked 2nd Break on MetaBot (94th percentile). BREAK 107 · ATK 90.'),
  ('aniimo', 'Ruptura', 'aniimo-074', 0, 'metabot.gg', 90, 'Puesto 3 de Ruptura en MetaBot (percentil 90). RUPT. 105 · ATQ 90.', 'Ranked 3rd Break on MetaBot (90th percentile). BREAK 105 · ATK 90.'),
  ('aniimo', 'Ruptura', 'aniimo-063', 0, 'metabot.gg', 85, 'Puesto 4 de Ruptura en MetaBot (percentil 85). RUPT. 105 · ATQ 90.', 'Ranked 4th Break on MetaBot (85th percentile). BREAK 105 · ATK 90.'),
  ('aniimo', 'Ruptura', 'aniimo-048', 1, 'metabot.gg', 85, 'Puesto 5 de Ruptura en MetaBot (percentil 85). RUPT. 108 · ATQ 82.', 'Ranked 5th Break on MetaBot (85th percentile). BREAK 108 · ATK 82.'),
  ('aniimo', 'Ruptura', 'aniimo-052', 1, 'metabot.gg', 79, 'Puesto 6 de Ruptura en MetaBot (percentil 79). RUPT. 100 · ATQ 85.', 'Ranked 6th Break on MetaBot (79th percentile). BREAK 100 · ATK 85.'),
  ('aniimo', 'Ruptura', 'aniimo-004', 1, 'metabot.gg', 75, 'Puesto 7 de Ruptura en MetaBot (percentil 75). RUPT. 108 · ATQ 89.', 'Ranked 7th Break on MetaBot (75th percentile). BREAK 108 · ATK 89.'),
  ('aniimo', 'Ruptura', 'aniimo-025', 1, 'metabot.gg', 67, 'Puesto 8 de Ruptura en MetaBot (percentil 67). RUPT. 103 · ATQ 80.', 'Ranked 8th Break on MetaBot (67th percentile). BREAK 103 · ATK 80.'),
  ('aniimo', 'Ruptura', 'aniimo-066', 1, 'metabot.gg', 67, 'Puesto 9 de Ruptura en MetaBot (percentil 67). RUPT. 102 · ATQ 87.', 'Ranked 9th Break on MetaBot (67th percentile). BREAK 102 · ATK 87.'),
  ('aniimo', 'Ruptura', 'aniimo-046', 1, 'metabot.gg', 67, 'Puesto 10 de Ruptura en MetaBot (percentil 67). RUPT. 104 · ATQ 100.', 'Ranked 10th Break on MetaBot (67th percentile). BREAK 104 · ATK 100.'),
  ('aniimo', 'Ruptura', 'aniimo-024', 1, 'metabot.gg', 60, 'Puesto 11 de Ruptura en MetaBot (percentil 60). RUPT. 104 · ATQ 80.', 'Ranked 11th Break on MetaBot (60th percentile). BREAK 104 · ATK 80.'),
  ('aniimo', 'Ruptura', 'aniimo-010', 2, 'metabot.gg', 56, 'Puesto 12 de Ruptura en MetaBot (percentil 56). RUPT. 107 · ATQ 80.', 'Ranked 12th Break on MetaBot (56th percentile). BREAK 107 · ATK 80.'),
  ('aniimo', 'Ruptura', 'aniimo-022', 2, 'metabot.gg', 52, 'Puesto 13 de Ruptura en MetaBot (percentil 52). RUPT. 100 · ATQ 80.', 'Ranked 13th Break on MetaBot (52nd percentile). BREAK 100 · ATK 80.'),
  ('aniimo', 'Ruptura', 'aniimo-050', 2, 'metabot.gg', 48, 'Puesto 14 de Ruptura en MetaBot (percentil 48). RUPT. 80 · ATQ 96.', 'Ranked 14th Break on MetaBot (48th percentile). BREAK 80 · ATK 96.'),
  ('aniimo', 'Ruptura', 'aniimo-036', 2, 'metabot.gg', 42, 'Puesto 15 de Ruptura en MetaBot (percentil 42). RUPT. 91 · ATQ 72.', 'Ranked 15th Break on MetaBot (42nd percentile). BREAK 91 · ATK 72.'),
  ('aniimo', 'Ruptura', 'aniimo-071', 2, 'metabot.gg', 42, 'Puesto 16 de Ruptura en MetaBot (percentil 42). RUPT. 93 · ATQ 82.', 'Ranked 16th Break on MetaBot (42nd percentile). BREAK 93 · ATK 82.'),
  ('aniimo', 'Ruptura', 'aniimo-049', 2, 'metabot.gg', 35, 'Puesto 17 de Ruptura en MetaBot (percentil 35). RUPT. 72 · ATQ 61.', 'Ranked 17th Break on MetaBot (35th percentile). BREAK 72 · ATK 61.'),
  ('aniimo', 'Ruptura', 'aniimo-073', 2, 'metabot.gg', 35, 'Puesto 18 de Ruptura en MetaBot (percentil 35). RUPT. 102 · ATQ 81.', 'Ranked 18th Break on MetaBot (35th percentile). BREAK 102 · ATK 81.'),
  ('aniimo', 'Ruptura', 'aniimo-065', 2, 'metabot.gg', 29, 'Puesto 19 de Ruptura en MetaBot (percentil 29). RUPT. 92 · ATQ 78.', 'Ranked 19th Break on MetaBot (29th percentile). BREAK 92 · ATK 78.'),
  ('aniimo', 'Ruptura', 'aniimo-047', 3, 'metabot.gg', 25, 'Puesto 20 de Ruptura en MetaBot (percentil 25). RUPT. 94 · ATQ 80.', 'Ranked 20th Break on MetaBot (25th percentile). BREAK 94 · ATK 80.'),
  ('aniimo', 'Ruptura', 'aniimo-020', 3, 'metabot.gg', 19, 'Puesto 21 de Ruptura en MetaBot (percentil 19). RUPT. 80 · ATQ 68.', 'Ranked 21st Break on MetaBot (19th percentile). BREAK 80 · ATK 68.'),
  ('aniimo', 'Ruptura', 'aniimo-045', 3, 'metabot.gg', 19, 'Puesto 22 de Ruptura en MetaBot (percentil 19). RUPT. 87 · ATQ 85.', 'Ranked 22nd Break on MetaBot (19th percentile). BREAK 87 · ATK 85.'),
  ('aniimo', 'Ruptura', 'aniimo-064', 3, 'metabot.gg', 13, 'Puesto 23 de Ruptura en MetaBot (percentil 13). RUPT. 76 · ATQ 65.', 'Ranked 23rd Break on MetaBot (13th percentile). BREAK 76 · ATK 65.'),
  ('aniimo', 'Ruptura', 'aniimo-023', 3, 'metabot.gg', 10, 'Puesto 24 de Ruptura en MetaBot (percentil 10). RUPT. 84 · ATQ 64.', 'Ranked 24th Break on MetaBot (10th percentile). BREAK 84 · ATK 64.'),
  ('aniimo', 'Ruptura', 'aniimo-070', 3, 'metabot.gg', 6, 'Puesto 25 de Ruptura en MetaBot (percentil 6). RUPT. 79 · ATQ 68.', 'Ranked 25th Break on MetaBot (6th percentile). BREAK 79 · ATK 68.'),
  ('aniimo', 'Ruptura', 'aniimo-061', 3, 'metabot.gg', 2, 'Puesto 26 de Ruptura en MetaBot (percentil 2). RUPT. 60 · ATQ 52.', 'Ranked 26th Break on MetaBot (2nd percentile). BREAK 60 · ATK 52.')
on conflict (game_id, mode, character_id) do update
  set rating = excluded.rating,
      source = excluded.source,
      percentile = excluded.percentile,
      note_es = excluded.note_es,
      note_en = excluded.note_en,
      updated_at = now();

-- Comprobacion
select mode, rating, count(*) as criaturas
from public.tier_lists_oficial
where game_id = 'aniimo'
group by mode, rating
order by mode, rating;

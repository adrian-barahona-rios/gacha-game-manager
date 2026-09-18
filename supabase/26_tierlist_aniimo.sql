-- Ejecutar en Supabase -> SQL Editor -> New query -> Run.
-- Requiere 01_esquema.sql y 05_personajes_aniimo.sql.
--
-- Tier list de Aniimo: 83 criaturas valoradas por las guias de Game8.
-- La escala de la app va al reves que las letras: 0 es el tier mas alto, asi
-- que S = 0, A = 1, B = 2, C = 3 y D = 4.
--
-- Es una valoracion de la comunidad, no un dato oficial del juego, y cambiara
-- segun se asiente el meta: el juego salio el 16 de septiembre de 2026.
--
-- Inserta lo que falte y actualiza lo que ya exista.
--
-- Generado el 2026-09-18.

insert into public.tier_lists_oficial (
  game_id, mode, character_id, rating, source
)
values
  ('aniimo', 'General', 'aniimo-082', 0, 'game8.co'),
  ('aniimo', 'General', 'aniimo-032', 0, 'game8.co'),
  ('aniimo', 'General', 'aniimo-10003', 0, 'game8.co'),
  ('aniimo', 'General', 'aniimo-025', 0, 'game8.co'),
  ('aniimo', 'General', 'aniimo-029', 0, 'game8.co'),
  ('aniimo', 'General', 'aniimo-99998', 0, 'game8.co'),
  ('aniimo', 'General', 'aniimo-041', 0, 'game8.co'),
  ('aniimo', 'General', 'aniimo-004', 0, 'game8.co'),
  ('aniimo', 'General', 'aniimo-016', 0, 'game8.co'),
  ('aniimo', 'General', 'aniimo-079', 0, 'game8.co'),
  ('aniimo', 'General', 'aniimo-99996', 0, 'game8.co'),
  ('aniimo', 'General', 'aniimo-006', 0, 'game8.co'),
  ('aniimo', 'General', 'aniimo-010', 0, 'game8.co'),
  ('aniimo', 'General', 'aniimo-019', 1, 'game8.co'),
  ('aniimo', 'General', 'aniimo-060', 1, 'game8.co'),
  ('aniimo', 'General', 'aniimo-015', 1, 'game8.co'),
  ('aniimo', 'General', 'aniimo-069', 1, 'game8.co'),
  ('aniimo', 'General', 'aniimo-066', 1, 'game8.co'),
  ('aniimo', 'General', 'aniimo-035', 1, 'game8.co'),
  ('aniimo', 'General', 'aniimo-062', 1, 'game8.co'),
  ('aniimo', 'General', 'aniimo-034', 1, 'game8.co'),
  ('aniimo', 'General', 'aniimo-040', 1, 'game8.co'),
  ('aniimo', 'General', 'aniimo-033', 2, 'game8.co'),
  ('aniimo', 'General', 'aniimo-009', 2, 'game8.co'),
  ('aniimo', 'General', 'aniimo-068', 2, 'game8.co'),
  ('aniimo', 'General', 'aniimo-10002', 2, 'game8.co'),
  ('aniimo', 'General', 'aniimo-031', 2, 'game8.co'),
  ('aniimo', 'General', 'aniimo-081', 2, 'game8.co'),
  ('aniimo', 'General', 'aniimo-027', 2, 'game8.co'),
  ('aniimo', 'General', 'aniimo-028', 2, 'game8.co'),
  ('aniimo', 'General', 'aniimo-039', 2, 'game8.co'),
  ('aniimo', 'General', 'aniimo-073', 2, 'game8.co'),
  ('aniimo', 'General', 'aniimo-061', 2, 'game8.co'),
  ('aniimo', 'General', 'aniimo-021', 2, 'game8.co'),
  ('aniimo', 'General', 'aniimo-074', 2, 'game8.co'),
  ('aniimo', 'General', 'aniimo-070', 2, 'game8.co'),
  ('aniimo', 'General', 'aniimo-051', 2, 'game8.co'),
  ('aniimo', 'General', 'aniimo-063', 2, 'game8.co'),
  ('aniimo', 'General', 'aniimo-008', 2, 'game8.co'),
  ('aniimo', 'General', 'aniimo-057', 2, 'game8.co'),
  ('aniimo', 'General', 'aniimo-056', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-046', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-005', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-007', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-038', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-080', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-044', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-065', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-020', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-067', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-011', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-012', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-064', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-052', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-037', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-050', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-014', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-003', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-055', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-013', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-026', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-049', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-022', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-018', 3, 'game8.co'),
  ('aniimo', 'General', 'aniimo-076', 4, 'game8.co'),
  ('aniimo', 'General', 'aniimo-045', 4, 'game8.co'),
  ('aniimo', 'General', 'aniimo-042', 4, 'game8.co'),
  ('aniimo', 'General', 'aniimo-058', 4, 'game8.co'),
  ('aniimo', 'General', 'aniimo-023', 4, 'game8.co'),
  ('aniimo', 'General', 'aniimo-077', 4, 'game8.co'),
  ('aniimo', 'General', 'aniimo-075', 4, 'game8.co'),
  ('aniimo', 'General', 'aniimo-001', 4, 'game8.co'),
  ('aniimo', 'General', 'aniimo-043', 4, 'game8.co'),
  ('aniimo', 'General', 'aniimo-059', 4, 'game8.co'),
  ('aniimo', 'General', 'aniimo-002', 4, 'game8.co'),
  ('aniimo', 'General', 'aniimo-071', 4, 'game8.co'),
  ('aniimo', 'General', 'aniimo-072', 4, 'game8.co'),
  ('aniimo', 'General', 'aniimo-017', 4, 'game8.co'),
  ('aniimo', 'General', 'aniimo-036', 4, 'game8.co'),
  ('aniimo', 'General', 'aniimo-054', 4, 'game8.co'),
  ('aniimo', 'General', 'aniimo-053', 4, 'game8.co'),
  ('aniimo', 'General', 'aniimo-024', 4, 'game8.co'),
  ('aniimo', 'General', 'aniimo-078', 4, 'game8.co')
on conflict (game_id, mode, character_id) do update
  set rating = excluded.rating,
      source = excluded.source,
      updated_at = now();

-- Comprobacion
select rating, count(*) as criaturas
from public.tier_lists_oficial
where game_id = 'aniimo'
group by rating
order by rating;

-- Ejecutar en Supabase → SQL Editor → New query → Run.
-- Requiere characters_full.sql y characters_genshin_missing.sql.
--
-- Ratings tomados de las tier lists de Prydwen (prydwen.gg) el 2026-09-08.
-- Escala de Prydwen: 0 es el tier mas alto y 5 el mas bajo.
--
-- Solo se incluye el modo que la pagina entrega ya renderizado. En Honkai es
-- Memory of Chaos; Pure Fiction y Apocalyptic Shadow se cargan por JavaScript
-- y no se pueden leer sin un navegador. Genshin y Zenless publican una unica
-- lista, sin modos.

create table if not exists public.tier_lists_oficial (
  game_id text not null,
  mode text not null,
  character_id text not null references public.characters (id) on delete cascade,
  rating numeric(2,1) not null,
  source text not null default 'prydwen.gg',
  updated_at timestamptz not null default now(),
  primary key (game_id, mode, character_id)
);

create index if not exists tier_lists_oficial_game_mode_idx
  on public.tier_lists_oficial (game_id, mode);

alter table public.tier_lists_oficial enable row level security;

create policy "Las tier lists oficiales se pueden consultar"
  on public.tier_lists_oficial for select
  using (true);

create table if not exists public.tier_lists_personal (
  user_id uuid not null references public.profiles (id) on delete cascade,
  game_id text not null,
  character_id text not null references public.characters (id) on delete cascade,
  tier text not null check (tier in ('S', 'A', 'B', 'C')),
  updated_at timestamptz not null default now(),
  primary key (user_id, game_id, character_id)
);

create index if not exists tier_lists_personal_user_game_idx
  on public.tier_lists_personal (user_id, game_id);

alter table public.tier_lists_personal enable row level security;

create policy "Cada usuario ve su tier list"
  on public.tier_lists_personal for select
  using (auth.uid() = user_id);

create policy "Cada usuario crea su tier list"
  on public.tier_lists_personal for insert
  with check (auth.uid() = user_id);

create policy "Cada usuario actualiza su tier list"
  on public.tier_lists_personal for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create policy "Cada usuario borra de su tier list"
  on public.tier_lists_personal for delete
  using (auth.uid() = user_id);

-- Se puede repetir: reemplaza los ratings existentes.
delete from public.tier_lists_oficial
where game_id in ('genshin-impact', 'honkai-star-rail', 'zenless-zone-zero');

insert into public.tier_lists_oficial (game_id, mode, character_id, rating) values
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-archer', 0),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-castorice', 0),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-cyrene', 0),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-firefly', 0),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-huohuo', 0),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-hyacine', 0),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-rin-tohsaka', 0),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-acheron', 0.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-black-swan', 0.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-gilgamesh', 0.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-hysilens', 0.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-kafka', 0.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-permanser-terrae', 0.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-ruan-mei', 0.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-saber', 0.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-sparkle', 0.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-trazacaminos-hielo', 0.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-trazacaminos-imaginario', 0.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-tribbie', 0.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-welt', 0.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-anaxa', 1),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-cerydra', 1),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-cipher', 1),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-fu-xuan', 1),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-lingsha', 1),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-phainon', 1),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-silver-wolf', 1),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-sunday', 1),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-aglaea', 1.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-aventurine', 1.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-feixiao', 1.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-gallagher', 1.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-mydei', 1.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-robin', 1.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-the-herta', 1.5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-boothill', 2),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-bronya', 2),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-jade', 2),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-luocha', 2),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-rappa', 2),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-seele', 2),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-asta', 3),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-bailu', 3),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-blade', 3),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-herta', 3),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-jiaoqiu', 3),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-jingliu', 3),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-lynx', 3),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-tingyun', 3),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-topaz', 3),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-yunli', 3),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-argenti', 4),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-clara', 4),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-gepard', 4),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-himeko', 4),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-imbibitor-lunae', 4),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-jing-yuan', 4),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-moze', 4),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-pela', 4),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-serval', 4),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-arlan', 5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-dan-heng', 5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-dr-ratio', 5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-guinaifen', 5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-hanya', 5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-hook', 5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-luka', 5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-march-7th', 5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-misha', 5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-natasha', 5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-qingque', 5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-sampo', 5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-sushang', 5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-trazacaminos-fisico', 5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-trazacaminos-fuego', 5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-xueyi', 5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-yanqing', 5),
  ('honkai-star-rail', 'Memory of Chaos', 'hsr-yukong', 5),
  ('genshin-impact', 'General', 'gi-chevreuse', 0),
  ('genshin-impact', 'General', 'gi-citlali', 0),
  ('genshin-impact', 'General', 'gi-columbina', 0),
  ('genshin-impact', 'General', 'gi-iansan', 0),
  ('genshin-impact', 'General', 'gi-ineffa', 0),
  ('genshin-impact', 'General', 'gi-lauma', 0),
  ('genshin-impact', 'General', 'gi-linnea', 0),
  ('genshin-impact', 'General', 'gi-mavuika', 0),
  ('genshin-impact', 'General', 'gi-mona', 0),
  ('genshin-impact', 'General', 'gi-nefer', 0),
  ('genshin-impact', 'General', 'gi-nicole', 0),
  ('genshin-impact', 'General', 'gi-odette', 0),
  ('genshin-impact', 'General', 'gi-sandrone', 0),
  ('genshin-impact', 'General', 'gi-sucrose', 0),
  ('genshin-impact', 'General', 'gi-yae-miko', 0),
  ('genshin-impact', 'General', 'gi-zibai', 0),
  ('genshin-impact', 'General', 'gi-alyosha', 0.5),
  ('genshin-impact', 'General', 'gi-bennett', 0.5),
  ('genshin-impact', 'General', 'gi-cyno', 0.5),
  ('genshin-impact', 'General', 'gi-durin', 0.5),
  ('genshin-impact', 'General', 'gi-escoffier', 0.5),
  ('genshin-impact', 'General', 'gi-fischl', 0.5),
  ('genshin-impact', 'General', 'gi-flins', 0.5),
  ('genshin-impact', 'General', 'gi-illuga', 0.5),
  ('genshin-impact', 'General', 'gi-prune', 0.5),
  ('genshin-impact', 'General', 'gi-qiqi', 0.5),
  ('genshin-impact', 'General', 'gi-skirk', 0.5),
  ('genshin-impact', 'General', 'gi-varka', 0.5),
  ('genshin-impact', 'General', 'gi-wriothesley', 0.5),
  ('genshin-impact', 'General', 'gi-aino', 1),
  ('genshin-impact', 'General', 'gi-albedo', 1),
  ('genshin-impact', 'General', 'gi-arlecchino', 1),
  ('genshin-impact', 'General', 'gi-faruzan', 1),
  ('genshin-impact', 'General', 'gi-furina', 1),
  ('genshin-impact', 'General', 'gi-kinich', 1),
  ('genshin-impact', 'General', 'gi-lohen', 1),
  ('genshin-impact', 'General', 'gi-mualani', 1),
  ('genshin-impact', 'General', 'gi-nahida', 1),
  ('genshin-impact', 'General', 'gi-ororon', 1),
  ('genshin-impact', 'General', 'gi-varesa', 1),
  ('genshin-impact', 'General', 'gi-xilonen', 1),
  ('genshin-impact', 'General', 'gi-beidou', 1.5),
  ('genshin-impact', 'General', 'gi-chiori', 1.5),
  ('genshin-impact', 'General', 'gi-clorinde', 1.5),
  ('genshin-impact', 'General', 'gi-diona', 1.5),
  ('genshin-impact', 'General', 'gi-emilie', 1.5),
  ('genshin-impact', 'General', 'gi-gaming', 1.5),
  ('genshin-impact', 'General', 'gi-gorou', 1.5),
  ('genshin-impact', 'General', 'gi-hu-tao', 1.5),
  ('genshin-impact', 'General', 'gi-jahoda', 1.5),
  ('genshin-impact', 'General', 'gi-kazuha', 1.5),
  ('genshin-impact', 'General', 'gi-klee', 1.5),
  ('genshin-impact', 'General', 'gi-lyney', 1.5),
  ('genshin-impact', 'General', 'gi-navia', 1.5),
  ('genshin-impact', 'General', 'gi-neuvillette', 1.5),
  ('genshin-impact', 'General', 'gi-nilou', 1.5),
  ('genshin-impact', 'General', 'gi-shenhe', 1.5),
  ('genshin-impact', 'General', 'gi-venti', 1.5),
  ('genshin-impact', 'General', 'gi-xiangling', 1.5),
  ('genshin-impact', 'General', 'gi-xingqiu', 1.5),
  ('genshin-impact', 'General', 'gi-yelan', 1.5),
  ('genshin-impact', 'General', 'gi-zhongli', 1.5),
  ('genshin-impact', 'General', 'gi-arataki-itto', 2),
  ('genshin-impact', 'General', 'gi-ayaka', 2),
  ('genshin-impact', 'General', 'gi-charlotte', 2),
  ('genshin-impact', 'General', 'gi-chasca', 2),
  ('genshin-impact', 'General', 'gi-ifa', 2),
  ('genshin-impact', 'General', 'gi-jean', 2),
  ('genshin-impact', 'General', 'gi-kachina', 2),
  ('genshin-impact', 'General', 'gi-kokomi', 2),
  ('genshin-impact', 'General', 'gi-kujou-sara', 2),
  ('genshin-impact', 'General', 'gi-kuki-shinobu', 2),
  ('genshin-impact', 'General', 'gi-lan-yan', 2),
  ('genshin-impact', 'General', 'gi-noelle', 2),
  ('genshin-impact', 'General', 'gi-raiden', 2),
  ('genshin-impact', 'General', 'gi-razor', 2),
  ('genshin-impact', 'General', 'gi-rosaria', 2),
  ('genshin-impact', 'General', 'gi-wanderer', 2),
  ('genshin-impact', 'General', 'gi-xianyun', 2),
  ('genshin-impact', 'General', 'gi-xiao', 2),
  ('genshin-impact', 'General', 'gi-alhaitham', 3),
  ('genshin-impact', 'General', 'gi-baizhu', 3),
  ('genshin-impact', 'General', 'gi-barbara', 3),
  ('genshin-impact', 'General', 'gi-candace', 3),
  ('genshin-impact', 'General', 'gi-chongyun', 3),
  ('genshin-impact', 'General', 'gi-collei', 3),
  ('genshin-impact', 'General', 'gi-dahlia', 3),
  ('genshin-impact', 'General', 'gi-dehya', 3),
  ('genshin-impact', 'General', 'gi-diluc', 3),
  ('genshin-impact', 'General', 'gi-ganyu', 3),
  ('genshin-impact', 'General', 'gi-kaeya', 3),
  ('genshin-impact', 'General', 'gi-kirara', 3),
  ('genshin-impact', 'General', 'gi-layla', 3),
  ('genshin-impact', 'General', 'gi-lynette', 3),
  ('genshin-impact', 'General', 'gi-ningguang', 3),
  ('genshin-impact', 'General', 'gi-sethos', 3),
  ('genshin-impact', 'General', 'gi-thoma', 3),
  ('genshin-impact', 'General', 'gi-yanfei', 3),
  ('genshin-impact', 'General', 'gi-yaoyao', 3),
  ('genshin-impact', 'General', 'gi-yoimiya', 3),
  ('genshin-impact', 'General', 'gi-amber', 4),
  ('genshin-impact', 'General', 'gi-ayato', 4),
  ('genshin-impact', 'General', 'gi-dori', 4),
  ('genshin-impact', 'General', 'gi-eula', 4),
  ('genshin-impact', 'General', 'gi-freminet', 4),
  ('genshin-impact', 'General', 'gi-heizou', 4),
  ('genshin-impact', 'General', 'gi-kaveh', 4),
  ('genshin-impact', 'General', 'gi-keqing', 4),
  ('genshin-impact', 'General', 'gi-lisa', 4),
  ('genshin-impact', 'General', 'gi-mika', 4),
  ('genshin-impact', 'General', 'gi-sayu', 4),
  ('genshin-impact', 'General', 'gi-sigewinne', 4),
  ('genshin-impact', 'General', 'gi-tartaglia', 4),
  ('genshin-impact', 'General', 'gi-tighnari', 4),
  ('genshin-impact', 'General', 'gi-yun-jin', 4),
  ('genshin-impact', 'General', 'gi-aloy', 5),
  ('genshin-impact', 'General', 'gi-xinyan', 5),
  ('zenless-zone-zero', 'General', 'zzz-burnice', 0.5),
  ('zenless-zone-zero', 'General', 'zzz-miyabi', 0.5),
  ('zenless-zone-zero', 'General', 'zzz-nicole', 0.5),
  ('zenless-zone-zero', 'General', 'zzz-rina', 0.5),
  ('zenless-zone-zero', 'General', 'zzz-grace', 1),
  ('zenless-zone-zero', 'General', 'zzz-harumasa', 1),
  ('zenless-zone-zero', 'General', 'zzz-jane-doe', 1),
  ('zenless-zone-zero', 'General', 'zzz-lighter', 1),
  ('zenless-zone-zero', 'General', 'zzz-lycaon', 1),
  ('zenless-zone-zero', 'General', 'zzz-nekomata', 1),
  ('zenless-zone-zero', 'General', 'zzz-piper', 1),
  ('zenless-zone-zero', 'General', 'zzz-soldado-11', 1),
  ('zenless-zone-zero', 'General', 'zzz-yanagi', 1),
  ('zenless-zone-zero', 'General', 'zzz-ellen', 1.5),
  ('zenless-zone-zero', 'General', 'zzz-qingyi', 1.5),
  ('zenless-zone-zero', 'General', 'zzz-soukaku', 1.5),
  ('zenless-zone-zero', 'General', 'zzz-zhu-yuan', 1.5),
  ('zenless-zone-zero', 'General', 'zzz-billy', 2),
  ('zenless-zone-zero', 'General', 'zzz-caesar', 2),
  ('zenless-zone-zero', 'General', 'zzz-corin', 2),
  ('zenless-zone-zero', 'General', 'zzz-koleda', 2),
  ('zenless-zone-zero', 'General', 'zzz-lucy', 2),
  ('zenless-zone-zero', 'General', 'zzz-anby', 3),
  ('zenless-zone-zero', 'General', 'zzz-anton', 3),
  ('zenless-zone-zero', 'General', 'zzz-ben', 3),
  ('zenless-zone-zero', 'General', 'zzz-seth', 3)
on conflict (game_id, mode, character_id) do nothing;

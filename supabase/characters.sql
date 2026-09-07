-- Ejecutar en Supabase → SQL Editor → New query → Run.
--
-- image_url se deja vacio a proposito: las wikis bloquean el enlazado directo
-- de imagenes (devuelven 403), asi que la aplicacion dibuja un respaldo con la
-- inicial y el color del elemento. Rellena la columna cuando tengas imagenes
-- propias, por ejemplo subiendolas a Supabase Storage.

create table if not exists public.characters (
  id text primary key,
  game_id text not null,
  name text not null,
  image_url text,
  rarity text,
  element text,
  level_cap integer,
  description text
);

create index if not exists characters_game_id_idx on public.characters (game_id);

alter table public.characters enable row level security;

-- Catalogo comun: cualquiera lo lee, solo se edita desde el panel de Supabase.
create policy "Los personajes se pueden consultar"
  on public.characters for select
  using (true);

create table if not exists public.favorite_characters (
  user_id uuid not null references auth.users (id) on delete cascade,
  character_id text not null references public.characters (id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (user_id, character_id)
);

alter table public.favorite_characters enable row level security;

create policy "Cada usuario ve sus favoritos"
  on public.favorite_characters for select
  using (auth.uid() = user_id);

create policy "Cada usuario marca sus favoritos"
  on public.favorite_characters for insert
  with check (auth.uid() = user_id);

create policy "Cada usuario borra sus favoritos"
  on public.favorite_characters for delete
  using (auth.uid() = user_id);

-- ---------------------------------------------------------------------------
-- Genshin Impact — nivel maximo 90
-- ---------------------------------------------------------------------------
insert into public.characters (id, game_id, name, rarity, element, level_cap, description) values
  ('gi-amber',      'genshin-impact', 'Amber',           '4', 'Pyro',    90, 'Arco · Mondstadt'),
  ('gi-kaeya',      'genshin-impact', 'Kaeya',           '4', 'Cryo',    90, 'Espada · Mondstadt'),
  ('gi-lisa',       'genshin-impact', 'Lisa',            '4', 'Electro', 90, 'Catalizador · Mondstadt'),
  ('gi-barbara',    'genshin-impact', 'Barbara',         '4', 'Hydro',   90, 'Catalizador · Mondstadt'),
  ('gi-razor',      'genshin-impact', 'Razor',           '4', 'Electro', 90, 'Mandoble · Mondstadt'),
  ('gi-xiangling',  'genshin-impact', 'Xiangling',       '4', 'Pyro',    90, 'Lanza · Liyue'),
  ('gi-beidou',     'genshin-impact', 'Beidou',          '4', 'Electro', 90, 'Mandoble · Liyue'),
  ('gi-xingqiu',    'genshin-impact', 'Xingqiu',         '4', 'Hydro',   90, 'Espada · Liyue'),
  ('gi-ningguang',  'genshin-impact', 'Ningguang',       '4', 'Geo',     90, 'Catalizador · Liyue'),
  ('gi-fischl',     'genshin-impact', 'Fischl',          '4', 'Electro', 90, 'Arco · Mondstadt'),
  ('gi-bennett',    'genshin-impact', 'Bennett',         '4', 'Pyro',    90, 'Espada · Mondstadt'),
  ('gi-noelle',     'genshin-impact', 'Noelle',          '4', 'Geo',     90, 'Mandoble · Mondstadt'),
  ('gi-chongyun',   'genshin-impact', 'Chongyun',        '4', 'Cryo',    90, 'Mandoble · Liyue'),
  ('gi-sucrose',    'genshin-impact', 'Sucrose',         '4', 'Anemo',   90, 'Catalizador · Mondstadt'),
  ('gi-diona',      'genshin-impact', 'Diona',           '4', 'Cryo',    90, 'Arco · Mondstadt'),
  ('gi-diluc',      'genshin-impact', 'Diluc',           '5', 'Pyro',    90, 'Mandoble · Mondstadt'),
  ('gi-jean',       'genshin-impact', 'Jean',            '5', 'Anemo',   90, 'Espada · Mondstadt'),
  ('gi-qiqi',       'genshin-impact', 'Qiqi',            '5', 'Cryo',    90, 'Espada · Liyue'),
  ('gi-mona',       'genshin-impact', 'Mona',            '5', 'Hydro',   90, 'Catalizador · Mondstadt'),
  ('gi-keqing',     'genshin-impact', 'Keqing',          '5', 'Electro', 90, 'Espada · Liyue'),
  ('gi-venti',      'genshin-impact', 'Venti',           '5', 'Anemo',   90, 'Arco · Mondstadt'),
  ('gi-klee',       'genshin-impact', 'Klee',            '5', 'Pyro',    90, 'Catalizador · Mondstadt'),
  ('gi-zhongli',    'genshin-impact', 'Zhongli',         '5', 'Geo',     90, 'Lanza · Liyue'),
  ('gi-ganyu',      'genshin-impact', 'Ganyu',           '5', 'Cryo',    90, 'Arco · Liyue'),
  ('gi-hu-tao',     'genshin-impact', 'Hu Tao',          '5', 'Pyro',    90, 'Lanza · Liyue'),
  ('gi-raiden',     'genshin-impact', 'Raiden Shogun',   '5', 'Electro', 90, 'Lanza · Inazuma'),
  ('gi-ayaka',      'genshin-impact', 'Kamisato Ayaka',  '5', 'Cryo',    90, 'Espada · Inazuma'),
  ('gi-yoimiya',    'genshin-impact', 'Yoimiya',         '5', 'Pyro',    90, 'Arco · Inazuma'),
  ('gi-nahida',     'genshin-impact', 'Nahida',          '5', 'Dendro',  90, 'Catalizador · Sumeru')
on conflict (id) do nothing;

-- ---------------------------------------------------------------------------
-- Honkai: Star Rail — nivel maximo 80
-- ---------------------------------------------------------------------------
insert into public.characters (id, game_id, name, rarity, element, level_cap, description) values
  ('hsr-march-7th',    'honkai-star-rail', 'March 7th',    '4', 'Hielo',      80, 'Senda de la Preservación'),
  ('hsr-dan-heng',     'honkai-star-rail', 'Dan Heng',     '4', 'Viento',     80, 'Senda de la Cacería'),
  ('hsr-asta',         'honkai-star-rail', 'Asta',         '4', 'Fuego',      80, 'Senda de la Armonía'),
  ('hsr-herta',        'honkai-star-rail', 'Herta',        '4', 'Hielo',      80, 'Senda de la Erudición'),
  ('hsr-natasha',      'honkai-star-rail', 'Natasha',      '4', 'Físico',     80, 'Senda de la Abundancia'),
  ('hsr-pela',         'honkai-star-rail', 'Pela',         '4', 'Hielo',      80, 'Senda de la Nihilidad'),
  ('hsr-sampo',        'honkai-star-rail', 'Sampo',        '4', 'Viento',     80, 'Senda de la Nihilidad'),
  ('hsr-hook',         'honkai-star-rail', 'Hook',         '4', 'Fuego',      80, 'Senda de la Destrucción'),
  ('hsr-serval',       'honkai-star-rail', 'Serval',       '4', 'Rayo',       80, 'Senda de la Erudición'),
  ('hsr-tingyun',      'honkai-star-rail', 'Tingyun',      '4', 'Rayo',       80, 'Senda de la Armonía'),
  ('hsr-qingque',      'honkai-star-rail', 'Qingque',      '4', 'Cuántico',   80, 'Senda de la Erudición'),
  ('hsr-sushang',      'honkai-star-rail', 'Sushang',      '4', 'Físico',     80, 'Senda de la Cacería'),
  ('hsr-yukong',       'honkai-star-rail', 'Yukong',       '4', 'Imaginario', 80, 'Senda de la Armonía'),
  ('hsr-bronya',       'honkai-star-rail', 'Bronya',       '5', 'Viento',     80, 'Senda de la Armonía'),
  ('hsr-seele',        'honkai-star-rail', 'Seele',        '5', 'Cuántico',   80, 'Senda de la Cacería'),
  ('hsr-gepard',       'honkai-star-rail', 'Gepard',       '5', 'Hielo',      80, 'Senda de la Preservación'),
  ('hsr-clara',        'honkai-star-rail', 'Clara',        '5', 'Físico',     80, 'Senda de la Destrucción'),
  ('hsr-bailu',        'honkai-star-rail', 'Bailu',        '5', 'Rayo',       80, 'Senda de la Abundancia'),
  ('hsr-welt',         'honkai-star-rail', 'Welt',         '5', 'Imaginario', 80, 'Senda de la Nihilidad'),
  ('hsr-himeko',       'honkai-star-rail', 'Himeko',       '5', 'Fuego',      80, 'Senda de la Erudición'),
  ('hsr-jing-yuan',    'honkai-star-rail', 'Jing Yuan',    '5', 'Rayo',       80, 'Senda de la Erudición'),
  ('hsr-blade',        'honkai-star-rail', 'Blade',        '5', 'Viento',     80, 'Senda de la Destrucción'),
  ('hsr-kafka',        'honkai-star-rail', 'Kafka',        '5', 'Rayo',       80, 'Senda de la Nihilidad'),
  ('hsr-silver-wolf',  'honkai-star-rail', 'Silver Wolf',  '5', 'Cuántico',   80, 'Senda de la Nihilidad'),
  ('hsr-fu-xuan',      'honkai-star-rail', 'Fu Xuan',      '5', 'Cuántico',   80, 'Senda de la Preservación'),
  ('hsr-jingliu',      'honkai-star-rail', 'Jingliu',      '5', 'Hielo',      80, 'Senda de la Destrucción'),
  ('hsr-ruan-mei',     'honkai-star-rail', 'Ruan Mei',     '5', 'Hielo',      80, 'Senda de la Armonía'),
  ('hsr-dr-ratio',     'honkai-star-rail', 'Dr. Ratio',    '5', 'Imaginario', 80, 'Senda de la Cacería'),
  ('hsr-black-swan',   'honkai-star-rail', 'Black Swan',   '5', 'Viento',     80, 'Senda de la Nihilidad'),
  ('hsr-sparkle',      'honkai-star-rail', 'Sparkle',      '5', 'Cuántico',   80, 'Senda de la Armonía')
on conflict (id) do nothing;

-- ---------------------------------------------------------------------------
-- Zenless Zone Zero — nivel maximo 60
-- ---------------------------------------------------------------------------
insert into public.characters (id, game_id, name, rarity, element, level_cap, description) values
  ('zzz-anby',       'zenless-zone-zero', 'Anby Demara',   'A', 'Eléctrico', 60, 'Cunning Hares'),
  ('zzz-nicole',     'zenless-zone-zero', 'Nicole Demara', 'A', 'Éter',      60, 'Cunning Hares'),
  ('zzz-billy',      'zenless-zone-zero', 'Billy Kid',     'A', 'Físico',    60, 'Cunning Hares'),
  ('zzz-nekomata',   'zenless-zone-zero', 'Nekomata',      'S', 'Físico',    60, 'Cunning Hares'),
  ('zzz-corin',      'zenless-zone-zero', 'Corin Wickes',  'A', 'Físico',    60, 'Victoria Housekeeping'),
  ('zzz-rina',       'zenless-zone-zero', 'Alexandrina Sebastiane', 'S', 'Eléctrico', 60, 'Victoria Housekeeping'),
  ('zzz-ellen',      'zenless-zone-zero', 'Ellen Joe',     'S', 'Hielo',     60, 'Victoria Housekeeping'),
  ('zzz-lycaon',     'zenless-zone-zero', 'Von Lycaon',    'S', 'Hielo',     60, 'Victoria Housekeeping'),
  ('zzz-koleda',     'zenless-zone-zero', 'Koleda Belobog','S', 'Fuego',     60, 'Belobog Heavy Industries'),
  ('zzz-ben',        'zenless-zone-zero', 'Ben Bigger',    'A', 'Fuego',     60, 'Belobog Heavy Industries'),
  ('zzz-grace',      'zenless-zone-zero', 'Grace Howard',  'S', 'Eléctrico', 60, 'Belobog Heavy Industries'),
  ('zzz-anton',      'zenless-zone-zero', 'Anton Ivanov',  'A', 'Eléctrico', 60, 'Belobog Heavy Industries'),
  ('zzz-soldier-11', 'zenless-zone-zero', 'Soldier 11',    'S', 'Fuego',     60, 'Obol Squad'),
  ('zzz-zhu-yuan',   'zenless-zone-zero', 'Zhu Yuan',      'S', 'Éter',      60, 'Criminal Investigation Special Response Team'),
  ('zzz-qingyi',     'zenless-zone-zero', 'Qingyi',        'S', 'Eléctrico', 60, 'Criminal Investigation Special Response Team'),
  ('zzz-jane-doe',   'zenless-zone-zero', 'Jane Doe',      'S', 'Físico',    60, 'Criminal Investigation Special Response Team'),
  ('zzz-seth',       'zenless-zone-zero', 'Seth Lowell',   'A', 'Eléctrico', 60, 'Criminal Investigation Special Response Team'),
  ('zzz-piper',      'zenless-zone-zero', 'Piper Wheel',   'A', 'Físico',    60, 'Sons of Calydon'),
  ('zzz-lucy',       'zenless-zone-zero', 'Lucy',          'A', 'Fuego',     60, 'Sons of Calydon'),
  ('zzz-caesar',     'zenless-zone-zero', 'Caesar King',   'S', 'Físico',    60, 'Sons of Calydon'),
  ('zzz-burnice',    'zenless-zone-zero', 'Burnice White', 'S', 'Fuego',     60, 'Sons of Calydon'),
  ('zzz-lighter',    'zenless-zone-zero', 'Lighter',       'S', 'Fuego',     60, 'Sons of Calydon'),
  ('zzz-soukaku',    'zenless-zone-zero', 'Soukaku',       'A', 'Hielo',     60, 'Section 6'),
  ('zzz-miyabi',     'zenless-zone-zero', 'Hoshimi Miyabi','S', 'Hielo',     60, 'Section 6'),
  ('zzz-yanagi',     'zenless-zone-zero', 'Tsukishiro Yanagi', 'S', 'Eléctrico', 60, 'Section 6'),
  ('zzz-harumasa',   'zenless-zone-zero', 'Asaba Harumasa','S', 'Eléctrico', 60, 'Section 6')
on conflict (id) do nothing;

-- ---------------------------------------------------------------------------
-- High School DxD: OPI
-- Solo nombres y papel en la serie: la rareza y los atributos concretos del
-- juego no estan verificados, asi que se dejan vacios para rellenarlos.
-- ---------------------------------------------------------------------------
insert into public.characters (id, game_id, name, description) values
  ('dxd-issei',      'high-school-dxd-opi', 'Issei Hyodo',        'Peón de Rias · portador del Boosted Gear'),
  ('dxd-rias',       'high-school-dxd-opi', 'Rias Gremory',       'Rey del grupo Gremory · heredera del clan'),
  ('dxd-akeno',      'high-school-dxd-opi', 'Akeno Himejima',     'Reina del grupo Gremory'),
  ('dxd-koneko',     'high-school-dxd-opi', 'Koneko Toujou',      'Torre del grupo Gremory · nekomata'),
  ('dxd-asia',       'high-school-dxd-opi', 'Asia Argento',       'Alfil del grupo Gremory · Twilight Healing'),
  ('dxd-kiba',       'high-school-dxd-opi', 'Yuuto Kiba',         'Caballero del grupo Gremory'),
  ('dxd-xenovia',    'high-school-dxd-opi', 'Xenovia Quarta',     'Caballero del grupo Gremory · portadora de Durandal'),
  ('dxd-gasper',     'high-school-dxd-opi', 'Gasper Vladi',       'Alfil del grupo Gremory · vampiro'),
  ('dxd-rossweisse', 'high-school-dxd-opi', 'Rossweisse',         'Torre del grupo Gremory · antigua valquiria'),
  ('dxd-irina',      'high-school-dxd-opi', 'Irina Shidou',       'Ángel y amiga de la infancia de Issei'),
  ('dxd-sona',       'high-school-dxd-opi', 'Sona Sitri',         'Rey del grupo Sitri · presidenta del consejo estudiantil'),
  ('dxd-tsubaki',    'high-school-dxd-opi', 'Tsubaki Shinra',     'Reina del grupo Sitri'),
  ('dxd-serafall',   'high-school-dxd-opi', 'Serafall Leviathan', 'Una de los cuatro Maous · hermana de Sona'),
  ('dxd-sirzechs',   'high-school-dxd-opi', 'Sirzechs Lucifer',   'Maou Lucifer · hermano de Rias'),
  ('dxd-grayfia',    'high-school-dxd-opi', 'Grayfia Lucifuge',   'Reina de Sirzechs · sirvienta del clan Gremory'),
  ('dxd-azazel',     'high-school-dxd-opi', 'Azazel',             'Gobernador de los Ángeles Caídos'),
  ('dxd-vali',       'high-school-dxd-opi', 'Vali Lucifer',       'Emperador Dragón Blanco · portador del Divine Dividing'),
  ('dxd-kuroka',     'high-school-dxd-opi', 'Kuroka',             'Nekomata · hermana mayor de Koneko'),
  ('dxd-ravel',      'high-school-dxd-opi', 'Ravel Phenex',       'Alfil del clan Phenex'),
  ('dxd-yubelluna',  'high-school-dxd-opi', 'Yubelluna',          'Reina del grupo de Riser Phenex'),
  ('dxd-sairaorg',   'high-school-dxd-opi', 'Sairaorg Bael',      'Rey del grupo Bael'),
  ('dxd-ophis',      'high-school-dxd-opi', 'Ophis',              'Dios Dragón del Infinito')
on conflict (id) do nothing;

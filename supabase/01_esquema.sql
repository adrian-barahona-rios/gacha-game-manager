-- Ejecutar en Supabase -> SQL Editor -> New query -> Run. Es el primero.
--
-- Toda la estructura de la base de datos: tablas, columnas, indices, permisos
-- (RLS), funciones y triggers. No lleva datos: esos van en los archivos 02 a 24.
--
-- Se puede volver a ejecutar sin romper nada: las tablas y columnas usan
-- "if not exists" y cada permiso se borra antes de crearlo otra vez.
--
-- Generado el 2026-09-15 juntando la estructura de los archivos .sql anteriores.

-- ===========================================================================
-- Perfiles de usuario
-- ===========================================================================

create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  username text not null,
  email text,
  created_at timestamptz not null default now()
);

-- Unicidad sin distinguir mayusculas: "Vara" y "vara" son el mismo nombre.
create unique index if not exists profiles_username_lower_idx
  on public.profiles (lower(username));

alter table public.profiles enable row level security;

-- Lectura abierta: hace falta para comprobar si un nombre esta libre antes de
-- registrarse, cuando todavia no hay sesion.
drop policy if exists "Los perfiles se pueden consultar" on public.profiles;
create policy "Los perfiles se pueden consultar"
  on public.profiles for select
  using (true);

drop policy if exists "Cada usuario edita su propio perfil" on public.profiles;
create policy "Cada usuario edita su propio perfil"
  on public.profiles for update
  using (auth.uid() = id)
  with check (auth.uid() = id);

-- Crea la fila del perfil en cuanto nace el usuario. Con la confirmacion por
-- email activada no hay sesion tras el registro, asi que el cliente no podria
-- insertarla: tiene que hacerlo el servidor.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.profiles (id, username, email)
  values (
    new.id,
    coalesce(
      nullif(new.raw_user_meta_data ->> 'username', ''),
      split_part(new.email, '@', 1)
    ),
    new.email
  );
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ===========================================================================
-- Biblioteca de juegos y amigos
-- ===========================================================================

create table if not exists public.user_games (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  game_id text not null,
  game_name text not null,
  added_date timestamptz not null default now(),
  unique (user_id, game_id)
);

create index if not exists user_games_user_id_idx on public.user_games (user_id);

alter table public.user_games enable row level security;

-- Sin estas policies, RLS bloquea todo y el dashboard sale vacio.
drop policy if exists "Los usuarios leen sus juegos" on public.user_games;
create policy "Los usuarios leen sus juegos"
  on public.user_games for select
  using (auth.uid() = user_id);

drop policy if exists "Los usuarios agregan sus juegos" on public.user_games;
create policy "Los usuarios agregan sus juegos"
  on public.user_games for insert
  with check (auth.uid() = user_id);

drop policy if exists "Los usuarios eliminan sus juegos" on public.user_games;
create policy "Los usuarios eliminan sus juegos"
  on public.user_games for delete
  using (auth.uid() = user_id);

create table if not exists public.friendships (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  friend_id uuid not null references public.profiles (id) on delete cascade,
  status text not null default 'pending' check (status in ('pending', 'accepted')),
  created_at timestamptz not null default now(),
  constraint friendships_no_self check (user_id <> friend_id)
);

-- Una sola relacion por pareja, sin importar quien invito a quien.
create unique index if not exists friendships_pair_idx on public.friendships (
  least(user_id::text, friend_id::text),
  greatest(user_id::text, friend_id::text)
);

create index if not exists friendships_user_id_idx on public.friendships (user_id);

create index if not exists friendships_friend_id_idx on public.friendships (friend_id);

alter table public.friendships enable row level security;

drop policy if exists "Ver mis relaciones" on public.friendships;
create policy "Ver mis relaciones"
  on public.friendships for select
  using (auth.uid() = user_id or auth.uid() = friend_id);

-- Solo puedes crear solicitudes en tu nombre, y siempre como pendientes.
drop policy if exists "Enviar solicitudes" on public.friendships;
create policy "Enviar solicitudes"
  on public.friendships for insert
  with check (auth.uid() = user_id and status = 'pending');

-- Solo quien recibe la solicitud puede aceptarla.
drop policy if exists "Aceptar solicitudes recibidas" on public.friendships;
create policy "Aceptar solicitudes recibidas"
  on public.friendships for update
  using (auth.uid() = friend_id)
  with check (auth.uid() = friend_id);

-- Cualquiera de los dos puede cancelar, rechazar o eliminar la amistad.
drop policy if exists "Eliminar relaciones propias" on public.friendships;
create policy "Eliminar relaciones propias"
  on public.friendships for delete
  using (auth.uid() = user_id or auth.uid() = friend_id);

drop policy if exists "Los amigos ven mis juegos" on public.user_games;

create policy "Los amigos ven mis juegos"
  on public.user_games for select
  using (
    exists (
      select 1
      from public.friendships f
      where f.status = 'accepted'
        and (
          (f.user_id = auth.uid() and f.friend_id = user_games.user_id)
          or (f.friend_id = auth.uid() and f.user_id = user_games.user_id)
        )
    )
  );

-- ===========================================================================
-- Personajes y favoritos
-- ===========================================================================

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
drop policy if exists "Los personajes se pueden consultar" on public.characters;
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

drop policy if exists "Cada usuario ve sus favoritos" on public.favorite_characters;
create policy "Cada usuario ve sus favoritos"
  on public.favorite_characters for select
  using (auth.uid() = user_id);

drop policy if exists "Cada usuario marca sus favoritos" on public.favorite_characters;
create policy "Cada usuario marca sus favoritos"
  on public.favorite_characters for insert
  with check (auth.uid() = user_id);

drop policy if exists "Cada usuario borra sus favoritos" on public.favorite_characters;
create policy "Cada usuario borra sus favoritos"
  on public.favorite_characters for delete
  using (auth.uid() = user_id);

alter table public.characters add column if not exists role text;

alter table public.characters add column if not exists path text;

alter table public.characters add column if not exists signature text;

alter table public.characters add column if not exists biography text;

-- Fuente de la biografia antigua (la columna biography). Existe en la base de
-- datos, pero ningun archivo la creaba.
alter table public.characters add column if not exists biography_source text;

alter table public.characters add column if not exists biography_en text;

alter table public.characters add column if not exists biography_source_en text;

alter table public.characters add column if not exists biography_es text;

alter table public.characters add column if not exists biography_source_es text;

alter table public.characters
  add column if not exists biography_es_translated boolean not null default false;

alter table public.characters
  add column if not exists is_upcoming boolean not null default false;

alter table public.characters add column if not exists ascension jsonb;

-- Perfil, habilidades y mejoras por duplicado (Cine mental en Zenless). De
-- momento solo los tienen los agentes de Zenless.
--   profile:    [{"campo", "valor"}]
--   skills:     {"categorias": [{"categoria", "icono", "tecnicas": [{"nombre", "descripcion"}],
--                "atributos": [{"clave", "valores"}]}], "materiales": [tramos como ascension]}
--   mindscapes: [{"nivel", "nombre", "icono", "efecto", "cita"}]
alter table public.characters add column if not exists profile jsonb;
alter table public.characters add column if not exists skills jsonb;
alter table public.characters add column if not exists mindscapes jsonb;

-- Linea de evolucion (Aniimo): {"arbol": {"nombre", "icono", "etapa",
-- "condiciones", "siguientes": [...]}, "formas": ["Basic Form", ...]}
alter table public.characters add column if not exists evolution jsonb;

-- Estadisticas base (Aniimo): {"total": 382, "valores": [{"campo": "PV",
-- "valor": 67}, ...]}
alter table public.characters add column if not exists stats jsonb;

-- Zonas en las que aparece (Aniimo): ["Campos Nubosos", ...]
alter table public.characters add column if not exists habitats jsonb;

-- ===========================================================================
-- Umamusume
-- ===========================================================================

create table if not exists public.umamusume_versions (
  id text primary key,
  name text not null,
  sort_order integer not null default 0
);

create table if not exists public.umamusume_characters (
  version text not null references public.umamusume_versions (id) on delete cascade,
  id text not null,
  name text not null,
  base_character text,
  icon_url text,
  rarity text,
  release_date date,
  primary key (version, id)
);

create index if not exists umamusume_characters_version_idx
  on public.umamusume_characters (version);

create table if not exists public.umamusume_support_cards (
  version text not null references public.umamusume_versions (id) on delete cascade,
  id text not null,
  name text not null,
  base_character text,
  icon_url text,
  rarity text,
  bonus text,
  rating numeric(2,1),
  primary key (version, id)
);

create index if not exists umamusume_support_cards_version_idx
  on public.umamusume_support_cards (version, bonus);

alter table public.umamusume_versions enable row level security;

alter table public.umamusume_characters enable row level security;

alter table public.umamusume_support_cards enable row level security;

drop policy if exists "Las versiones se pueden consultar" on public.umamusume_versions;
create policy "Las versiones se pueden consultar"
  on public.umamusume_versions for select using (true);

drop policy if exists "Las entrenadoras se pueden consultar" on public.umamusume_characters;
create policy "Las entrenadoras se pueden consultar"
  on public.umamusume_characters for select using (true);

drop policy if exists "Las cartas de apoyo se pueden consultar" on public.umamusume_support_cards;
create policy "Las cartas de apoyo se pueden consultar"
  on public.umamusume_support_cards for select using (true);

alter table public.umamusume_support_cards add column if not exists tier text;

create table if not exists public.favorite_umamusume_characters (
  user_id uuid not null references auth.users (id) on delete cascade,
  version text not null,
  character_id text not null,
  created_at timestamptz not null default now(),
  primary key (user_id, version, character_id),
  foreign key (version, character_id)
    references public.umamusume_characters (version, id) on delete cascade
);

create index if not exists favorite_umamusume_user_idx
  on public.favorite_umamusume_characters (user_id, version);

alter table public.favorite_umamusume_characters enable row level security;

drop policy if exists "Cada usuario ve sus entrenadoras favoritas"
  on public.favorite_umamusume_characters;

drop policy if exists "Cada usuario ve sus entrenadoras favoritas" on public.favorite_umamusume_characters;
create policy "Cada usuario ve sus entrenadoras favoritas"
  on public.favorite_umamusume_characters for select
  using (auth.uid() = user_id);

drop policy if exists "Cada usuario marca sus entrenadoras favoritas"
  on public.favorite_umamusume_characters;

drop policy if exists "Cada usuario marca sus entrenadoras favoritas" on public.favorite_umamusume_characters;
create policy "Cada usuario marca sus entrenadoras favoritas"
  on public.favorite_umamusume_characters for insert
  with check (auth.uid() = user_id);

drop policy if exists "Cada usuario borra sus entrenadoras favoritas"
  on public.favorite_umamusume_characters;

drop policy if exists "Cada usuario borra sus entrenadoras favoritas" on public.favorite_umamusume_characters;
create policy "Cada usuario borra sus entrenadoras favoritas"
  on public.favorite_umamusume_characters for delete
  using (auth.uid() = user_id);

-- ===========================================================================
-- Tier lists
-- ===========================================================================

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

drop policy if exists "Las tier lists oficiales se pueden consultar" on public.tier_lists_oficial;
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

drop policy if exists "Cada usuario ve su tier list" on public.tier_lists_personal;
create policy "Cada usuario ve su tier list"
  on public.tier_lists_personal for select
  using (auth.uid() = user_id);

drop policy if exists "Cada usuario crea su tier list" on public.tier_lists_personal;
create policy "Cada usuario crea su tier list"
  on public.tier_lists_personal for insert
  with check (auth.uid() = user_id);

drop policy if exists "Cada usuario actualiza su tier list" on public.tier_lists_personal;
create policy "Cada usuario actualiza su tier list"
  on public.tier_lists_personal for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Cada usuario borra de su tier list" on public.tier_lists_personal;
create policy "Cada usuario borra de su tier list"
  on public.tier_lists_personal for delete
  using (auth.uid() = user_id);

-- ===========================================================================
-- Administradores (rol admin y permisos de escritura)
-- ===========================================================================

alter table public.profiles add column if not exists role text not null default 'user';

do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'profiles_role_check'
  ) then
    alter table public.profiles
      add constraint profiles_role_check check (role in ('user', 'admin'));
  end if;
end;
$$;

-- Nadie salvo el servidor puede tocar la columna del rol.
revoke update (role) on public.profiles from anon, authenticated;

-- security definer: la funcion lee profiles saltandose la RLS, para que no se
-- vuelva recursiva al usarla dentro de las politicas.
create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.profiles p
    where p.id = auth.uid() and p.role = 'admin'
  );
$$;

-- ---------------------------------------------------------------------------
-- Personajes: alta y edicion solo para administradores.
-- ---------------------------------------------------------------------------
drop policy if exists "Los admins crean personajes" on public.characters;

create policy "Los admins crean personajes"
  on public.characters for insert
  with check (public.is_admin());

drop policy if exists "Los admins editan personajes" on public.characters;

create policy "Los admins editan personajes"
  on public.characters for update
  using (public.is_admin())
  with check (public.is_admin());

drop policy if exists "Los admins borran personajes" on public.characters;

create policy "Los admins borran personajes"
  on public.characters for delete
  using (public.is_admin());

-- ---------------------------------------------------------------------------
-- Tier lists oficiales: solo los administradores cambian las valoraciones.
-- ---------------------------------------------------------------------------
drop policy if exists "Los admins crean valoraciones" on public.tier_lists_oficial;

create policy "Los admins crean valoraciones"
  on public.tier_lists_oficial for insert
  with check (public.is_admin());

drop policy if exists "Los admins editan valoraciones" on public.tier_lists_oficial;

create policy "Los admins editan valoraciones"
  on public.tier_lists_oficial for update
  using (public.is_admin())
  with check (public.is_admin());

drop policy if exists "Los admins borran valoraciones" on public.tier_lists_oficial;

create policy "Los admins borran valoraciones"
  on public.tier_lists_oficial for delete
  using (public.is_admin());

-- ---------------------------------------------------------------------------
-- Umamusume: las entrenadoras viven en su propia tabla.
-- ---------------------------------------------------------------------------
drop policy if exists "Los admins crean entrenadoras" on public.umamusume_characters;

create policy "Los admins crean entrenadoras"
  on public.umamusume_characters for insert
  with check (public.is_admin());

drop policy if exists "Los admins editan entrenadoras" on public.umamusume_characters;

create policy "Los admins editan entrenadoras"
  on public.umamusume_characters for update
  using (public.is_admin())
  with check (public.is_admin());

-- ===========================================================================
-- Guias
-- ===========================================================================

create table if not exists public.character_meta_guides (
  game_id text not null,
  character_id text not null references public.characters (id) on delete cascade,
  -- Un mismo personaje puede tener build distinta segun el modo de juego.
  mode text not null default 'General',
  equipment_build text,
  stats text,
  variations text,
  source text,
  updated_at timestamptz not null default now(),
  primary key (character_id, mode)
);

create index if not exists character_meta_guides_game_idx
  on public.character_meta_guides (game_id);

alter table public.character_meta_guides enable row level security;

drop policy if exists "Las guias meta se pueden consultar" on public.character_meta_guides;

create policy "Las guias meta se pueden consultar"
  on public.character_meta_guides for select
  using (true);

drop policy if exists "Los admins crean guias meta" on public.character_meta_guides;

create policy "Los admins crean guias meta"
  on public.character_meta_guides for insert
  with check (public.is_admin());

drop policy if exists "Los admins editan guias meta" on public.character_meta_guides;

create policy "Los admins editan guias meta"
  on public.character_meta_guides for update
  using (public.is_admin())
  with check (public.is_admin());

drop policy if exists "Los admins borran guias meta" on public.character_meta_guides;

create policy "Los admins borran guias meta"
  on public.character_meta_guides for delete
  using (public.is_admin());

-- ---------------------------------------------------------------------------
-- Guias del usuario
-- ---------------------------------------------------------------------------
create table if not exists public.user_guides (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  game_id text not null,
  character_id text not null references public.characters (id) on delete cascade,
  title text not null,
  content text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists user_guides_user_idx
  on public.user_guides (user_id, updated_at desc);

create index if not exists user_guides_character_idx
  on public.user_guides (user_id, character_id);

alter table public.user_guides enable row level security;

-- Son privadas: cada uno solo ve y edita las suyas.
drop policy if exists "Cada usuario ve sus guias" on public.user_guides;

create policy "Cada usuario ve sus guias"
  on public.user_guides for select
  using (auth.uid() = user_id);

drop policy if exists "Cada usuario crea sus guias" on public.user_guides;

create policy "Cada usuario crea sus guias"
  on public.user_guides for insert
  with check (auth.uid() = user_id);

drop policy if exists "Cada usuario edita sus guias" on public.user_guides;

create policy "Cada usuario edita sus guias"
  on public.user_guides for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Cada usuario borra sus guias" on public.user_guides;

create policy "Cada usuario borra sus guias"
  on public.user_guides for delete
  using (auth.uid() = user_id);

-- Mantiene updated_at al dia sin depender del cliente.
create or replace function public.touch_user_guide()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists user_guides_touch on public.user_guides;

create trigger user_guides_touch
  before update on public.user_guides
  for each row execute function public.touch_user_guide();

-- ===========================================================================
-- Comentarios
-- ===========================================================================

create table if not exists public.comments (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  content text not null,
  -- Respuesta a otro comentario. La cascada solo salta cuando la fila padre
  -- llega a desaparecer de verdad, que es justo lo que evita delete_comment
  -- mientras haya respuestas colgando.
  parent_id uuid references public.comments (id) on delete cascade,
  -- Valoracion opcional de la aplicacion, solo en comentarios de primer nivel.
  rating smallint,
  likes_count integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  -- Borrado suave, al estilo de Reddit: cuando un comentario con respuestas se
  -- elimina, se vacia su texto pero la fila se queda para sostener el hilo.
  deleted_at timestamptz,
  constraint comments_content_not_empty check (
    length(content) <= 2000
    and (deleted_at is not null or length(btrim(content)) >= 1)
  ),
  constraint comments_rating_range check (rating is null or rating between 1 and 5),
  -- Una respuesta no valora la aplicacion: eso solo tiene sentido arriba.
  constraint comments_rating_only_on_root check (parent_id is null or rating is null),
  -- Un comentario no puede ser su propia respuesta.
  constraint comments_no_self_parent check (parent_id is null or parent_id <> id)
);

-- Por si la tabla se creo con una version anterior de este archivo, cuando el
-- borrado todavia era en cascada y no existia deleted_at.
alter table public.comments add column if not exists deleted_at timestamptz;

alter table public.comments drop constraint if exists comments_content_not_empty;

alter table public.comments add constraint comments_content_not_empty check (
  length(content) <= 2000
  and (deleted_at is not null or length(btrim(content)) >= 1)
);

create index if not exists comments_parent_idx on public.comments (parent_id, created_at);

create index if not exists comments_recent_idx on public.comments (created_at desc);

create index if not exists comments_user_idx on public.comments (user_id, created_at desc);

-- Un "me gusta" por persona y comentario: lo garantiza la clave primaria.
create table if not exists public.comment_likes (
  user_id uuid not null references public.profiles (id) on delete cascade,
  comment_id uuid not null references public.comments (id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (user_id, comment_id)
);

create index if not exists comment_likes_comment_idx on public.comment_likes (comment_id);

-- ---------------------------------------------------------------------------
-- Moderacion automatica en cuatro idiomas: espanol, ingles, frances y
-- portugues.
--
-- Copia de la lista de src/data/moderation.js. Si tocas una, toca la otra.
-- Solo entran terminos que son insulto u odio en cualquier contexto: palabras
-- con uso normal ademas del despectivo se quedan fuera a proposito, para no
-- rechazar comentarios inofensivos. Fuera estan, entre otras, "negro", "moro"
-- y "gitano" (es), "veado" y "bicha" (pt, que son "ciervo" y "cola"), "pedale"
-- y "tapette" (fr, que son "pedal" y "matamoscas") y "pede", que al quitarle
-- la tilde al "pédé" frances choca con el "ele pede" portugues.
-- ---------------------------------------------------------------------------

-- Minusculas, sin tildes, sin "l33t", sin adornos y sin letras estiradas.
-- Tiene que dar el mismo resultado que normalizeForModeration() en el cliente.
create or replace function public.moderation_normalize(input text)
returns text
language plpgsql
immutable
set search_path = ''
as $$
declare
  work text;
  previous text;
  guard integer := 0;
begin
  -- 1. Minusculas, sin tildes y deshaciendo las sustituciones l33t.
  work := translate(
    translate(
      lower(coalesce(input, '')),
      'áàäâãéèëêíìïîóòöôõúùüûñç',
      'aaaaaeeeeiiiiooooouuuunc'
    ),
    '013457@$',
    'oieastas'
  );

  -- 2. Cualquier separador (signos, emojis, saltos de linea) pasa a espacio.
  work := regexp_replace(work, '[^a-z0-9]+', ' ', 'g');

  -- 3. Letras sueltas seguidas se vuelven a juntar, para que "m a r i c o n"
  --    no cuele partido en siete palabras de una letra. Hace falta repetir
  --    porque cada pasada solo une un par: las coincidencias se solapan.
  loop
    previous := work;
    work := regexp_replace(work, '(^| )([a-z0-9]) ([a-z0-9])( |$)', '\1\2\3\4', 'g');
    guard := guard + 1;
    exit when work = previous or guard > 40;
  end loop;

  -- 4. Letras estiradas: solo se recortan las repeticiones de tres o mas,
  --    para no convertir "Niger" en la version con dos ges.
  work := regexp_replace(work, '(.)\1{2,}', '\1', 'g');

  return btrim(work);
end;
$$;

create or replace function public.moderation_blocked_term(input text)
returns text
language plpgsql
immutable
set search_path = ''
as $$
declare
  normalized text;
  term text;
  terms text[] := array[
    'maricon', 'maricona', 'maricones', 'marikon', 'mariconazo',
    'mariposon', 'julandron', 'bollera', 'bolleras', 'tortillera', 'sarasa',
    'trolo', 'travelo', 'sidoso', 'fag', 'fags', 'faggot', 'faggots',
    'faggy', 'tranny', 'trannies', 'shemale', 'dyke', 'dykes', 'gouine',
    'gouines', 'tarlouze', 'tantouze', 'sale pedale', 'grosse pedale',
    'sale tapette', 'sale pede', 'viado', 'viados', 'boiola', 'bichona',
    'traveco', 'traveca', 'sapatao', 'negrata', 'negratas', 'sudaca',
    'sudacas', 'panchito', 'panchitos', 'negro de mierda', 'moro de mierda',
    'judio de mierda', 'gitano de mierda', 'nigger', 'niggers', 'nigga',
    'niggas', 'chink', 'chinks', 'gook', 'spic', 'spics', 'wetback',
    'wetbacks', 'kike', 'kikes', 'beaner', 'beaners', 'coon', 'coons',
    'jigaboo', 'zipperhead', 'towelhead', 'raghead', 'sandnigger', 'pikey',
    'gyppo', 'bougnoule', 'bougnoules', 'bicot', 'youpin', 'youpins',
    'chintok', 'negresse', 'sale arabe', 'sale juif', 'sale noir',
    'sale negre', 'sale race', 'sale bougnoule', 'crioulo',
    'macaco de merda', 'preto de merda', 'preto imundo', 'judeu de merda',
    'volta pra senzala', 'moromierda', 'putos moros', 'putos negros',
    'putos gitanos', 'putos sudamericanos', 'putos inmigrantes',
    'puto inmigrante', 'fuera inmigrantes', 'volved a vuestro pais', 'paki',
    'pakis', 'go back to your country', 'go back to africa',
    'filthy immigrants', 'rentre dans ton pays', 'retourne dans ton pays',
    'dehors les etrangers', 'la france aux francais', 'volta pro teu pais',
    'volta para o teu pais', 'fora imigrantes', 'imigrantes de merda',
    'subnormal', 'subnormales', 'mongolico', 'mongolica',
    'retrasado mental', 'retard', 'retards', 'retarded', 'mongoloid',
    'attarde mental', 'sale mongol', 'retardado mental', 'mongoloide',
    'te voy a matar', 'os voy a matar', 'te voy a reventar',
    'te voy a rajar', 'te voy a quemar', 'ojala te mueras',
    'ojala te maten', 'muerete', 'matate', 'suicidate', 'cuelgate',
    'tirate por la ventana', 'kill yourself', 'kys', 'go kill yourself',
    'i will kill you', 'im going to kill you', 'i am going to kill you',
    'hang yourself', 'neck yourself', 'go die', 'you should die',
    'je vais te tuer', 'je vais te crever', 'va crever', 'creve toi',
    'tue toi', 'suicide toi', 'pends toi', 'jespere que tu vas mourir',
    'vou te matar', 'vou matar te', 'vai se matar', 'mata te', 'suicida te',
    'enforca te', 'morre logo', 'espero que morras', 'hitler tenia razon',
    'a la camara de gas', 'camara de gas para', 'muerte a los judios',
    'muerte a los moros', 'muerte a los negros', 'a colgarlos a todos',
    'heil hitler', 'sieg heil', 'hitler was right', 'gas the jews',
    'gas them all', 'white power', 'death to jews', 'death to muslims',
    'lynch them', 'mort aux juifs', 'mort aux arabes', 'mort aux noirs',
    'chambre a gaz pour', 'les juifs au four', 'la france aux blancs',
    'morte aos judeus', 'morte aos negros', 'hitler tinha razao',
    'camara de gas para eles', 'hijo de puta', 'hija de puta',
    'hijos de puta', 'hijas de puta', 'hijoputa', 'hijaputa', 'malnacido',
    'malparido', 'me cago en tus muertos', 'son of a bitch', 'motherfucker',
    'cunt', 'fils de pute', 'fille de pute', 'encule', 'enculee', 'encules',
    'nique ta mere', 'nique ta race', 'salopard', 'filho da puta',
    'filha da puta', 'filhos da puta', 'fdp', 'vai tomar no cu',
    'puta que te pariu'
  ];
begin
  -- Los espacios de los extremos hacen que solo cuenten palabras completas:
  -- "escasez" no debe saltar por contener "casa".
  normalized := ' ' || public.moderation_normalize(input) || ' ';

  foreach term in array terms loop
    if position(' ' || term || ' ' in normalized) > 0 then
      return term;
    end if;
  end loop;

  return null;
end;
$$;

-- ---------------------------------------------------------------------------
-- Disparadores de escritura
-- ---------------------------------------------------------------------------

-- Rechaza el comentario ofensivo y limita a 5 comentarios por minuto.
-- Los mensajes de error son codigos fijos: el cliente los traduce al idioma
-- que tenga elegido el usuario.
create or replace function public.comments_before_write()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  recent integer;
begin
  if public.moderation_blocked_term(new.content) is not null then
    raise exception 'comment_offensive';
  end if;

  if tg_op = 'INSERT' then
    -- Las marcas de tiempo y el contador los pone el servidor, pase lo que
    -- pase. Si el cliente pudiera elegir su created_at, le bastaria con
    -- fecharlo en el pasado para esquivar el limite de aqui abajo.
    new.created_at := now();
    new.updated_at := new.created_at;
    new.likes_count := 0;

    select count(*) into recent
    from public.comments c
    where c.user_id = new.user_id
      and c.created_at > now() - interval '1 minute';

    if recent >= 5 then
      raise exception 'comment_rate_limit';
    end if;
  end if;

  if tg_op = 'UPDATE' then
    new.updated_at := now();
  end if;

  return new;
end;
$$;

drop trigger if exists comments_before_write on public.comments;

create trigger comments_before_write
  before insert or update on public.comments
  for each row execute function public.comments_before_write();

-- El contador de "me gusta" lo lleva la base de datos, nunca el cliente.
create or replace function public.comment_likes_sync()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  if tg_op = 'INSERT' then
    update public.comments
    set likes_count = likes_count + 1
    where id = new.comment_id;
    return new;
  end if;

  update public.comments
  set likes_count = greatest(likes_count - 1, 0)
  where id = old.comment_id;
  return old;
end;
$$;

drop trigger if exists comment_likes_sync on public.comment_likes;

create trigger comment_likes_sync
  after insert or delete on public.comment_likes
  for each row execute function public.comment_likes_sync();

-- ---------------------------------------------------------------------------
-- Borrado suave
--
-- Un comentario con respuestas no puede desaparecer sin llevarse por delante
-- lo que han escrito otros, asi que se le vacia el texto y la fila se queda
-- sosteniendo el hilo. Uno sin respuestas si se borra del todo.
--
-- Va en una funcion en vez de en el cliente porque la decision depende de
-- cuantas respuestas hay en ese momento, y eso solo lo sabe el servidor.
-- ---------------------------------------------------------------------------
create or replace function public.delete_comment(target uuid)
returns jsonb
language plpgsql
security definer
set search_path = ''
as $$
declare
  owner uuid;
  parent uuid;
  cursor_id uuid;
  removed uuid[] := '{}';
  children integer;
  is_placeholder boolean;
begin
  select c.user_id, c.parent_id into owner, parent
  from public.comments c
  where c.id = target;

  if owner is null then
    raise exception 'comment_not_found';
  end if;

  -- La funcion se salta la RLS, asi que la propiedad se comprueba a mano.
  if owner is distinct from auth.uid() then
    raise exception 'comment_not_yours';
  end if;

  select count(*) into children
  from public.comments c
  where c.parent_id = target;

  if children > 0 then
    update public.comments
    set deleted_at = now(),
        content = '',
        rating = null
    where id = target;

    return jsonb_build_object('soft', true, 'removed', to_jsonb(removed));
  end if;

  delete from public.comments where id = target;
  removed := array[target];

  -- Poda hacia arriba: un padre que ya estaba vaciado y se queda sin ninguna
  -- respuesta deja de tener sentido, asi que desaparece tambien.
  cursor_id := parent;
  while cursor_id is not null loop
    select (c.deleted_at is not null), c.parent_id
      into is_placeholder, parent
    from public.comments c
    where c.id = cursor_id;

    exit when is_placeholder is null or not is_placeholder;

    select count(*) into children
    from public.comments c
    where c.parent_id = cursor_id;

    exit when children > 0;

    delete from public.comments where id = cursor_id;
    removed := removed || cursor_id;
    cursor_id := parent;
  end loop;

  return jsonb_build_object('soft', false, 'removed', to_jsonb(removed));
end;
$$;

revoke all on function public.delete_comment(uuid) from public, anon;

grant execute on function public.delete_comment(uuid) to authenticated;

-- ---------------------------------------------------------------------------
-- Permisos
-- ---------------------------------------------------------------------------
alter table public.comments enable row level security;

alter table public.comment_likes enable row level security;

-- Los comentarios son publicos: cualquiera que entre en la aplicacion los ve.
drop policy if exists "Los comentarios se pueden leer" on public.comments;

create policy "Los comentarios se pueden leer"
  on public.comments for select
  using (true);

-- Escribir, solo en tu propio nombre.
drop policy if exists "Cada usuario escribe sus comentarios" on public.comments;

create policy "Cada usuario escribe sus comentarios"
  on public.comments for insert
  with check (auth.uid() = user_id);

drop policy if exists "Cada usuario edita sus comentarios" on public.comments;

create policy "Cada usuario edita sus comentarios"
  on public.comments for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- Borrar directamente no se permite a nadie: se hace llamando a
-- delete_comment(), que decide si vaciar el comentario o quitarlo del todo.
-- Sin esta politica, un DELETE desde la API se queda sin filas que borrar y
-- las respuestas de otros no pueden caer en cascada por accidente.
drop policy if exists "Cada usuario borra sus comentarios" on public.comments;

-- El autor puede editar su comentario, pero no cambiar de quien es, ni de que
-- hilo cuelga, ni inflarse los "me gusta". Se le quita el permiso columna a
-- columna: los disparadores de arriba si pueden tocarlas.
revoke update (user_id, parent_id, likes_count, created_at, updated_at, deleted_at)
  on public.comments from anon, authenticated;

-- Y al crearlo tampoco puede fijar el contador ni las fechas: eso lo decide
-- el disparador de arriba.
revoke insert (likes_count, created_at, updated_at)
  on public.comments from anon, authenticated;

-- Quien ha dado "me gusta" es publico (hace falta para pintar el corazon).
drop policy if exists "Los me gusta se pueden leer" on public.comment_likes;

create policy "Los me gusta se pueden leer"
  on public.comment_likes for select
  using (true);

drop policy if exists "Cada usuario da su me gusta" on public.comment_likes;

create policy "Cada usuario da su me gusta"
  on public.comment_likes for insert
  with check (auth.uid() = user_id);

drop policy if exists "Cada usuario quita su me gusta" on public.comment_likes;

create policy "Cada usuario quita su me gusta"
  on public.comment_likes for delete
  using (auth.uid() = user_id);

-- ===========================================================================
-- Armas, conos de luz y amplificadores
-- ===========================================================================

create table if not exists public.weapons (
  id text primary key,
  game_id text not null,
  name text not null,
  name_en text,
  rarity text,
  -- Via en Honkai, tipo de arma en Genshin, especialidad en Zenless.
  category text,
  image_url text,
  description text,
  base_hp integer,
  base_atk integer,
  base_def integer,
  passive_name text,
  -- Los cinco niveles de superposicion o refinamiento, en orden.
  passive_levels jsonb,
  how_to_get text,
  -- Materiales de subida de limite de nivel, del 20 al 80. Cada tramo trae
  -- desde, hasta, creditos y los materiales con su icono y cantidad.
  ascension jsonb,
  -- Recomendacion, no dato del juego: se rellena a mano.
  good_for text,
  updated_at timestamptz not null default now()
);

-- ---------------------------------------------------------------------------
-- Por si la tabla ya existia de una version anterior de este archivo: el
-- "create table if not exists" de arriba no anade columnas a una tabla que ya
-- esta creada, asi que se anaden una a una. Si ya estan, no hace nada.
-- ---------------------------------------------------------------------------
alter table public.weapons add column if not exists name_en text;

alter table public.weapons add column if not exists rarity text;

alter table public.weapons add column if not exists category text;

alter table public.weapons add column if not exists image_url text;

alter table public.weapons add column if not exists description text;

alter table public.weapons add column if not exists base_hp integer;

alter table public.weapons add column if not exists base_atk integer;

alter table public.weapons add column if not exists base_def integer;

alter table public.weapons add column if not exists passive_name text;

alter table public.weapons add column if not exists passive_levels jsonb;

alter table public.weapons add column if not exists how_to_get text;

alter table public.weapons add column if not exists ascension jsonb;

alter table public.weapons add column if not exists good_for text;

alter table public.weapons
  add column if not exists updated_at timestamptz not null default now();

create index if not exists weapons_game_idx on public.weapons (game_id, category, name);

alter table public.weapons enable row level security;

drop policy if exists "Las armas se pueden consultar" on public.weapons;

create policy "Las armas se pueden consultar"
  on public.weapons for select
  using (true);

drop policy if exists "Los admins crean armas" on public.weapons;

create policy "Los admins crean armas"
  on public.weapons for insert
  with check (public.is_admin());

drop policy if exists "Los admins editan armas" on public.weapons;

create policy "Los admins editan armas"
  on public.weapons for update
  using (public.is_admin())
  with check (public.is_admin());

drop policy if exists "Los admins borran armas" on public.weapons;

create policy "Los admins borran armas"
  on public.weapons for delete
  using (public.is_admin());

alter table public.weapons add column if not exists sub_stat_name text;

alter table public.weapons add column if not exists sub_stat_value text;

alter table public.weapons add column if not exists recommended jsonb;

-- ===========================================================================
-- Pistas de disco de Zenless
-- ===========================================================================

create table if not exists public.drive_discs (
  id text primary key,
  game_id text not null,
  name text not null,
  name_en text,
  image_url text,
  -- Grados en los que sale el conjunto: "B,A,S" o solo "S".
  grades text,
  version text,
  two_piece text,
  four_piece text,
  -- Stats principales que pueden salir en cada ranura, de la 1 a la 6.
  main_stats jsonb,
  how_to_get text,
  updated_at timestamptz not null default now()
);

create index if not exists drive_discs_game_idx on public.drive_discs (game_id, name);

alter table public.drive_discs enable row level security;

drop policy if exists "Los discos se pueden consultar" on public.drive_discs;

create policy "Los discos se pueden consultar"
  on public.drive_discs for select
  using (true);

drop policy if exists "Los admins crean discos" on public.drive_discs;

create policy "Los admins crean discos"
  on public.drive_discs for insert
  with check (public.is_admin());

drop policy if exists "Los admins editan discos" on public.drive_discs;

create policy "Los admins editan discos"
  on public.drive_discs for update
  using (public.is_admin())
  with check (public.is_admin());

drop policy if exists "Los admins borran discos" on public.drive_discs;

create policy "Los admins borran discos"
  on public.drive_discs for delete
  using (public.is_admin());

-- ===========================================================================
-- Enemigos (Honkai: Star Rail, Genshin Impact y Zenless Zone Zero)
-- ===========================================================================

create table if not exists public.enemies (
  id text primary key,
  game_id text not null,
  name text not null,
  name_en text,
  -- 'jefe', 'esbirro' o 'fauna' (animales de Genshin): las pestanas del apartado.
  category text not null check (category in ('jefe', 'esbirro', 'fauna')),
  -- Rango dentro del juego: 'jefe', 'elite' o 'normal'.
  rank text not null check (rank in ('jefe', 'elite', 'normal')),
  faction text,
  description text,
  image_url text,
  -- Elementos debiles, por ejemplo ["Fuego", "Rayo"].
  weaknesses jsonb not null default '[]'::jsonb,
  -- Resistencias: [{"elemento": "Hielo", "valor": 20}] (valor en %).
  resistances jsonb not null default '[]'::jsonb,
  -- Otras combinaciones de debilidades y resistencias con las que aparece.
  variants jsonb,
  -- Habilidades: [{"nombre", "descripcion", "tipo", "elemento"}].
  skills jsonb not null default '[]'::jsonb,
  -- Botin: [{"nombre", "icono", "rareza"}].
  drops jsonb,
  updated_at timestamptz not null default now()
);

-- Para bases de datos creadas antes de anadir Genshin.
alter table public.enemies drop constraint if exists enemies_category_check;
alter table public.enemies add constraint enemies_category_check check (category in ('jefe', 'esbirro', 'fauna'));
alter table public.enemies add column if not exists drops jsonb;
-- Zenless: clasificacion (Maquinaria, Ser etereo...) y version de salida.
alter table public.enemies add column if not exists classification text;
alter table public.enemies add column if not exists version text;

create index if not exists enemies_game_idx on public.enemies (game_id, category, name);

alter table public.enemies enable row level security;

drop policy if exists "Los enemigos se pueden consultar" on public.enemies;

create policy "Los enemigos se pueden consultar"
  on public.enemies for select
  using (true);

drop policy if exists "Los admins crean enemigos" on public.enemies;

create policy "Los admins crean enemigos"
  on public.enemies for insert
  with check (public.is_admin());

drop policy if exists "Los admins editan enemigos" on public.enemies;

create policy "Los admins editan enemigos"
  on public.enemies for update
  using (public.is_admin())
  with check (public.is_admin());

drop policy if exists "Los admins borran enemigos" on public.enemies;

create policy "Los admins borran enemigos"
  on public.enemies for delete
  using (public.is_admin());

-- ===========================================================================
-- Reliquias y ornamentos (Honkai: Star Rail) y artefactos (Genshin Impact)
-- ===========================================================================

create table if not exists public.relic_sets (
  id text primary key,
  game_id text not null,
  name text not null,
  name_en text,
  -- 'reliquia' (4 piezas), 'ornamento' (ornamento planar, 2 piezas) o
  -- 'artefacto' (Genshin).
  type text not null check (type in ('reliquia', 'ornamento', 'artefacto')),
  -- Rareza, por ejemplo '4-5★'.
  rarity text,
  image_url text,
  -- Efecto de los conjuntos de una sola pieza.
  one_piece text,
  two_piece text,
  four_piece text,
  how_to_get text,
  -- Piezas del conjunto: [{"pieza", "nombre", "descripcion", "icono"}].
  pieces jsonb,
  version text,
  updated_at timestamptz not null default now()
);

-- Para bases de datos creadas antes de anadir Genshin.
alter table public.relic_sets drop constraint if exists relic_sets_type_check;
alter table public.relic_sets add constraint relic_sets_type_check check (type in ('reliquia', 'ornamento', 'artefacto'));
alter table public.relic_sets add column if not exists rarity text;
alter table public.relic_sets add column if not exists one_piece text;
alter table public.relic_sets add column if not exists pieces jsonb;

create index if not exists relic_sets_game_idx on public.relic_sets (game_id, type, name);

alter table public.relic_sets enable row level security;

drop policy if exists "Las reliquias se pueden consultar" on public.relic_sets;

create policy "Las reliquias se pueden consultar"
  on public.relic_sets for select
  using (true);

drop policy if exists "Los admins crean reliquias" on public.relic_sets;

create policy "Los admins crean reliquias"
  on public.relic_sets for insert
  with check (public.is_admin());

drop policy if exists "Los admins editan reliquias" on public.relic_sets;

create policy "Los admins editan reliquias"
  on public.relic_sets for update
  using (public.is_admin())
  with check (public.is_admin());

drop policy if exists "Los admins borran reliquias" on public.relic_sets;

create policy "Los admins borran reliquias"
  on public.relic_sets for delete
  using (public.is_admin());

-- ===========================================================================
-- Builds estructuradas en las guias meta
-- ===========================================================================

-- La build con ids (conos, reliquias, ornamentos, stats por pieza) para
-- pintarla con iconos. Los campos de texto se quedan como respaldo y para el
-- editor de /admin.
alter table public.character_meta_guides add column if not exists build jsonb;

-- ===========================================================================
-- Rotaciones del endgame (Honkai: Star Rail y Genshin Impact)
-- ===========================================================================

create table if not exists public.endgame_rotations (
  id text primary key,
  game_id text not null,
  -- El mismo id de modo que usa la app (src/data/gameModes.js).
  mode text not null,
  name text not null,
  -- 'actual', 'proxima', 'reciente' (sin fechas en los datos) o 'pasada'.
  status text not null default 'actual',
  begins_on date,
  ends_on date,
  -- Efectos: [{"nombre", "descripcion", "tipo": "general" | "elegible"}].
  effects jsonb not null default '[]'::jsonb,
  -- Pisos: [{"piso", "nombre", "mitades": [{"elementos", "oleadas": [[ids de enemies]]}]}].
  floors jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);

-- Datos propios de cada modo: elementos permitidos, personajes iniciales e
-- invitados del Teatro Fantasia, equipos recomendados...
-- {"elementos": [...], "grupos": [{"nombre", "personajes": [ids]}], "equipos": [{"nombre", "personajes": [ids]}]}
alter table public.endgame_rotations add column if not exists extra jsonb;

create index if not exists endgame_rotations_game_mode_idx on public.endgame_rotations (game_id, mode, status);

alter table public.endgame_rotations enable row level security;

drop policy if exists "Las rotaciones se pueden consultar" on public.endgame_rotations;

create policy "Las rotaciones se pueden consultar"
  on public.endgame_rotations for select
  using (true);

drop policy if exists "Los admins crean rotaciones" on public.endgame_rotations;

create policy "Los admins crean rotaciones"
  on public.endgame_rotations for insert
  with check (public.is_admin());

drop policy if exists "Los admins editan rotaciones" on public.endgame_rotations;

create policy "Los admins editan rotaciones"
  on public.endgame_rotations for update
  using (public.is_admin())
  with check (public.is_admin());

drop policy if exists "Los admins borran rotaciones" on public.endgame_rotations;

create policy "Los admins borran rotaciones"
  on public.endgame_rotations for delete
  using (public.is_admin());

-- ===========================================================================
-- Bangbus (Zenless Zone Zero)
-- ===========================================================================

create table if not exists public.bangboos (
  id text primary key,
  game_id text not null,
  name text not null,
  name_en text,
  -- Grado: 'S' o 'A'.
  rarity text,
  faction text,
  faction_icon text,
  version text,
  -- Icono pequeno y la ilustracion grande.
  icon_url text,
  image_url text,
  -- Stats de cada limite de nivel: [{"nivel": "60/60", "stats": [{"nombre", "valor"}]}].
  levels jsonb not null default '[]'::jsonb,
  -- Materiales por subida de limite, con la misma forma que characters.ascension.
  ascension jsonb,
  -- Habilidades: [{"nombre", "tipo", "descripcion", "icono", "atributos": [{"clave", "valores"}]}].
  skills jsonb not null default '[]'::jsonb,
  -- Informacion adicional de la wiki: [{"titulo", "texto"}].
  extra_info jsonb,
  updated_at timestamptz not null default now()
);

create index if not exists bangboos_game_idx on public.bangboos (game_id, rarity, name);

alter table public.bangboos enable row level security;

drop policy if exists "Los bangbus se pueden consultar" on public.bangboos;

create policy "Los bangbus se pueden consultar"
  on public.bangboos for select
  using (true);

drop policy if exists "Los admins crean bangbus" on public.bangboos;

create policy "Los admins crean bangbus"
  on public.bangboos for insert
  with check (public.is_admin());

drop policy if exists "Los admins editan bangbus" on public.bangboos;

create policy "Los admins editan bangbus"
  on public.bangboos for update
  using (public.is_admin())
  with check (public.is_admin());

drop policy if exists "Los admins borran bangbus" on public.bangboos;

create policy "Los admins borran bangbus"
  on public.bangboos for delete
  using (public.is_admin());

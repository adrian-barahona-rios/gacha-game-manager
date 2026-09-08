-- Ejecutar en Supabase -> SQL Editor -> New query -> Run.
-- Requiere characters.sql y admin.sql (la funcion is_admin).
--
-- Dos tablas para el sistema de guias:
--   character_meta_guides -> la build recomendada, comun a todos. Solo la
--     editan los administradores desde /admin.
--   user_guides -> las guias que escribe cada usuario, privadas.

-- ---------------------------------------------------------------------------
-- Guias meta
-- ---------------------------------------------------------------------------
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

-- Comprobacion: debe listar las dos tablas.
select table_name
from information_schema.tables
where table_schema = 'public'
  and table_name in ('character_meta_guides', 'user_guides')
order by table_name;

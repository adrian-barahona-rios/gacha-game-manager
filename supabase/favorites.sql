-- Ejecutar en Supabase -> SQL Editor -> New query -> Run.
-- Requiere characters.sql y umamusume.sql.
--
-- Los favoritos de los cuatro juegos con ficha de personaje ya viven en
-- favorite_characters (creada en characters.sql). Las entrenadoras de
-- Umamusume estan en otra tabla y su clave es doble (version + id), asi que
-- necesitan su propia tabla de favoritos.

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
create policy "Cada usuario ve sus entrenadoras favoritas"
  on public.favorite_umamusume_characters for select
  using (auth.uid() = user_id);

drop policy if exists "Cada usuario marca sus entrenadoras favoritas"
  on public.favorite_umamusume_characters;
create policy "Cada usuario marca sus entrenadoras favoritas"
  on public.favorite_umamusume_characters for insert
  with check (auth.uid() = user_id);

drop policy if exists "Cada usuario borra sus entrenadoras favoritas"
  on public.favorite_umamusume_characters;
create policy "Cada usuario borra sus entrenadoras favoritas"
  on public.favorite_umamusume_characters for delete
  using (auth.uid() = user_id);

-- Comprobacion: debe devolver las dos tablas de favoritos.
select table_name
from information_schema.tables
where table_schema = 'public' and table_name like 'favorite%'
order by table_name;

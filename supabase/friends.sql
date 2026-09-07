-- Ejecutar en Supabase → SQL Editor → New query → Run.
-- Requiere haber ejecutado antes profiles.sql.
--
-- Una sola tabla en lugar de friendships + friend_requests: una solicitud es
-- simplemente una fila con status 'pending'. Con dos tablas el mismo hecho
-- viviria duplicado y bastaria un fallo a medias para dejarlas descuadradas.
--
--   user_id   = quien envia la solicitud
--   friend_id = quien la recibe
--
-- Las claves apuntan a profiles (que a su vez cuelga de auth.users) para poder
-- traer el nombre de usuario en la misma consulta.

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

create policy "Ver mis relaciones"
  on public.friendships for select
  using (auth.uid() = user_id or auth.uid() = friend_id);

-- Solo puedes crear solicitudes en tu nombre, y siempre como pendientes.
create policy "Enviar solicitudes"
  on public.friendships for insert
  with check (auth.uid() = user_id and status = 'pending');

-- Solo quien recibe la solicitud puede aceptarla.
create policy "Aceptar solicitudes recibidas"
  on public.friendships for update
  using (auth.uid() = friend_id)
  with check (auth.uid() = friend_id);

-- Cualquiera de los dos puede cancelar, rechazar o eliminar la amistad.
create policy "Eliminar relaciones propias"
  on public.friendships for delete
  using (auth.uid() = user_id or auth.uid() = friend_id);

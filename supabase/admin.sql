-- Ejecutar en Supabase -> SQL Editor -> New query -> Run.
-- Requiere profiles.sql, characters.sql, tier_lists.sql y umamusume.sql.
--
-- Anade el rol de administrador y los permisos de escritura del panel /admin.
--
-- El rol vive en profiles.role, pero se revoca el permiso de UPDATE sobre esa
-- columna a los usuarios normales: aunque cada uno puede editar su perfil, la
-- base de datos rechaza cualquier intento de darse el rol a si mismo. Solo se
-- puede cambiar desde el panel de Supabase (que usa service_role).

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

-- ---------------------------------------------------------------------------
-- Darte el rol a ti mismo. Cambia el email por el tuyo y ejecuta esta linea.
-- ---------------------------------------------------------------------------
-- update public.profiles set role = 'admin'
-- where id = (select id from auth.users where email = 'tucorreo@ejemplo.com');

-- Comprobacion: debe listar tu cuenta.
select p.id, p.username, p.email, p.role
from public.profiles p
where p.role = 'admin';

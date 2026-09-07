-- Ejecutar en Supabase → SQL Editor → New query → Run.
--
-- auth.users es una tabla gestionada por Supabase y no se debe modificar, asi
-- que el username vive en esta tabla propia, enlazada por id. Es ademas la
-- unica forma de garantizar que el nombre sea unico: una restriccion de base
-- de datos, no una comprobacion desde el cliente.

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
create policy "Los perfiles se pueden consultar"
  on public.profiles for select
  using (true);

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

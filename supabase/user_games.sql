-- Ejecutar en Supabase → SQL Editor → New query → Run.

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
create policy "Los usuarios leen sus juegos"
  on public.user_games for select
  using (auth.uid() = user_id);

create policy "Los usuarios agregan sus juegos"
  on public.user_games for insert
  with check (auth.uid() = user_id);

create policy "Los usuarios eliminan sus juegos"
  on public.user_games for delete
  using (auth.uid() = user_id);

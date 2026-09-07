-- Ejecutar en Supabase → SQL Editor → New query → Run.
-- Requiere user_games.sql y friends.sql ya ejecutados.
--
-- Se anade una policy nueva en vez de tocar la existente: varias policies
-- permisivas de SELECT se combinan con OR, asi que "leo lo mio" sigue igual y
-- esto solo suma "leo lo de mis amigos".

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

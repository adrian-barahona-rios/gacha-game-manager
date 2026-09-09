-- Ejecutar en Supabase -> SQL Editor -> New query -> Run.
-- Requiere que profiles.sql y admin.sql ya esten ejecutados.
--
-- Cuenta de Bara: se registro antes de que existiera el trigger
-- on_auth_user_created, asi que la cuenta esta en auth.users pero se quedo sin
-- fila en public.profiles. La aplicacion la deja entrar (la sesion sale de
-- auth.users) y muestra el nombre desde user_metadata, pero al no encontrar
-- perfil no puede leer el rol y oculta el panel de administracion.
--
-- La solucion es crear esa fila a mano. El id es el mismo que la aplicacion
-- muestra en el perfil como "Tu ID de cuenta".
--
-- Por que el rol se pone desde aqui y no desde la aplicacion: admin.sql revoca
-- a proposito el UPDATE sobre profiles.role a los usuarios normales, para que
-- nadie pueda ascenderse a si mismo. Este editor usa service_role y se la
-- salta. Las cuentas nuevas siguen naciendo con role = 'user' por defecto.

-- ---------------------------------------------------------------------------
-- 1. Antes: mira que cuentas hay y cuales se quedaron sin perfil.
--    La fila de Bara debe salir con username y role vacios.
-- ---------------------------------------------------------------------------
select u.id, u.email, u.created_at, p.username, p.role
from auth.users u
left join public.profiles p on p.id = u.id
order by u.created_at;

-- ---------------------------------------------------------------------------
-- 2. Crea el perfil que falta y dale el rol de administrador.
--    El correo se copia de auth.users, no hace falta escribirlo.
-- ---------------------------------------------------------------------------
insert into public.profiles (id, username, email, role)
select u.id, 'Bara', u.email, 'admin'
from auth.users u
where u.id = '060ad2f8-89dc-40aa-8c63-bb16c1e6cebf'
on conflict (id) do update
  set username = excluded.username,
      role = excluded.role;

-- ---------------------------------------------------------------------------
-- 3. Cualquier otra cuenta se queda como usuario normal.
--    Ahora mismo solo afectaria a alvnev7, que ya es 'user'.
-- ---------------------------------------------------------------------------
update public.profiles
set role = 'user'
where role = 'admin'
  and id <> '060ad2f8-89dc-40aa-8c63-bb16c1e6cebf';

-- ---------------------------------------------------------------------------
-- 4. Comprobacion: una sola fila, Bara.
-- ---------------------------------------------------------------------------
select username, email, role
from public.profiles
where role = 'admin';

-- Despues, recarga la aplicacion (o cierra sesion y vuelve a entrar) para que
-- lea el rol otra vez. Apareceran el boton verde "Panel de administracion" en
-- tu perfil y el acceso a /admin.

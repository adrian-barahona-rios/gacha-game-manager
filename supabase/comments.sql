-- Ejecutar en Supabase -> SQL Editor -> New query -> Run.
-- Requiere profiles.sql.
--
-- Sistema de comentarios con hilos, "me gusta", moderacion automatica y
-- limite de publicaciones por minuto.
--
-- Todo lo que protege el contenido vive aqui, no en el navegador: la
-- comprobacion del cliente solo esta para dar un aviso rapido y bonito, pero
-- la que manda es esta. Cualquiera puede llamar a la API de Supabase con la
-- clave publica saltandose la aplicacion, asi que los filtros tienen que
-- existir tambien en la base de datos.

-- ---------------------------------------------------------------------------
-- Tablas
-- ---------------------------------------------------------------------------

-- user_id apunta a profiles (no a auth.users) para que PostgREST pueda traer
-- el nombre del autor en la misma consulta que los comentarios.
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

-- ---------------------------------------------------------------------------
-- Comprobaciones
-- ---------------------------------------------------------------------------

-- Texto normal en los cuatro idiomas: las cuatro columnas deben salir null.
select
  public.moderation_blocked_term('El personaje negro tiene buen kit') as limpio_es,
  public.moderation_blocked_term('The tier list is really useful') as limpio_en,
  public.moderation_blocked_term('Jai casse la pedale de mon velo') as limpio_fr,
  public.moderation_blocked_term('Ele pede ajuda, o veado e o macaco sao chefes') as limpio_pt;

-- Y ahora lo que si tiene que saltar. Deben salir, en orden:
--   'maricon', 'maricon', 'faggot', 'bougnoule', 'fils de pute', 'viado',
--   'morte aos judeus'.
select
  public.moderation_blocked_term('eres un MARICÓN') as es_1,
  public.moderation_blocked_term('mar1c0n de mierda') as es_2,
  public.moderation_blocked_term('kill yourself you f4gg0t') as en_1,
  public.moderation_blocked_term('sale bougnoule je vais te tuer') as fr_1,
  public.moderation_blocked_term('nique ta mere fils de pute') as fr_2,
  public.moderation_blocked_term('seu viado filho da puta') as pt_1,
  public.moderation_blocked_term('morte aos judeus') as pt_2;

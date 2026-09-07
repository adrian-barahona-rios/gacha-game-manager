import { supabase } from '../config/supabase'

const UUID_REGEX =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i

const RELATION_SELECT = `
  id,
  status,
  user_id,
  friend_id,
  created_at,
  requester:profiles!friendships_user_id_fkey (id, username),
  addressee:profiles!friendships_friend_id_fkey (id, username)
`

// Devuelve las relaciones ya repartidas segun el papel del usuario actual, que
// es como las consumen todas las pantallas.
export async function loadFriendships(userId) {
  const { data, error } = await supabase
    .from('friendships')
    .select(RELATION_SELECT)
    .or(`user_id.eq.${userId},friend_id.eq.${userId}`)
    .order('created_at', { ascending: false })

  if (error) {
    return { error, friends: [], incoming: [], outgoing: [] }
  }

  const friends = []
  const incoming = []
  const outgoing = []

  for (const row of data) {
    const isRequester = row.user_id === userId
    const other = isRequester ? row.addressee : row.requester
    const entry = {
      id: row.id,
      status: row.status,
      createdAt: row.created_at,
      profile: other ?? { id: isRequester ? row.friend_id : row.user_id },
    }

    if (row.status === 'accepted') {
      friends.push(entry)
    } else if (isRequester) {
      outgoing.push(entry)
    } else {
      incoming.push(entry)
    }
  }

  return { error: null, friends, incoming, outgoing }
}

// Acepta tanto el identificador de cuenta como el nombre de usuario, porque
// teclear un UUID a mano es incomodo.
export async function findProfile(term) {
  const trimmed = term.trim()

  if (!trimmed) {
    return { profile: null, error: null }
  }

  const query = supabase.from('profiles').select('id, username')
  const { data, error } = UUID_REGEX.test(trimmed)
    ? await query.eq('id', trimmed).maybeSingle()
    : await query.ilike('username', trimmed).maybeSingle()

  return { profile: data ?? null, error }
}

export async function sendFriendRequest(userId, friendId) {
  return supabase
    .from('friendships')
    .insert({ user_id: userId, friend_id: friendId, status: 'pending' })
}

export async function acceptFriendRequest(relationId) {
  return supabase
    .from('friendships')
    .update({ status: 'accepted' })
    .eq('id', relationId)
}

export async function removeFriendship(relationId) {
  return supabase.from('friendships').delete().eq('id', relationId)
}

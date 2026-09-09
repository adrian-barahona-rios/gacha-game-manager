import { useEffect, useState } from 'react'
import { supabase } from '../config/supabase'

const EMPTY = new Set()

// Favoritos del usuario para un listado concreto.
//
// `table` es favorite_characters o favorite_umamusume_characters. En opciones:
//   row        -> columnas que forman parte de la fila y acotan la consulta
//                 (la version, en Umamusume).
//   gameFilter -> id del juego. favorite_characters no guarda el juego, asi
//                 que se filtra por el del personaje enlazado. Sin esto, la
//                 lista traeria los favoritos de todos los juegos y el
//                 contador de la pestana los sumaria todos.
//
// Los datos guardan a que consulta pertenecen, de modo que al cambiar de juego
// o de version no se muestran por error los del listado anterior.
export function useFavorites(table, options) {
  const { row, gameFilter } = options ?? {}
  const [userId, setUserId] = useState(null)
  const [loaded, setLoaded] = useState(null)
  const [pendingId, setPendingId] = useState('')
  const [error, setError] = useState('')

  const rowKey = JSON.stringify(row ?? {})
  const key = `${table}|${rowKey}|${gameFilter ?? ''}|${userId ?? ''}`

  useEffect(() => {
    let active = true

    supabase.auth.getSession().then(({ data }) => {
      if (active) {
        setUserId(data.session?.user.id ?? null)
      }
    })

    return () => {
      active = false
    }
  }, [])

  useEffect(() => {
    if (!userId) {
      return undefined
    }

    let active = true

    let query = supabase
      .from(table)
      .select(gameFilter ? 'character_id, characters!inner(game_id)' : 'character_id')
      .match({ user_id: userId, ...JSON.parse(rowKey) })

    if (gameFilter) {
      query = query.eq('characters.game_id', gameFilter)
    }

    query.then(({ data, error: loadError }) => {
      if (!active) {
        return
      }
      if (loadError) {
        setError(loadError.message)
      } else {
        setLoaded({ key, ids: new Set(data.map((item) => item.character_id)) })
        setError('')
      }
    })

    return () => {
      active = false
    }
  }, [table, rowKey, gameFilter, userId, key])

  const favoriteIds = loaded?.key === key ? loaded.ids : EMPTY
  // Sin sesion no hay nada que esperar: la lista de favoritos esta vacia.
  const isLoading = Boolean(userId) && loaded?.key !== key

  const toggle = async (characterId) => {
    if (!userId || pendingId) {
      return
    }

    setPendingId(characterId)
    setError('')

    // gameFilter no es una columna de la tabla: solo acota la lectura.
    const target = { user_id: userId, character_id: characterId, ...JSON.parse(rowKey) }
    const { error: writeError } = favoriteIds.has(characterId)
      ? await supabase.from(table).delete().match(target)
      : await supabase.from(table).insert(target)

    setPendingId('')

    if (writeError) {
      setError(writeError.message)
      return
    }

    setLoaded((current) => {
      const ids = new Set(current?.key === key ? current.ids : [])
      if (ids.has(characterId)) {
        ids.delete(characterId)
      } else {
        ids.add(characterId)
      }
      return { key, ids }
    })
  }

  return { userId, favoriteIds, isLoading, pendingId, error, toggle }
}

import { useEffect, useState } from 'react'
import { supabase } from '../config/supabase'

const EMPTY = new Set()

// Favoritos del usuario para un listado concreto.
//
// `table` es favorite_characters o favorite_umamusume_characters, y `scope`
// son las columnas que acotan la consulta (la version, en Umamusume). Los
// datos guardan a que consulta pertenecen, de modo que al cambiar de juego o
// de version no se muestran por error los favoritos del listado anterior.
export function useFavorites(table, scope) {
  const [userId, setUserId] = useState(null)
  const [loaded, setLoaded] = useState(null)
  const [pendingId, setPendingId] = useState('')
  const [error, setError] = useState('')

  const scopeKey = JSON.stringify(scope ?? {})
  const key = `${table}|${scopeKey}|${userId ?? ''}`

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

    supabase
      .from(table)
      .select('character_id')
      .match({ user_id: userId, ...JSON.parse(scopeKey) })
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(loadError.message)
        } else {
          setLoaded({ key, ids: new Set(data.map((row) => row.character_id)) })
          setError('')
        }
      })

    return () => {
      active = false
    }
  }, [table, scopeKey, userId, key])

  const favoriteIds = loaded?.key === key ? loaded.ids : EMPTY
  // Sin sesion no hay nada que esperar: la lista de favoritos esta vacia.
  const isLoading = Boolean(userId) && loaded?.key !== key

  const toggle = async (characterId) => {
    if (!userId || pendingId) {
      return
    }

    setPendingId(characterId)
    setError('')

    const row = { user_id: userId, character_id: characterId, ...JSON.parse(scopeKey) }
    const { error: writeError } = favoriteIds.has(characterId)
      ? await supabase.from(table).delete().match(row)
      : await supabase.from(table).insert(row)

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

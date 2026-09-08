import { useEffect, useState } from 'react'
import { supabase } from '../config/supabase'

export function useSupportCards(version) {
  const [cards, setCards] = useState([])
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')

  useEffect(() => {
    let active = true

    supabase
      .from('umamusume_support_cards')
      .select('id, name, base_character, icon_url, rarity, bonus, tier')
      .eq('version', version)
      .order('name', { ascending: true })
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(`No se pudieron cargar las cartas: ${loadError.message}`)
        } else {
          setCards(data)
        }
        setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [version])

  return { cards, isLoading, error }
}

import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { Loader2 } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getElementStyle } from '../data/characterStyles'

// Orden en el que se pintan los bloques. "lista" es cuando la guia no
// distingue entre mejores y demas.
const GRUPOS = ['exclusivo', 'ideal', 'destacado', 'lista', 'otros']

function Retrato({ character }) {
  const { tile } = getElementStyle(character.element)
  return (
    <span className={`flex h-16 w-16 items-center justify-center overflow-hidden rounded-2xl bg-gradient-to-br ${tile}`}>
      {character.image_url ? (
        <img
          src={character.image_url}
          alt=""
          loading="lazy"
          className="h-full w-full object-contain"
        />
      ) : (
        <span className="text-2xl font-bold text-white/85">{character.name.charAt(0)}</span>
      )}
    </span>
  )
}

// Personajes recomendados de un arma, con su icono y enlace a su ficha.
// recommended: [{ id, grupo }]. Si no hay ninguno que pintar (por ejemplo, si
// aun no existen en la tabla), se muestra el texto de respaldo.
function RecommendedCharacters({ recommended, fallbackText, gameId }) {
  const navigate = useNavigate()
  const { t } = useI18n()
  const [personajes, setPersonajes] = useState({})
  const [isLoading, setIsLoading] = useState(true)

  const ids = recommended.map((r) => r.id)
  const clave = ids.join(',')

  useEffect(() => {
    let active = true
    supabase
      .from('characters')
      .select('id, name, image_url, element')
      .in('id', clave.split(','))
      .then(({ data }) => {
        if (!active) return
        setPersonajes(Object.fromEntries((data ?? []).map((c) => [c.id, c])))
        setIsLoading(false)
      })
    return () => {
      active = false
    }
  }, [clave])

  if (isLoading) {
    return (
      <div className="flex items-center gap-2 text-sm text-zinc-500">
        <Loader2 className="h-4 w-4 animate-spin" />
        {t('common.loading')}
      </div>
    )
  }

  const bloques = GRUPOS.map((grupo) => ({
    grupo,
    lista: recommended.filter((r) => r.grupo === grupo && personajes[r.id]).map((r) => personajes[r.id]),
  })).filter((b) => b.lista.length > 0)

  if (bloques.length === 0) {
    return fallbackText ? (
      <p className="whitespace-pre-wrap text-[15px] leading-relaxed text-zinc-300">{fallbackText}</p>
    ) : (
      <p className="text-sm text-zinc-500">{t('weapons.goodForEmpty')}</p>
    )
  }

  return (
    <div className="space-y-5">
      {bloques.map(({ grupo, lista }) => {
        const destacado = grupo !== 'otros' && grupo !== 'lista'
        return (
          <div key={grupo}>
            <h3 className="mb-3 text-xs font-semibold uppercase tracking-wider text-zinc-400">
              {t(`weapons.reco.${grupo}`)}
            </h3>
            <ul className="grid grid-cols-[repeat(auto-fill,minmax(5.5rem,1fr))] gap-3">
              {lista.map((character) => (
                <li key={character.id}>
                  <button
                    type="button"
                    onClick={() => navigate(`/game/${gameId}/characters/${character.id}`)}
                    className={`flex h-full w-full flex-col items-center gap-2 rounded-2xl border p-2.5 text-center transition-all duration-300 hover:-translate-y-0.5 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95 ${
                      destacado ? 'border-amber-400/40 bg-amber-500/10' : 'border-white/10 bg-white/5'
                    }`}
                  >
                    <Retrato character={character} />
                    <span className="line-clamp-2 text-xs leading-tight text-zinc-200">{character.name}</span>
                  </button>
                </li>
              ))}
            </ul>
          </div>
        )
      })}
      <p className="text-xs text-zinc-500">{t('weapons.reco.source')}</p>
    </div>
  )
}

export default RecommendedCharacters

import { useEffect, useState } from 'react'
import { useParams } from 'react-router-dom'
import { AlertCircle, Search, Users } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import UmamusumeLayout from './UmamusumeLayout'

function UmamusumeCharacters() {
  const { t } = useI18n()
  const { version } = useParams()
  const [characters, setCharacters] = useState([])
  const [term, setTerm] = useState('')
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')

  useEffect(() => {
    let active = true

    supabase
      .from('umamusume_characters')
      .select('id, name, base_character, icon_url, rarity, release_date')
      .eq('version', version)
      .order('name', { ascending: true })
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(`No se pudieron cargar las entrenadoras: ${loadError.message}`)
        } else {
          setCharacters(data)
        }
        setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [version])

  const needle = term.trim().toLowerCase()
  const visible = needle
    ? characters.filter(
        (c) =>
          c.name.toLowerCase().includes(needle) ||
          (c.base_character ?? '').toLowerCase().includes(needle),
      )
    : characters

  return (
    <UmamusumeLayout
      title="Personajes"
      subtitle={isLoading ? '' : `${characters.length} entrenadoras`}
      current="characters"
    >
      {error && (
        <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
          <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
          <p>{error}</p>
        </div>
      )}

      <div className="relative mb-8 max-w-md">
        <input
          value={term}
          onChange={(event) => setTerm(event.target.value)}
          placeholder={t('uma.searchTrainees')}
          className="peer w-full rounded-xl border border-white/10 bg-white/[0.03] py-3 pl-11 pr-4 text-[15px] text-white placeholder:text-zinc-600 transition-all duration-300 hover:border-white/20 focus:border-amber-500/50 focus:bg-white/[0.06] focus:outline-none focus:ring-4 focus:ring-amber-500/10"
        />
        <Search className="pointer-events-none absolute left-3.5 top-1/2 h-[18px] w-[18px] -translate-y-1/2 text-zinc-500 transition-colors duration-300 peer-focus:text-amber-200" />
      </div>

      {isLoading ? (
        <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-5">
          {Array.from({ length: 10 }, (_, slot) => (
            <div
              key={slot}
              className="h-52 animate-pulse rounded-2xl border border-white/10 bg-[#1a1a1a]"
            />
          ))}
        </div>
      ) : visible.length === 0 ? (
        <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
          <Users className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
          <p className="text-zinc-400">
            {characters.length === 0
              ? t('uma.noTrainees')
              : t('uma.noTraineeMatches')}
          </p>
        </div>
      ) : (
        <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-5">
          {visible.map((character) => (
            <article
              key={character.id}
              className="group flex flex-col rounded-2xl border border-white/10 bg-[#1a1a1a] p-4 transition-all duration-300 hover:-translate-y-1 hover:border-amber-500/40 hover:shadow-[0_0_35px_rgba(217,164,65,0.18)]"
            >
              <div className="mb-4 flex h-28 items-center justify-center overflow-hidden rounded-xl bg-white/[0.04] ring-1 ring-white/10">
                {character.icon_url ? (
                  <img
                    src={character.icon_url}
                    alt={character.name}
                    loading="lazy"
                    className="h-full w-auto object-contain transition-transform duration-500 group-hover:scale-110"
                  />
                ) : (
                  <Users className="h-8 w-8 text-zinc-600" />
                )}
              </div>

              <h2
                className="mb-1 line-clamp-2 text-sm font-semibold text-white"
                title={character.name}
              >
                {character.name}
              </h2>

              {character.base_character && (
                <p className="mb-3 truncate text-xs text-zinc-500">
                  {character.base_character}
                </p>
              )}

              <div className="mt-auto flex items-center justify-between gap-2">
                {character.rarity && (
                  <span className="rounded-full bg-amber-500/15 px-2 py-0.5 text-xs font-medium text-amber-300 ring-1 ring-amber-400/30">
                    {character.rarity}
                  </span>
                )}
                {character.release_date && (
                  <span className="text-[11px] text-zinc-600">
                    {character.release_date}
                  </span>
                )}
              </div>
            </article>
          ))}
        </div>
      )}
    </UmamusumeLayout>
  )
}

export default UmamusumeCharacters

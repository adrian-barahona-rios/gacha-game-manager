import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { AlertCircle, ArrowLeft, ChevronRight, Globe, Loader2 } from 'lucide-react'
import { supabase } from '../config/supabase'
import { getGameById } from '../data/games'

const GAME_ID = 'umamusume-pretty-derby'

function UmamusumePage() {
  const navigate = useNavigate()
  const game = getGameById(GAME_ID)
  const [versions, setVersions] = useState([])
  const [counts, setCounts] = useState({})
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')

  useEffect(() => {
    let active = true

    Promise.all([
      supabase
        .from('umamusume_versions')
        .select('id, name')
        .order('sort_order', { ascending: true }),
      supabase.from('umamusume_characters').select('version'),
    ]).then(([versionsResult, charactersResult]) => {
      if (!active) {
        return
      }

      if (versionsResult.error) {
        setError(`No se pudieron cargar las versiones: ${versionsResult.error.message}`)
      } else {
        setVersions(versionsResult.data)
      }

      if (!charactersResult.error) {
        const next = {}
        charactersResult.data.forEach((row) => {
          next[row.version] = (next[row.version] ?? 0) + 1
        })
        setCounts(next)
      }

      setIsLoading(false)
    })

    return () => {
      active = false
    }
  }, [])

  return (
    <div className="relative min-h-screen scheme-dark overflow-hidden bg-black">
      <div className="pointer-events-none fixed inset-0" aria-hidden="true">
        <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_50%_10%,rgba(217,164,65,0.16),transparent_60%)]" />
        <div className="absolute inset-x-0 bottom-0 h-[38%] bg-[linear-gradient(to_top,rgba(88,50,22,0.6),transparent)]" />
        <div className="absolute -top-40 left-[15%] h-[28rem] w-[28rem] animate-pulse rounded-full bg-amber-600/12 blur-[130px] [animation-duration:10s]" />
      </div>

      <header className="relative z-20 border-b border-white/10 bg-black/60 backdrop-blur-xl">
        <div className="mx-auto flex max-w-4xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate('/dashboard')}
            aria-label="Volver al dashboard"
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>
          <div className="min-w-0">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">
              {game?.name ?? 'Umamusume'}
            </h1>
            <p className="truncate text-xs text-amber-200 sm:text-sm">
              Elige una versión del juego
            </p>
          </div>
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-4xl px-4 py-10 sm:px-6 sm:py-16">
        {error && (
          <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
            <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{error}</p>
          </div>
        )}

        {isLoading ? (
          <div className="grid gap-5 sm:grid-cols-2">
            {[0, 1].map((slot) => (
              <div
                key={slot}
                className="h-44 animate-pulse rounded-3xl border border-white/10 bg-[#1a1a1a]"
              />
            ))}
          </div>
        ) : (
          <div className="grid gap-5 sm:grid-cols-2">
            {versions.map((version) => (
              <button
                key={version.id}
                type="button"
                onClick={() => navigate(`/game/umamusume/${version.id}/characters`)}
                className="group flex flex-col items-start rounded-3xl border border-white/10 bg-[#111114]/80 p-7 text-left backdrop-blur-xl transition-all duration-300 hover:-translate-y-1 hover:border-amber-500/50 hover:shadow-[0_0_40px_rgba(217,164,65,0.2)] focus:outline-none focus:ring-4 focus:ring-amber-500/30"
              >
                <span className="mb-5 flex h-12 w-12 items-center justify-center rounded-2xl bg-gradient-to-b from-white/15 to-white/[0.03] ring-1 ring-white/10">
                  <Globe className="h-6 w-6 text-amber-200" />
                </span>

                <span className="mb-1.5 text-2xl font-semibold tracking-tight text-white">
                  {version.name}
                </span>
                <span className="mb-6 text-sm text-zinc-500">
                  {counts[version.id] ?? 0} entrenadoras
                </span>

                <span className="mt-auto flex items-center gap-2 text-sm font-semibold text-amber-200">
                  Entrar
                  <ChevronRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-1" />
                </span>
              </button>
            ))}
          </div>
        )}

        {!isLoading && versions.length === 0 && !error && (
          <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
            <Loader2 className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
            <p className="text-zinc-400">
              No hay versiones cargadas. Ejecuta supabase/umamusume.sql.
            </p>
          </div>
        )}
      </main>
    </div>
  )
}

export default UmamusumePage

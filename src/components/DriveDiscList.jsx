import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { AlertCircle, ArrowLeft, ChevronDown, Disc3, Loader2, Search } from 'lucide-react'
import { supabase } from '../config/supabase'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import ProfileButton from './ProfileButton'

const sinAcentos = (texto) =>
  texto
    .normalize('NFD')
    .replace(/\p{Diacritic}/gu, '')
    .toLowerCase()

// Pistas de disco de Zenless. No tienen stats ni pasiva como las armas: lo que
// importa de cada conjunto es su efecto de 2 y de 4 piezas, asi que todo cabe
// en una tarjeta y no hace falta una pagina por disco.
function DriveDiscList() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const { t } = useI18n()
  const game = getGameById(gameId)

  const [discs, setDiscs] = useState([])
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState('')
  const [term, setTerm] = useState('')
  // Disco del que se estan viendo las stats principales de cada ranura.
  const [openId, setOpenId] = useState(null)

  useEffect(() => {
    let active = true

    supabase
      .from('drive_discs')
      .select('id, name, name_en, image_url, grades, two_piece, four_piece, main_stats, how_to_get')
      .eq('game_id', gameId)
      .order('name', { ascending: true })
      .then(({ data, error: loadError }) => {
        if (!active) {
          return
        }
        if (loadError) {
          setError(t('discs.error.load', { message: loadError.message }))
          setDiscs([])
        } else {
          setError('')
          setDiscs(data ?? [])
        }
        setIsLoading(false)
      })

    return () => {
      active = false
    }
  }, [gameId, t])

  // Se busca tambien dentro de los efectos: asi se puede escribir "crítico" o
  // "etéreo" y ver que conjuntos lo mejoran.
  const needle = sinAcentos(term.trim())
  const visible = discs.filter((disc) =>
    !needle
      ? true
      : [disc.name, disc.name_en, disc.two_piece, disc.four_piece].some((texto) =>
          sinAcentos(texto ?? '').includes(needle),
        ),
  )

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-7xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}`)}
            aria-label={t('characters.backToGame')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">
              {t('discs.title')}
            </h1>
            <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>
              {game?.name ?? gameId}
            </p>
          </div>

          <ProfileButton />
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-7xl px-4 py-10 sm:px-6 sm:py-14">
        {error && (
          <div className="mb-6 flex items-start gap-3 rounded-xl border border-red-500/30 bg-red-500/10 px-4 py-3 text-sm text-red-200">
            <AlertCircle className="mt-0.5 h-4 w-4 shrink-0" />
            <p>{error}</p>
          </div>
        )}

        <div className="mb-8 flex flex-wrap items-center gap-4">
          <div className="relative min-w-[15rem] flex-1">
            <input
              value={term}
              onChange={(event) => setTerm(event.target.value)}
              placeholder={t('discs.search')}
              className="peer w-full rounded-xl border border-white/10 bg-white/[0.03] py-3 pl-11 pr-4 text-[15px] text-white placeholder:text-zinc-600 transition-all duration-300 hover:border-white/20 focus:border-white/30 focus:bg-white/[0.06] focus:outline-none focus:ring-4 focus:ring-white/5"
            />
            <Search className="pointer-events-none absolute left-3.5 top-1/2 h-[18px] w-[18px] -translate-y-1/2 text-zinc-500 transition-colors duration-300 peer-focus:text-white" />
          </div>

          {!isLoading && (
            <span className="text-sm text-zinc-500">
              {t(visible.length === 1 ? 'weapons.count' : 'weapons.countPlural', {
                count: visible.length,
              })}
            </span>
          )}
        </div>

        {isLoading ? (
          <div className="flex items-center justify-center gap-2.5 py-20 text-zinc-500">
            <Loader2 className="h-5 w-5 animate-spin" />
            {t('common.loading')}
          </div>
        ) : visible.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-14 text-center">
            <Disc3 className="mx-auto mb-4 h-10 w-10 text-zinc-600" />
            <p className="text-zinc-400">{needle ? t('weapons.noMatches') : t('discs.empty')}</p>
          </div>
        ) : (
          <div className="grid gap-5 md:grid-cols-2">
            {visible.map((disc) => {
              const isOpen = openId === disc.id
              const ranuras = Array.isArray(disc.main_stats) ? disc.main_stats : []

              return (
                <article
                  key={disc.id}
                  className="flex flex-col rounded-2xl border border-white/10 bg-white/[0.03] p-5"
                >
                  <div className="mb-4 flex items-center gap-4">
                    <span className="flex h-20 w-20 shrink-0 items-center justify-center rounded-xl bg-black/40 p-1.5">
                      {disc.image_url ? (
                        <img
                          src={disc.image_url}
                          alt={disc.name}
                          loading="lazy"
                          className="h-full w-full object-contain"
                        />
                      ) : (
                        <Disc3 className="h-9 w-9 text-zinc-600" />
                      )}
                    </span>
                    <div className="min-w-0">
                      <h2 className="text-lg font-semibold leading-snug tracking-tight text-white">
                        {disc.name}
                      </h2>
                      <p className="mb-1.5 text-xs text-zinc-500">{disc.name_en}</p>
                      {disc.grades && (
                        <span className="rounded-full bg-amber-500/10 px-2.5 py-0.5 text-[11px] font-semibold text-amber-200 ring-1 ring-amber-400/30">
                          {t('discs.grades', { grades: disc.grades.split(',').join(' · ') })}
                        </span>
                      )}
                    </div>
                  </div>

                  <dl className="mb-4 space-y-3 text-[14px] leading-relaxed">
                    <div>
                      <dt className="mb-0.5 text-[11px] font-semibold uppercase tracking-wide text-[#7aa7ff]">
                        {t('discs.twoPiece')}
                      </dt>
                      <dd className="text-zinc-200">{disc.two_piece}</dd>
                    </div>
                    <div>
                      <dt className="mb-0.5 text-[11px] font-semibold uppercase tracking-wide text-[#7aa7ff]">
                        {t('discs.fourPiece')}
                      </dt>
                      <dd className="text-zinc-300">{disc.four_piece}</dd>
                    </div>
                  </dl>

                  {disc.how_to_get && (
                    <div className="mb-4">
                      <p className="mb-1 text-[11px] font-semibold uppercase tracking-wide text-zinc-500">
                        {t('discs.howToGet')}
                      </p>
                      <ul className="space-y-1">
                        {disc.how_to_get.split(' · ').map((linea) => (
                          <li key={linea} className="flex gap-2 text-[13px] text-zinc-400">
                            <span className="mt-[7px] h-1 w-1 shrink-0 rounded-full bg-zinc-500" />
                            {linea}
                          </li>
                        ))}
                      </ul>
                    </div>
                  )}

                  {ranuras.length > 0 && (
                    <div className="mt-auto border-t border-white/10 pt-3">
                      <button
                        type="button"
                        onClick={() => setOpenId(isOpen ? null : disc.id)}
                        aria-expanded={isOpen}
                        className="flex w-full items-center justify-between text-left text-sm font-medium text-zinc-300 transition hover:text-white focus:outline-none"
                      >
                        {t('discs.mainStats')}
                        <ChevronDown
                          className={`h-4 w-4 transition-transform duration-300 ${isOpen ? 'rotate-180' : ''}`}
                        />
                      </button>

                      {isOpen && (
                        <ul className="mt-3 space-y-1.5">
                          {ranuras.map((r) => (
                            <li key={r.ranura} className="flex gap-3 text-[13px]">
                              <span className="w-16 shrink-0 font-semibold text-white">
                                {t('discs.slot', { slot: r.ranura })}
                              </span>
                              <span className="text-zinc-400">{r.stats}</span>
                            </li>
                          ))}
                        </ul>
                      )}
                    </div>
                  )}
                </article>
              )
            })}
          </div>
        )}
      </main>
    </div>
  )
}

export default DriveDiscList

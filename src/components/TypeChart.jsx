import { useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { ArrowLeft } from 'lucide-react'
import { useI18n } from '../i18n/useI18n'
import { getGameById } from '../data/games'
import { getElementChip } from '../data/characterStyles'
import { ELEMENTS, MATRIX, STRONG, WEAK, matchupsOf } from '../data/aniimoTypes'
import ProfileButton from './ProfileButton'

// Color de la casilla segun el multiplicador.
const CELDA = {
  [STRONG]: 'bg-emerald-500/20 text-emerald-200',
  [WEAK]: 'bg-rose-500/20 text-rose-200',
  1: 'bg-white/[0.03] text-zinc-500',
}

function Chips({ elementos, vacio }) {
  if (elementos.length === 0) {
    return <span className="text-sm text-zinc-600">{vacio}</span>
  }
  return (
    <span className="flex flex-wrap gap-1.5">
      {elementos.map((elemento) => (
        <span
          key={elemento}
          className={`rounded-md bg-white/[0.03] px-2 py-0.5 text-xs font-medium ring-1 ${getElementChip(elemento)}`}
        >
          {elemento}
        </span>
      ))}
    </span>
  )
}

// Tabla de tipos: las nueve filas atacan y las nueve columnas se defienden.
// Al elegir un elemento se resalta su fila y su columna y se resume debajo.
function TypeChart() {
  const { gameId } = useParams()
  const navigate = useNavigate()
  const { t } = useI18n()
  const game = getGameById(gameId)
  const [elegido, setElegido] = useState(null)

  const resumen = elegido ? matchupsOf(elegido) : null

  return (
    <div className="relative min-h-screen scheme-dark bg-black">
      <header className="sticky top-0 z-20 border-b border-white/10 bg-black/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-6xl items-center gap-4 px-4 py-4 sm:px-6">
          <button
            type="button"
            onClick={() => navigate(`/game/${gameId}`)}
            aria-label={t('characters.backToGame')}
            className="shrink-0 rounded-lg border border-white/10 bg-white/5 p-2.5 text-white transition-all duration-300 hover:border-white/30 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/20 active:scale-95"
          >
            <ArrowLeft className="h-4 w-4" />
          </button>

          <div className="min-w-0 flex-1">
            <h1 className="truncate text-lg font-semibold tracking-tight text-white sm:text-xl">{t('types.title')}</h1>
            <p className={`truncate text-xs sm:text-sm ${game?.accent ?? 'text-zinc-500'}`}>{game?.name ?? gameId}</p>
          </div>

          <ProfileButton />
        </div>
      </header>

      <main className="relative z-10 mx-auto max-w-6xl px-4 py-10 sm:px-6 sm:py-14">
        <p className="mb-6 max-w-3xl text-sm leading-relaxed text-zinc-400">{t('types.hint')}</p>

        <div className="mb-6 flex flex-wrap gap-2">
          {ELEMENTS.map((elemento) => {
            const isActive = elegido === elemento.es
            return (
              <button
                key={elemento.en}
                type="button"
                aria-pressed={isActive}
                onClick={() => setElegido(isActive ? null : elemento.es)}
                className={`rounded-full px-3 py-1 text-xs font-medium ring-1 transition-all duration-200 focus:outline-none focus:ring-4 focus:ring-white/15 ${
                  isActive ? 'bg-white text-black ring-white' : `bg-white/[0.03] hover:bg-white/10 ${getElementChip(elemento.es)}`
                }`}
              >
                {elemento.es}
              </button>
            )
          })}
        </div>

        {resumen && (
          <div className="mb-8 grid gap-3 sm:grid-cols-2">
            {[
              ['types.strongAgainst', 'types.strongAgainstHint', resumen.strongAgainst],
              ['types.weakAgainst', 'types.weakAgainstHint', resumen.weakAgainst],
              ['types.vulnerableTo', 'types.vulnerableToHint', resumen.vulnerableTo],
              ['types.resistantTo', 'types.resistantToHint', resumen.resistantTo],
            ].map(([titulo, pista, lista]) => (
              <section key={titulo} className="rounded-2xl border border-white/10 bg-white/[0.02] p-4">
                <h2 className="text-sm font-semibold text-white">{t(titulo)}</h2>
                <p className="mb-2.5 text-xs text-zinc-500">{t(pista)}</p>
                <Chips elementos={lista} vacio={t('types.none')} />
              </section>
            ))}
          </div>
        )}

        <div className="mb-3 flex flex-wrap items-center gap-4 text-xs text-zinc-500">
          <span className="flex items-center gap-1.5">
            <span className="h-3 w-3 rounded bg-emerald-500/30" /> {t('types.legendStrong')}
          </span>
          <span className="flex items-center gap-1.5">
            <span className="h-3 w-3 rounded bg-rose-500/30" /> {t('types.legendWeak')}
          </span>
          <span className="flex items-center gap-1.5">
            <span className="h-3 w-3 rounded bg-white/10" /> {t('types.legendNeutral')}
          </span>
        </div>

        {/* En movil la tabla no cabe: se desplaza a lo ancho ella sola. */}
        <div className="overflow-x-auto rounded-2xl border border-white/10 bg-white/[0.02] p-3">
          <table className="w-full min-w-[42rem] border-separate border-spacing-1 text-center">
            <caption className="sr-only">{t('types.tableCaption')}</caption>
            <thead>
              <tr>
                <th scope="col" className="w-24 text-left text-[11px] font-medium uppercase tracking-wide text-zinc-600">
                  {t('types.attacker')}
                </th>
                {ELEMENTS.map((elemento) => (
                  <th
                    key={elemento.en}
                    scope="col"
                    className={`rounded-lg px-1 py-1.5 text-[11px] font-semibold transition ${
                      elegido === elemento.es ? 'bg-white/15 text-white' : 'text-zinc-400'
                    }`}
                  >
                    {elemento.es}
                  </th>
                ))}
              </tr>
            </thead>
            <tbody>
              {ELEMENTS.map((fila, i) => (
                <tr key={fila.en}>
                  <th
                    scope="row"
                    className={`rounded-lg px-2 py-1.5 text-left text-[11px] font-semibold transition ${
                      elegido === fila.es ? 'bg-white/15 text-white' : 'text-zinc-400'
                    }`}
                  >
                    {fila.es}
                  </th>
                  {ELEMENTS.map((columna, j) => {
                    const valor = MATRIX[i][j]
                    const enfocada = !elegido || elegido === fila.es || elegido === columna.es
                    return (
                      <td
                        key={columna.en}
                        title={`${fila.es} → ${columna.es}: ×${valor}`}
                        className={`rounded-lg py-1.5 text-xs font-semibold transition ${CELDA[valor]} ${
                          enfocada ? '' : 'opacity-25'
                        }`}
                      >
                        {valor === 1 ? '·' : `×${valor}`}
                      </td>
                    )
                  })}
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        <p className="mt-4 text-xs leading-relaxed text-zinc-600">{t('types.source')}</p>
      </main>
    </div>
  )
}

export default TypeChart

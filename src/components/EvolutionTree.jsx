import { ChevronRight } from 'lucide-react'
import { useI18n } from '../i18n/useI18n'

// Una criatura del arbol, con su icono, su etapa y lo que hace falta para
// llegar hasta ella.
function Nodo({ nodo, onOpen }) {
  const contenido = (
    <>
      <span className="flex h-14 w-14 shrink-0 items-center justify-center overflow-hidden rounded-xl bg-black/40">
        {nodo.icono ? (
          <img src={nodo.icono} alt="" loading="lazy" className="h-full w-full object-contain" />
        ) : (
          <span className="text-lg font-bold text-white/80">{nodo.nombre.charAt(0)}</span>
        )}
      </span>
      <span className="min-w-0">
        <span className="block text-sm font-semibold leading-snug text-white">{nodo.nombre}</span>
        {nodo.etapa && <span className="block text-[11px] text-zinc-500">{nodo.etapa}</span>}
      </span>
    </>
  )

  return (
    <div className="flex flex-col gap-1.5">
      {onOpen ? (
        <button
          type="button"
          onClick={onOpen}
          className="flex items-center gap-3 rounded-2xl border border-white/10 bg-white/[0.03] p-2 text-left transition hover:border-white/25 hover:bg-white/10 focus:outline-none focus:ring-4 focus:ring-white/15"
        >
          {contenido}
        </button>
      ) : (
        <div className="flex items-center gap-3 rounded-2xl border border-white/10 bg-white/[0.03] p-2">{contenido}</div>
      )}
      {(nodo.condiciones ?? []).length > 0 && (
        <p className="pl-1 text-[11px] leading-snug text-zinc-500">{nodo.condiciones.join(' · ')}</p>
      )}
    </div>
  )
}

// Rama del arbol: la criatura y, a su derecha, las formas en las que puede
// evolucionar. Cuando hay varias, se apilan en vertical.
function Rama({ nodo, buscarId, onOpen }) {
  const siguientes = nodo.siguientes ?? []
  const id = buscarId?.(nodo.nombre)
  return (
    <div className="flex flex-col items-start gap-3 sm:flex-row sm:items-center">
      <Nodo nodo={nodo} onOpen={id ? () => onOpen(id) : null} />
      {siguientes.length > 0 && (
        <>
          <ChevronRight className="h-4 w-4 shrink-0 rotate-90 text-zinc-600 sm:rotate-0" />
          <div className="flex flex-col gap-3">
            {siguientes.map((hijo, index) => (
              <Rama key={`${hijo.nombre}-${index}`} nodo={hijo} buscarId={buscarId} onOpen={onOpen} />
            ))}
          </div>
        </>
      )}
    </div>
  )
}

// Linea de evolucion de una criatura (Aniimo).
function EvolutionTree({ evolution, buscarId, onOpen }) {
  const { t } = useI18n()
  const arbol = evolution?.arbol
  if (!arbol) return null

  return (
    <div className="mb-8">
      <p className="mb-4 text-sm text-zinc-500">{t('character.evolutionHint')}</p>
      <div className="overflow-x-auto">
        <Rama nodo={arbol} buscarId={buscarId} onOpen={onOpen} />
      </div>
      {(evolution.formas ?? []).length > 1 && (
        <p className="mt-4 text-xs text-zinc-500">{t('character.forms', { count: evolution.formas.length })}</p>
      )}
    </div>
  )
}

export default EvolutionTree

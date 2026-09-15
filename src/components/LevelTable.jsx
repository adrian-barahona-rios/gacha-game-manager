import { useState } from 'react'
import { ChevronDown } from 'lucide-react'
import { useI18n } from '../i18n/useI18n'

// Tabla de valores por nivel de una habilidad: [{ clave, valores }].
// La primera fila suele ser la cabecera ("Nivel 1", "Nivel 2"...). Va plegada
// para no alargar la ficha y se desplaza en horizontal en pantallas estrechas.
function LevelTable({ atributos }) {
  const { t } = useI18n()
  const [abierta, setAbierta] = useState(false)
  const filas = Array.isArray(atributos) ? atributos.filter((a) => (a.valores ?? []).length) : []
  if (!filas.length) return null

  const esCabecera = (fila) => fila.valores.every((v) => /^(nivel|level|lv\.?)\s*\d/i.test(v) || /[★☆]/.test(v) || /^nivel \+\d/i.test(v))
  const [cabecera, ...resto] = esCabecera(filas[0]) ? filas : [null, ...filas]

  return (
    <div className="mt-3">
      <button
        type="button"
        aria-expanded={abierta}
        onClick={() => setAbierta((v) => !v)}
        className="flex items-center gap-1.5 text-xs font-medium text-zinc-400 transition hover:text-white focus:outline-none"
      >
        {t(abierta ? 'skills.hideValues' : 'skills.showValues')}
        <ChevronDown className={`h-3.5 w-3.5 transition-transform ${abierta ? 'rotate-180' : ''}`} />
      </button>

      {abierta && (
        <div className="mt-2 overflow-x-auto rounded-xl border border-white/10">
          <table className="min-w-full text-left text-xs">
            {cabecera && (
              <thead className="bg-white/[0.04] text-zinc-400">
                <tr>
                  <th className="sticky left-0 bg-[#141418] px-3 py-2 font-medium">{cabecera.clave}</th>
                  {cabecera.valores.map((v, i) => (
                    <th key={i} className="whitespace-nowrap px-3 py-2 font-medium">{v}</th>
                  ))}
                </tr>
              </thead>
            )}
            <tbody className="divide-y divide-white/5">
              {resto.map((fila, n) => (
                <tr key={`${fila.clave}-${n}`}>
                  <th className="sticky left-0 min-w-[10rem] bg-[#101014] px-3 py-2 font-medium text-zinc-300">{fila.clave}</th>
                  {fila.valores.map((v, i) => (
                    <td key={i} className="whitespace-nowrap px-3 py-2 text-zinc-200">{v}</td>
                  ))}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  )
}

export default LevelTable

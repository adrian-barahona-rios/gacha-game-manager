import { useCallback, useEffect, useMemo, useState } from 'react'
import { LanguageContext, STORAGE_KEY } from './context'
import { STRINGS } from './strings'

// Devuelve el idioma guardado, o null si el usuario todavia no ha elegido.
function readStoredLanguage() {
  try {
    const stored = window.localStorage.getItem(STORAGE_KEY)
    return stored === 'es' || stored === 'en' ? stored : null
  } catch {
    return null
  }
}

// Sugerencia inicial segun el navegador, solo para marcar la opcion propuesta.
function suggestLanguage() {
  try {
    return (window.navigator.language ?? '').toLowerCase().startsWith('es') ? 'es' : 'en'
  } catch {
    return 'es'
  }
}

function LanguageProvider({ children }) {
  const [language, setLanguageState] = useState(readStoredLanguage)

  const setLanguage = useCallback((next) => {
    setLanguageState(next)
    try {
      window.localStorage.setItem(STORAGE_KEY, next)
    } catch {
      // Si el navegador bloquea el almacenamiento, el idioma dura la sesion.
    }
  }, [])

  useEffect(() => {
    document.documentElement.lang = language ?? suggestLanguage()
  }, [language])

  const value = useMemo(() => {
    const active = language ?? suggestLanguage()

    // t('clave') busca en el idioma activo y cae al ingles si falta la entrada.
    const t = (key, vars) => {
      const raw = STRINGS[active]?.[key] ?? STRINGS.en[key] ?? key
      if (!vars) {
        return raw
      }
      return Object.entries(vars).reduce(
        (text, [name, replacement]) => text.replaceAll(`{${name}}`, String(replacement)),
        raw,
      )
    }

    return { language, activeLanguage: active, hasChosen: language != null, setLanguage, t }
  }, [language, setLanguage])

  return <LanguageContext.Provider value={value}>{children}</LanguageContext.Provider>
}

export default LanguageProvider

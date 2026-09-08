import { createContext } from 'react'

export const LANGUAGES = [
  { id: 'es', label: 'Español', native: 'Español', hint: 'Idioma de la aplicación' },
  { id: 'en', label: 'English', native: 'English', hint: 'Application language' },
]

export const STORAGE_KEY = 'gacha-manager:language'

export const LanguageContext = createContext(null)

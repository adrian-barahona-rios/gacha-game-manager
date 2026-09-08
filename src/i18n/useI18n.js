import { useContext } from 'react'
import { LanguageContext } from './context'

export function useI18n() {
  const context = useContext(LanguageContext)
  if (!context) {
    throw new Error('useI18n necesita estar dentro de LanguageProvider')
  }
  return context
}

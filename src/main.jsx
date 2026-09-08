import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import './index.css'
import App from './App.jsx'
import LanguageGate from './components/LanguageGate.jsx'
import LanguageProvider from './i18n/LanguageProvider.jsx'

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <LanguageProvider>
      <LanguageGate>
        <BrowserRouter>
          <App />
        </BrowserRouter>
      </LanguageGate>
    </LanguageProvider>
  </StrictMode>,
)

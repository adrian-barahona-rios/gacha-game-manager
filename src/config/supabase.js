import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error(
    'Faltan VITE_SUPABASE_URL o VITE_SUPABASE_ANON_KEY en .env.local. ' +
      'Vite solo lee ese archivo al arrancar: reinicia el servidor tras editarlo.',
  )
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

export default supabase

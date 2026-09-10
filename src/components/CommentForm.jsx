import { useState } from 'react'
import { Loader2, Send, Star, X } from 'lucide-react'
import { useI18n } from '../i18n/useI18n'
import { isOffensive } from '../data/moderation'

const STARS = [1, 2, 3, 4, 5]

// Formulario compartido por los tres casos: comentario nuevo, respuesta a otro
// comentario y edicion de uno propio. Cambia el texto del boton y poco mas.
//
// La valoracion en estrellas solo aparece en los comentarios de primer nivel:
// una respuesta dentro de un hilo no valora la aplicacion.
function CommentForm({
  variant = 'root',
  initialContent = '',
  initialRating = null,
  isBusy = false,
  autoFocus = false,
  onSubmit,
  onCancel,
}) {
  const { t } = useI18n()
  const [content, setContent] = useState(initialContent)
  const [rating, setRating] = useState(initialRating)
  const [hovered, setHovered] = useState(null)
  const [warning, setWarning] = useState('')

  const showRating = variant !== 'reply'
  const trimmed = content.trim()
  const canSend = trimmed.length > 0 && !isBusy

  const labelByVariant = {
    root: t('comments.form.send'),
    reply: t('comments.form.reply'),
    edit: t('comments.form.save'),
  }

  const handleSubmit = async (event) => {
    event.preventDefault()

    if (!canSend) {
      return
    }

    // Aviso inmediato, sin ir al servidor. La comprobacion de verdad la hace
    // la base de datos: esta solo evita el viaje y explica el motivo antes.
    if (isOffensive(trimmed)) {
      setWarning(t('comments.error.offensive'))
      return
    }

    setWarning('')
    const ok = await onSubmit({ content: trimmed, rating: showRating ? rating : null })

    if (ok && variant === 'root') {
      setContent('')
      setRating(null)
    }
  }

  return (
    <form onSubmit={handleSubmit} className="w-full">
      <textarea
        value={content}
        onChange={(event) => {
          setContent(event.target.value)
          if (warning) {
            setWarning('')
          }
        }}
        autoFocus={autoFocus}
        rows={variant === 'root' ? 3 : 2}
        maxLength={2000}
        placeholder={
          variant === 'reply' ? t('comments.form.replyPlaceholder') : t('comments.form.placeholder')
        }
        className="w-full resize-y rounded-xl border border-white/10 bg-white/[0.03] px-4 py-3 text-[15px] text-white placeholder:text-zinc-600 transition-all duration-300 hover:border-white/20 focus:border-white/30 focus:bg-white/[0.06] focus:outline-none focus:ring-4 focus:ring-white/5"
      />

      {warning && (
        <p className="mt-2 rounded-lg border border-red-500/30 bg-red-500/10 px-3 py-2 text-sm text-red-200">
          {warning}
        </p>
      )}

      <div className="mt-3 flex flex-wrap items-center gap-x-4 gap-y-3">
        {showRating && (
          <div className="flex items-center gap-1.5">
            <span className="mr-1 text-xs uppercase tracking-wide text-zinc-500">
              {t('comments.form.rating')}
            </span>
            {STARS.map((value) => {
              const active = (hovered ?? rating ?? 0) >= value
              return (
                <button
                  key={value}
                  type="button"
                  onClick={() => setRating(rating === value ? null : value)}
                  onMouseEnter={() => setHovered(value)}
                  onMouseLeave={() => setHovered(null)}
                  aria-label={t('comments.form.ratingValue', { value })}
                  aria-pressed={rating === value}
                  className="rounded transition-transform duration-200 hover:scale-125 focus:outline-none focus:ring-2 focus:ring-amber-400/50"
                >
                  <Star
                    className={`h-[18px] w-[18px] ${
                      active ? 'fill-amber-400 text-amber-400' : 'text-zinc-600'
                    }`}
                  />
                </button>
              )
            })}
            {rating !== null && (
              <button
                type="button"
                onClick={() => setRating(null)}
                className="ml-1 text-xs text-zinc-500 underline-offset-2 hover:text-zinc-300 hover:underline"
              >
                {t('comments.form.ratingClear')}
              </button>
            )}
          </div>
        )}

        <div className="ml-auto flex items-center gap-2">
          {onCancel && (
            <button
              type="button"
              onClick={onCancel}
              className="flex items-center gap-1.5 rounded-xl border border-white/10 px-4 py-2.5 text-sm text-zinc-400 transition-all duration-300 hover:border-white/25 hover:text-white focus:outline-none focus:ring-4 focus:ring-white/10 active:scale-95"
            >
              <X className="h-4 w-4" />
              {t('common.cancel')}
            </button>
          )}

          <button
            type="submit"
            disabled={!canSend}
            className="flex items-center gap-2 rounded-xl bg-white px-5 py-2.5 text-sm font-semibold text-black transition-all duration-300 hover:-translate-y-0.5 hover:bg-[#0066ff] hover:text-white hover:shadow-[0_0_25px_rgba(0,102,255,0.5)] focus:outline-none focus:ring-4 focus:ring-blue-500/30 active:translate-y-0 active:scale-95 disabled:cursor-not-allowed disabled:opacity-40 disabled:hover:translate-y-0 disabled:hover:bg-white disabled:hover:text-black disabled:hover:shadow-none"
          >
            {isBusy ? (
              <Loader2 className="h-4 w-4 animate-spin" />
            ) : (
              <Send className="h-4 w-4" />
            )}
            {labelByVariant[variant]}
          </button>
        </div>
      </div>
    </form>
  )
}

export default CommentForm

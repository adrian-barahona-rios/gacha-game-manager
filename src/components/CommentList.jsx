import { MessageSquare } from 'lucide-react'
import { useI18n } from '../i18n/useI18n'
import CommentThread from './CommentThread'

// Solo pinta los comentarios de primer nivel: cada uno arrastra sus respuestas.
function CommentList({ comments, ...threadProps }) {
  const { t } = useI18n()

  if (comments.length === 0) {
    return (
      <div className="rounded-2xl border border-dashed border-white/15 bg-white/[0.02] p-12 text-center">
        <MessageSquare className="mx-auto mb-4 h-9 w-9 text-zinc-600" />
        <p className="text-zinc-400">{t('comments.empty')}</p>
      </div>
    )
  }

  return (
    <div className="space-y-4">
      {comments.map((comment) => (
        <CommentThread key={comment.id} comment={comment} depth={0} {...threadProps} />
      ))}
    </div>
  )
}

export default CommentList

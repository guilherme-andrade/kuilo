class CommentObserver < ApplicationObserver
  def after_create(record)
    recipients = User.where(id: record.mentioned_user_ids)
    CommentNotification.with(notifiable: record).deliver(recipients)
  end
end

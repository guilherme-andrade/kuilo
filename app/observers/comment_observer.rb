class CommentObserver < ApplicationObserver
  def after_create(record)
    CommentNotification.with(notifiable: record).deliver(record.user)
  end
end

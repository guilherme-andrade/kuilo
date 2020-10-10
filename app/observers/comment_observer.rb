class CommentObserver < ApplicationObserver
  def after_create(record)
    CommentNotification.with(notifiable: self).deliver(user)
  end
end

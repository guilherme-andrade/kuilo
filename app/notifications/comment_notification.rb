class CommentNotification < ApplicationNotification
  deliver_by :email, mailer: 'NotificationsMailer', method: :comment, if: :email_notifications?

  def message
    if notifiable.mentions.include?(recipient)
      t('notifications.new_comment_mentioning_you')
    else
      t('notifications.new_comment')
    end
  end

  def actor
    notifiable.user
  end

  def url
    Kuilo::Application.default_url_options = { host: ENV['APP_BASE_URL'] }
    return property_url(notifiable.commentable) if notifiable.commentable.is_a? Property

    url_for(notifiable.commentable) + '#comments-modal'
  end
end

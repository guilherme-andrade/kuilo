class CommentNotification < ApplicationNotification
  deliver_by :email, mailer: 'NotificationsMailer', method: :comment, if: :email_notifications?

  def message
    if notifiable.mentioned_user_ids.include?(recipient.id)
      t('notifications.new_comment_mentioning_you', locale_data)
    else
      t('notifications.new_comment', locale_data)
    end
  end

  def actor
    notifiable.user
  end

  def locale_data
    {
      author_name: notifiable.author_name,
      url: url,
      commentable_name: notifiable.commentable_name
    }
  end

  def url
    notifiable.commentable_url
  end
end

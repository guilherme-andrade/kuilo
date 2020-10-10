class ApplicationNotification < Noticed::Base
  deliver_by :database, format: :format_for_database

  def format_for_database
    {
      notifiable: notifiable,
      type: 'Notification',
      params: {
        url: url,
        message: message,
        actor: actor
      }
    }
  end

  def email_notifications?
    recipient.email.present?
  end

  def notifiable
    @notifiable ||= params.delete(:notifiable)
  end
end

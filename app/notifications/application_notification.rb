class ApplicationNotification < Noticed::Base
  deliver_by :database, format: :format_for_database
  deliver_by :push_notification, class: 'DeliveryMethods::PushNotification', format: :format_for_push_notification

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

  def format_for_push_notification
    {
      notifiable: notifiable,
      type: 'Notification',
      message: message,
      actor: actor
    }
  end

  def email_notifications?
    recipient.email.present?
  end

  def notifiable
    @notifiable ||= params.dig(:notifiable)
  end
end

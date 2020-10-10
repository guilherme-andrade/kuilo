class ContractStatusChangedNotification < ApplicationNotification
  deliver_by :email, mailer: 'NotificationsMailer', method: :contract_status_changed, if: :email_notifications?

  def message
    i18n_data = {
      property_code: notifiable.property_code,
      property_name: notifiable.property_name,
      customer_name: notifiable.customer_name
    }
    t("notifications.contract_#{notifiable.status}", **i18n_data)
  end

  def actor
    notifiable.manager
  end

  def url
    contract_path(notifiable)
  end
end

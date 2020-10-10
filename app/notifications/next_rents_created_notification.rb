class NextRentsCreatedNotification < ApplicationNotification
  deliver_by :email, mailer: 'NotificationsMailer', method: :next_rents_created, if: :email_notifications?

  def message
    t('notifications.next_rents_created.message')
  end

  def actor
    'Kuilo'
  end

  def url
    rents_path(q: { id_matches_any: params[:rent_ids] })
  end
end

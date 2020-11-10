# frozen_string_literal: true

class RentsReflex < ApplicationReflex
  def mark_as_paid
    rent = Rent.find(element.dataset.id)

    if rent.paid!
      toast success: I18n.t('alerts.rent_is_now_paid')
    else
      toast error: I18n.t('alerts.something_went_wrong')
    end
  end

  def mark_as_unpaid
    rent = Rent.find(element.dataset.id)

    if rent.unpaid!
      toast warning: I18n.t('alerts.rent_marked_as_unpaid')
    else
      toast error: I18n.t('alerts.something_went_wrong')
    end
  end

  def send_thank_you_email
  end
end

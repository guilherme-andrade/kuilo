class RentSubscriber < ApplicationSubscriber
  def after_status_change_to_paid(rent)
    with(notifiable: record).deliver(recipients)
  end

  def after_update(rent)
  end
end

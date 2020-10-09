# frozen_string_literal: true

class RentsReflex < ApplicationReflex
  def mark_as_paid
    rent = Rent.find(element.dataset.id)
    rent.paid!
  end

  def mark_as_unpaid
    rent = Rent.find(element.dataset.id)
    rent.unpaid!
  end

  def send_thank_you_email
  end
end

# frozen_string_literal: true

class Rent < ApplicationRecord
  include Commentable

  STATUSES = %i[unpaid paid].freeze

  monetize :amount_cents
  monetize :charges_cents
  monetize :full_cents
  monetize :discount_cents

  enum status: STATUSES

  belongs_to :contract

  def overdue?
    unpaid && due_one > Time.zone.today
  end
end

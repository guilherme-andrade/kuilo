# frozen_string_literal: true

class Rent < ApplicationRecord
  include Commentable

  STATUSES = %i[unpaid paid].freeze

  multi_tenant :organization

  belongs_to :contract

  enum status: STATUSES

  monetize :amount_cents
  monetize :charges_cents
  monetize :full_cents
  monetize :discount_cents

  delegate :customer, to: :contract
  delegate :property, to: :contract
  delegate :name, to: :customer, prefix: true
  delegate :name, to: :property, prefix: true

  has_one_attached :invoice

  def overdue?
    unpaid && due_one > Time.zone.today
  end
end

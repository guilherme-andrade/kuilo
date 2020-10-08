# frozen_string_literal: true

class Rent < ApplicationRecord
  include BelongsToOrganization
  include HasComments

  STATUSES = %i[unpaid paid].freeze

  belongs_to :contract

  enum status: STATUSES

  monetize :amount_cents
  monetize :charges_cents
  monetize :full_cents
  monetize :discount_cents

  delegate :customer, to: :contract
  delegate :property, to: :contract
  delegate :name, to: :customer, prefix: true
  delegate :name, :code, to: :property, prefix: true

  has_one_attached :invoice

  before_commit :generate_invoice, on: :create

  def incidence_period
    (incidence_period_end - incidence_period_start + 1).days
  end

  def overdue?
    unpaid && due_one > Time.zone.today
  end

  def full_cents
    charges_cents + amount_cents - discount_cents
  end

  def generate_invoice
    GenerateAndAttachPdf.call(
      record: self,
      attachment_name: :invoice,
      template: 'rents/invoice',
      
    )
  end
end

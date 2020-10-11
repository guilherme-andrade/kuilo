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

  scope :for, lambda { |*date_range|
    if date_range.is_a? Range
      where(incidence_period_start_date: date_range, incidence_period_end_date: date_range)
    else
      where('incidence_period_start_date <= ? AND ? <= incidence_period_end_date', date_range.first, date_range.last)
    end
  }

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
      template: 'rents/invoices/show',
      layout: 'pdf',
      filename: invoice_filename,
      locals: { '@rent': self }
    )
  end

  def invoice_filename
    "#{name}.pdf"
  end

  def name
    [property_code, incidence_period_start, incidence_period_end].join('_')
  end
end

# frozen_string_literal: true

class Contract < ApplicationRecord
  include ActionView::Helpers::DateHelper
  include ApplicationHelper

  TAXATION_TYPES = %i[retained charged].freeze
  INVOICING_FREQUENCY_UNITS = %i[month quarter semester year].freeze
  STATUSES = {
    in_negotiation: 0,
    signed: 10,
    confirmed: 20,
    active: 30,
    in_notice: 40,
    terminated: 50,
    cancelled: -10
  }.freeze

  multi_tenant :organization

  has_many :rents
  has_one :current_contract, -> { where(contracts: { status: Contract.statuses.dig('active') }) }, class_name: 'Contract', inverse_of: :occupied_property
  has_one :current_rent, -> { order('rents.due_date': :desc).limit(1) }, class_name: 'Rent'
  has_many :rents_unpaid, -> { where(rents: { status: Rent.statuses.dig('pending') }) }, class_name: 'Rent'
  has_paper_trail if: proc { |p| p.saved_change_to_status? }

  belongs_to :customer, touch: true
  belongs_to :organization
  belongs_to :property, touch: :contracts_last_updated_at
  belongs_to :occupied_property,
             class_name: 'Property',
             touch: :current_contract_last_updated_at,
             optional: true

  counter_culture :customer
  counter_culture :property

  monetize :rent_amount_cents
  monetize :rent_charges_cents
  monetize :rent_full_cents
  monetize :rent_invoice_value_cents

  enum taxation_type: TAXATION_TYPES
  enum invoicing_frequency_unit: INVOICING_FREQUENCY_UNITS
  enum status: STATUSES

  accepts_nested_attributes_for :customer

  default :rent_amount_cents,     (proc { |c| c.property.default_rent_cents if c.property })
  default :rent_amount_currency,  (proc { |c| c.property.default_rent_currency if c.property })
  default :rent_charges_cents,    (proc { |c| c.property.default_charges_cents if c.property })
  default :rent_charges_currency, (proc { |c| c.property.default_charges_currency if c.property })
  default :charges_description,   (proc { |c| c.property.default_charges_description if c.property })
  default :occupied_property_id,  (proc { |c| c.property.id if c.active? })
  default :organization_id,       (proc { |c| c.property.organization_id if c.property })
  default :rent_due_day,          (proc { |c| c.organization.default_rent_due_day })

  validates :start_date, :end_date, :renegotiation_period_start_date,
            :renegotiation_period_end_date, presence: true

  validates_date :start_date
  validates_date :end_date, on: :create, on_or_after: :today
  validates_date :end_date, after: :start_date
  validates_date :renegotiation_period_end_date, after: :renegotiation_period_start_date
  validates_date :renegotiation_period_end_date, on_or_before: :end_date
  validates_date :renegotiation_period_start_date, before: :end_date
  validates_date :renegotiation_period_end_date, after: :start_date
  validates_date :renegotiation_period_start_date, on_or_after: :start_date
  validate :property_availability

  delegate :name, :contact_name, :email, :phone, to: :customer, prefix: true, allow_nil: true
  delegate :account_manager, to: :customer, allow_nil: true
  delegate :name, :owner_name, :owner, :owner_type, :code, :full_address, to: :property, prefix: true
  delegate :name, to: :account_manager, prefix: true, allow_nil: true
  delegate :statuses, to: :class

  before_validation do
    update_attribute(:status, statuses[:active]) if (start_date..end_date).cover?(Time.zone.today) && !active?
  end

  scope :with_confirmation, -> { where('status >= ? AND status < ?', statuses[:confirmed], statuses[:terminated]) }
  scope :with_activation, -> { where('status >= ? AND status < ?', statuses[:active], statuses[:terminated]) }
  scope :pre_notice, -> { where('status < ?', statuses[:in_notice]) }
  scope :with_confirmation_pre_notice, -> { with_confirmation.pre_notice }

  scope :for, lambda { |*date_range|
    if date_range.is_a? Range
      where(start_date: date_range, end_date: date_range)
    else
      where('start_date <= ? AND ? <= end_date', date_range.first, date_range.last)
    end
  }

  def name
    [customer_name, property_name].join(' - ')
  end

  def rent_full_cents
    rent_amount_cents + rent_charges_cents
  end

  def duration
    distance_of_time_in_words(end_date, start_date)
  end

  def renegotiation_duration
    distance_of_time_in_words(renegotiation_period_end_date, renegotiation_period_start_date)
  end

  def rent_difference
    rent_full / property.default_rent_full
  end

  def deposit
    rent_amount * deposit_rent_multiplier
  end

  def invoicing_frequency
    case invoicing_frequency_unit
    when 'semester' then (invoicing_frequency_value * 6).months
    when 'quarter' then (invoicing_frequency_value * 3).months
    else invoicing_frequency_value.send(invoicing_frequency_unit)
    end
  end

  def invoicing_frequency_in_words
    distance_of_time_in_words(start_date, start_date + invoicing_frequency)
  end

  def rent_invoice_value_cents
    distance_of_time_in(:months, invoicing_frequency) * rent_full_cents
  end

  def rents_unpaid_amount_cents
    rents_unpaid.sum('(rents.amount_cents + rents.charges_cents - rents.discount_cents)')
  end

  def rents_unpaid?
    rents_unpaid.any?
  end

  def next_rent_due_date
    return unless current_rent

    current_rent.due_date.at_beginning_of_month.next_month + rent_due_day
  end

  def property_availability
    errors.add(:base, 'this property is occupied') unless property.available?
  end
end

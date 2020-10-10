# frozen_string_literal: true

class Property < ApplicationRecord
  include HasAddress
  include BelongsToOrganization
  include HasComments
  include ActiveSupport::NumberHelper

  TYPES           = %w[Apartment House Garage Office Room Warehouse].freeze
  STATUSES        = %i[available occupied ooo].freeze
  TYPOLOGIES      = %i[property].freeze
  CHARACTERISTICS = %i[area_unit area_value].freeze

  belongs_to :owner, polymorphic: true, optional: true
  belongs_to :enterprise, optional: true
  belongs_to :creator, class_name: 'User'
  belongs_to :manager, class_name: 'User', optional: true

  has_many :contracts, inverse_of: :property
  has_one :active_contract, -> { Contract.active }, class_name: 'Contract', inverse_of: :occupied_property

  enum status: STATUSES

  # counter_culture :owner
  # counter_culture :enterprise

  monetize :market_value_cents
  monetize :default_rent_cents
  monetize :default_charges_cents
  monetize :default_rent_full_cents

  validates :name, :code, presence: true
  validates :name, uniqueness: { scope: %i[owner_type owner_id] }

  default :status,                  (proc { 0 })
  default :organization_id,         (proc { |p| p.enterprise.organization_id if p.owner })
  default :manager_id,              (proc { |p| p.creator_id })
  default :owner_type,              (proc { 'Organization' })
  default :owner_id,                (proc { |p| p.organization_id if p.owner_type == 'Organization' })
  default :default_rent_cents,      (proc { 0 })
  default :default_charges_cents,   (proc { 0 })
  default :market_value_cents,      (proc { 0 })

  delegate :location_attributes, to: :parent_address, prefix: :parent, allow_nil: true
  delegate :typologies, to: :class
  delegate :name, to: :owner, prefix: true, allow_nil: true
  delegate :contact_name, to: :owner, prefix: true, allow_nil: true
  delegate :name, to: :manager, prefix: true
  delegate :name, to: :creator, prefix: true
  delegate :rent_amount, to: :active_contract, prefix: true, allow_nil: true

  has_one_attached :cover_photo
  has_many_attached :photos
  has_rich_text :description

  def owners_from_type
    return [] unless owner_type.present?

    owner_type&.constantize&.all || []
  end

  def parent_address
    owner&.address || owner&.organization&.address
  end

  def default_rent_full_cents
    (default_rent_cents || 0) + (default_charges_cents || 0)
  end

  def market_value_humanized
    return unless market_value_cents

    number_to_delimited(market_value_cents / 100, locale: :pt, delimiter: '')
  end

  def default_rent_humanized
    return unless default_rent_cents

    number_to_delimited(default_rent_cents / 100, locale: :pt, delimiter: '')
  end

  def default_charges_humanized
    return unless default_charges_cents

    number_to_delimited(default_charges_cents / 100, locale: :pt, delimiter: '')
  end

  def rented?
    active_contract.present?
  end

  def unavailabilities
    confirmed_contracts.pluck(:start_date, :end_date)
  end

  def available_on(from = Time.zone.today, to = from)
    confirmed_contracts.for(from, to).empty?
  end

  def notifiable_path
    property_path(self)
  end
end

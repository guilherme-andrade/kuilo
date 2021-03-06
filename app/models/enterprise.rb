# frozen_string_literal: true

class Enterprise < ApplicationRecord
  include HasProfile
  include HasComments
  include BelongsToOrganization

  belongs_to :creator, class_name: 'User'
  belongs_to :manager, class_name: 'User', optional: true

  has_one_attached :cover_photo
  has_many_attached :photos
  has_rich_text :description
  has_many :properties, dependent: :nullify

  counter_culture :organization
  counter_culture :manager, column_name: :managed_enterprises_count
  counter_culture :creator, column_name: :created_enterprises_count

  validates :name, presence: true, uniqueness: { scope: :organization_id }

  monetize :properties_market_value_sum_cents
  monetize :properties_default_rents_sum_cents

  delegate :name, to: :owner, prefix: true
  delegate :name, to: :manager, prefix: true
  delegate :name, to: :creator, prefix: true

  default :creator_id, (proc { |e| e&.organization&.owner_id })
  default :manager_id, (proc { |e| e&.creator_id })

  def properties_market_value_sum_cents
    properties.sum(:market_value_cents)
  end

  def properties_default_rents_sum_cents
    properties.sum(:default_rent_cents)
  end
end

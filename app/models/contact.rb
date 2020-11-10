# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :entity, polymorphic: true, autosave: false

  has_one_attached :avatar

  validates :email, :name, uniqueness: true, presence: true
  validates :vat_number, uniqueness: true, if: :vat_number
  validates :government_id, uniqueness: true, if: :vat_number
  validates :phone_number, uniqueness: { scope: %i[phone_country_code] }, presence: true
  validates :phone_country_code, presence: true

  before_validation :set_email

  default :name, (proc { |c| c.entity.name if c.entity.respond_to?(:name) && c.entity.name })

  def set_email
    return unless entity_type == 'User'

    self.email = entity.email
  end

  def phone
    "(+#{calling_country_code}) #{phone_number}"
  end

  def calling_country_code
    @calling_country_code ||= ISO3166::Country[phone_country_code]&.country_code
  end
end

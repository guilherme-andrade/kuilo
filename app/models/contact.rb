# frozen_string_literal: true

class Contact < ApplicationRecord
  include HasAddress

  belongs_to :entity, polymorphic: true, autosave: true

  has_one_attached :avatar

  validates :email, :name, uniqueness: true, presence: true
  validates :vat_number, uniqueness: true, if: :vat_number
  validates :government_id, uniqueness: true, if: :vat_number

  before_validation :set_email

  default :name, (proc { |c| c.entity.name if c.entity.respond_to?(:name) && c.entity.name })

  def set_email
    return unless entity_type == 'User'

    self.email = entity.email
  end

  def phone
    "(#{calling_country_code}) #{phone_number}"
  end

  def calling_country_code
    IsoCountryCodes.find(phone_country_code).calling
  end
end

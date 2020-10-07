# frozen_string_literal: true

class Contact < ApplicationRecord
  include HasAddress

  belongs_to :entity, polymorphic: true, autosave: true

  has_one_attached :avatar

  validates :name, presence: true
  validates :email, :phone_number, :name, uniqueness: true
  validates :vat_number, uniqueness: true, if: :vat_number
  validates :government_id, uniqueness: true, if: :vat_number

  def phone
    "(#{calling_country_code}) #{phone_number}"
  end

  def calling_country_code
    IsoCountryCodes.find(phone_country_code).calling
  end
end

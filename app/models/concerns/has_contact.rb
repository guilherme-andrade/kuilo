# frozen_string_literal: true

module HasContact
  extend ActiveSupport::Concern

  included do
    has_one :contact, as: :entity, dependent: :destroy
    accepts_nested_attributes_for :contact

    delegate :name, to: :contact, prefix: true, allow_nil: true
    delegate :vat_number, :government_id, :phone_number, :phone, :avatar,
             :phone_country_code, to: :contact, allow_nil: true

    delegate :email, to: :contact, prefix: true
  end
end

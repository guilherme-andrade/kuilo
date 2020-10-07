# frozen_string_literal: true

module HasContact
  extend ActiveSupport::Concern

  included do
    include HasAddress
    include HasBankAccounts

    has_one :contact, as: :entity, dependent: :destroy
    accepts_nested_attributes_for :contact

    delegate :name, to: :contact, prefix: true
    delegate :vat_number, :government_id, :phone_number, :phone, :email,
             :phone_country_code, to: :contact, allow_nil: true
  end
end

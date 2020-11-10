# frozen_string_literal: true

module HasProfile
  extend ActiveSupport::Concern

  included do
    include HasAddress, HasBankAccount, HasContact

    def build_profile
      build_contact
      build_address
      build_bank_account
    end

    def profile_complete?
      contact_name.present? && avatar.attached? && phone_number.present? && phone_country_code.present? &&
        vat_number.present?
    end
  end
end

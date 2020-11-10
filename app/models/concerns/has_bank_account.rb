# frozen_string_literal: true

module HasBankAccount
  extend ActiveSupport::Concern

  included do
    has_one :bank_account, as: :account_holder, dependent: :destroy, inverse_of: :account_holder, autosave: false

    accepts_nested_attributes_for :bank_account

    delegate :IBAN, :SWIFT, :name, :number, :bank_name, to: :bank_account, prefix: :account
  end
end

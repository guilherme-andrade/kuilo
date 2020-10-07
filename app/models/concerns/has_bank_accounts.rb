# frozen_string_literal: true

module HasBankAccounts
  extend ActiveSupport::Concern

  included do
    has_many :bank_accounts, as: :owner, dependent: :destroy
    has_one :primary_bank_account, -> { where(primary: true) }, class_name: 'BankAccount', as: :owner, dependent: :destroy

    accepts_nested_attributes_for :bank_accounts
    accepts_nested_attributes_for :primary_bank_account

    delegate :IBAN, :SWIFT, :name, :number, :bank_name, to: :primary_bank_account, prefix: :account
  end
end

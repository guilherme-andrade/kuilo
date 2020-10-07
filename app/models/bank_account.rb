class BankAccount < ApplicationRecord
  belongs_to :account_holder, polymorphic: true, inverse_of: :bank_accounts

  validates :IBAN, :SWIFT, :number, :name, :bank_name, presence: true
  validates :IBAN, :number, uniqueness: true
end

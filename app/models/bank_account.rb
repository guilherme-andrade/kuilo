class BankAccount < ApplicationRecord
  belongs_to :owner, polymorphic: true

  validates :IBAN, :SWIFT, :number, :name, :bank_name, presence: true
  validates :IBAN, :number, uniqueness: true
end

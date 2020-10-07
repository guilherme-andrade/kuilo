class Transaction < ApplicationRecord
  belongs_to :rent
  belongs_to :bank_account

  multi_tenant :organization

  before_validation :set_type

  def set_type
    amount_cents.negative? ? 'Transactions::Return' : 'Transactions::Payments'
  end
end

class Transaction < ApplicationRecord
  include BelongsToOrganization

  belongs_to :rent
  belongs_to :bank_account
  belongs_to :creator, inverse_of: :created_transactions
  before_validation :set_type

  def set_type
    amount_cents.negative? ? 'Transactions::Return' : 'Transactions::Payments'
  end
end

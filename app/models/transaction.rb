class Transaction < ApplicationRecord
  belongs_to :rent
  belongs_to :bank_account

  multi_tenant :organization
end

# frozen_string_literal: true

class Customer < ApplicationRecord
  include PropertyOwner, HasProfile, BelongsToOrganization

  belongs_to :creator, class_name: 'User'
  belongs_to :account_manager, class_name: 'User'

  has_many :contracts

  validates :name, presence: true, uniqueness: { scope: :organization_id }
end

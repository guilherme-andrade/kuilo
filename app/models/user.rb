# frozen_string_literal: true

class User < ApplicationRecord
  include HasProfile

  acts_as_target action_cable_allowed: true,
                 action_cable_with_devise: true,
                 email: :email,
                 email_allowed: :confirmed_at,
                 subscription_allowed: :confirmed_at,
                 batch_email_allowed: :confirmed_at

  devise :database_authenticatable, :trackable, :recoverable,
         :rememberable, :validatable, :invitable, :confirmable, :timeoutable

  has_many :owned_organizations, class_name: 'Organization', dependent: :destroy, foreign_key: :owner_id, inverse_of: :owner
  has_many :memberships, class_name: 'OrganizationMember', dependent: :destroy, inverse_of: :user
  has_many :organizations, through: :memberships, inverse_of: :members
  has_many :transactions, foreign_key: :creator_id

  accepts_nested_attributes_for :memberships

  validates :email, uniqueness: true

  alias name contact_name
end

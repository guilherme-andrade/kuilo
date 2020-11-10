# frozen_string_literal: true

class User < ApplicationRecord
  include HasProfile

  devise :database_authenticatable, :trackable, :recoverable, :rememberable,
         :validatable, :invitable, :confirmable, :timeoutable, invite_for: 2.weeks

  has_many :owned_organizations, class_name: 'Organization', dependent: :destroy, foreign_key: :owner_id, inverse_of: :owner
  has_many :memberships, class_name: 'OrganizationMember', dependent: :destroy, inverse_of: :user
  has_many :organizations, through: :memberships, inverse_of: :members
  has_many :transactions, foreign_key: :creator_id
  has_many :comments
  has_many :notifications, through: :memberships

  accepts_nested_attributes_for :memberships

  validates :email, uniqueness: true

  def name
    contact_name
  end
end

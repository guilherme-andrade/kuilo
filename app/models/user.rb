# frozen_string_literal: true

class User < ApplicationRecord
  include HasProfile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :trackable, :recoverable,
         :rememberable, :validatable, :invitable, :confirmable, :timeoutable

  has_many :owned_organizations, class_name: 'Organization', dependent: :destroy, foreign_key: :owner_id, inverse_of: :owner
  has_many :memberships, class_name: 'OrganizationMember', dependent: :destroy, inverse_of: :user
  has_many :organizations, through: :memberships, inverse_of: :members

  accepts_nested_attributes_for :memberships

  validates :email, uniqueness: true

  alias name contact_name
end

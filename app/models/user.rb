# frozen_string_literal: true

class User < ApplicationRecord
  include HasContact

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :recoverable,
         :rememberable, :validatable, :invitable, :confirmable, :timeoutable

  has_many :memberships, class_name: 'OrganizationMember'
  has_many :owned_organizations, class_name: 'Organization', dependent: :destroy, foreign_key: :owner_id
  has_many :organizations, through: :memberships

  accepts_nested_attributes_for :memberships

  alias name contact_name
end

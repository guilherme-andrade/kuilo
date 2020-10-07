# frozen_string_literal: true

class Organization < ApplicationRecord
  include HasAddress

  has_many :memberships, class_name: 'OrganizationMember', dependent: :destroy
  has_many :members, through: :memberships, class_name: 'User', source: :user
  has_many :enterprises, dependent: :destroy
  has_many :enterprised_properties, through: :enterprises, source: :properties
  has_many :customers
  has_many :properties
  has_many :contracts

  belongs_to :owner, class_name: 'User'

  accepts_nested_attributes_for :memberships

  counter_culture :owner, column_name: :owned_organizations_count

  after_validation :build_owner_membership, on: :create

  validates :name, presence: true, uniqueness: { case_insensitive: true }
  validates :slug, presence: true, uniqueness: { case_insensitive: true }

  has_one_attached :logo

  # Multi tenancy
  # after_create :create_tenant

  default :slug, (proc { |o| o.name.downcase.underscore })

  def build_owner_membership
    memberships.build(user: owner)
  end

  def invite_member(email:, role:, invited_by: owner, **attrs)
    User.invite!({
                   email: email,
                   contact_attributes: { name: name, **attrs },
                   memberships_attributes: [{ organization: self, role: role }]
                 }, invited_by)
  end

  # private

  # def create_tenant
  #   Apartment::Tenant.create(slug) if Apartment::Tenant.current == 'public'
  # end
end

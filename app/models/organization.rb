# frozen_string_literal: true

class Organization < ApplicationRecord
  include HasProfile

  has_many :memberships, class_name: 'OrganizationMember', dependent: :destroy, inverse_of: :organization
  has_many :members, through: :memberships, class_name: 'User', source: :user, inverse_of: :organizations
  has_many :enterprises, dependent: :destroy
  has_many :enterprised_properties, through: :enterprises, source: :properties

  has_many :customers, inverse_of: :organization
  has_many :properties, inverse_of: :organization
  has_many :contracts, inverse_of: :organization

  has_many :admin_memberships, -> { where(role: OrganizationMember.roles[:admin]) }, class_name: 'OrganizationMember'
  has_many :employee_memberships, -> { where(role: OrganizationMember.roles[:employee]) }, class_name: 'OrganizationMember'
  has_many :guest_memberships, -> { where(role: OrganizationMember.roles[:guest]) }, class_name: 'OrganizationMember'
  has_many :admins, through: :admin_memberships, source: :user, class_name: 'User'
  has_many :employees, through: :employee_memberships, source: :user, class_name: 'User'
  has_many :guests, through: :guest_memberships, source: :user, class_name: 'User'

  belongs_to :owner, class_name: 'User'

  accepts_nested_attributes_for :memberships

  counter_culture :owner, column_name: :owned_organizations_count

  after_validation :build_owner_membership, on: :create, if: -> { memberships.empty? }

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :slug, presence: true, uniqueness: { case_sensitive: false }

  has_one_attached :logo

  # Multi tenancy
  # after_create :create_tenant

  default :slug, (proc { |o| o&.name&.downcase&.underscore })

  delegate :name, to: :owner, prefix: true
  delegate :name, to: :admin, prefix: true

  def self.each_tenant(&blk)
    find_each do |org|
      MultiTenant.with(org) do
        blk.call(org)
      end
    end
  end

  def build_owner_membership
    memberships.build(user: owner, role: :admin)
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

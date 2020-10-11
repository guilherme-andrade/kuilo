# frozen_string_literal: true

class OrganizationMember < ApplicationRecord
  ROLES = { employee: 0, admin: 1, guest: 2 }.freeze

  by_role = send(:sanitize_sql_array, ['case role when \':admin\' then 0 else 1 end', ROLES])
  default_scope -> { order(by_role).order(created_at: :asc) }

  belongs_to :organization, inverse_of: :memberships
  belongs_to :user, inverse_of: :memberships

  counter_culture :organization, column_name: :members_count
  counter_culture :user, column_name: :memberships_count

  enum role: ROLES

  before_validation :set_owner_role, on: :create

  delegate :avatar, :name, :email, to: :user, prefix: true
  delegate :owner, :memberships, to: :organization, prefix: true

  validates :user_id, uniqueness: { scope: :organization_id }
  validates :organization_id, uniqueness: { scope: :user_id }

  validate :owner_is_admin

  def set_owner_role
    assign_attributes(role: :admin) if organization_owner == user
  end

  def owner_is_admin
    return unless organization_owner == user

    errors.add(:role, 'Cannot remove admin access from the organization owner.') if role.to_sym != :admin
  end

  def other_memberships
    organization_memberships - self
  end
end

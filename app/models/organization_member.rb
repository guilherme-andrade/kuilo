# frozen_string_literal: true

class OrganizationMember < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  counter_culture :organization, column_name: :members_count
  counter_culture :user, column_name: :memberships_count

  enum role: { employee: 0, admin: 1, guest: 2 }
end

module BelongsToOrganization
  extend ActiveSupport::Concern

  included do
    attr_accessor :being_changed_by

    multi_tenant :organization
    belongs_to :organization

    delegate :members, :name, to: :organization, prefix: true

    acts_as_notifiable :users,
                       targets: ->(r, _key) { r.organization_members.where.not(id: r.being_changed_by) },
                       action_cable_allowed: true,
                       action_cable_api_allowed: true,
                       tracked: { only: [:create] }

  end
end

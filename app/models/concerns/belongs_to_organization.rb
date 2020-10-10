module BelongsToOrganization
  extend ActiveSupport::Concern

  included do
    attr_accessor :being_changed_by

    multi_tenant :organization
    belongs_to :organization

    delegate :members, :name, to: :organization, prefix: true

    has_many :notifications, as: :notifiable, dependent: :nullify
  end
end

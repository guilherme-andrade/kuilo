# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  delegate :organization, to: :commentable
  delegate :members, to: :organization, prefix: true

  has_rich_text :content

  acts_as_notifiable :users,
                     targets: ->(c, _key) { c.organization_members },
                     action_cable_allowed: true,
                     action_cable_api_allowed: true,
                     notifiable_path: :commentable_path,
                     tracked: { only: [:create] }

  def commentable_path
    case commentable
    when Rent then rent_path(commentable)
    when Contract then contract_path(commentable)
    when Property then property_path(commentable)
    when Transaction then rent_path(commentable.rent)
    when Customer then customer_path(commentable)
    else
      commentable
    end
  end
end

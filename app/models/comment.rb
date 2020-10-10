# frozen_string_literal: true

class Comment < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  delegate :organization, to: :commentable
  delegate :members, to: :organization, prefix: true
  delegate :name, to: :user, prefix: true

  has_rich_text :content
  has_many :notifications, as: :notifiable, dependent: :nullify

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

  def mentions
    User.find(mentioned_user_ids)
  end
end

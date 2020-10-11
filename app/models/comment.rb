# frozen_string_literal: true

class Comment < ApplicationRecord
  include Kuilo::Application.routes.url_helpers

  default_scope -> { order(created_at: :desc) }
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  # should ideally migrate db to author_id
  alias author user

  delegate :organization, to: :commentable
  delegate :members, :admins, to: :organization, prefix: true
  delegate :name, to: :author, prefix: true
  delegate :name, to: :commentable, prefix: true

  has_rich_text :content
  has_many :notifications, as: :notifiable, dependent: :nullify

  def commentable_url
    case commentable
    when Rent then rents_url(q: { id_eq: commentable_id })
    when Contract then contract_path(commentable)
    when Property then property_path(commentable)
    when Transaction then rents_url(q: { id_eq: commentable_id })
    when Customer then customer_path(commentable)
    else url_for(commentable)
    end
  end

  def mentions
    User.where(id: mentioned_user_ids)
  end
end

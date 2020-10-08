# frozen_string_literal: true

module HasComments
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commentable
  end
end

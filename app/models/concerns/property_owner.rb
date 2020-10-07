# frozen_string_literal: true

module PropertyOwner
  extend ActiveSupport::Concern

  included do
    has_many :properties, as: :owner, dependent: :nullify
  end
end

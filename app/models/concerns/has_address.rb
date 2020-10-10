# frozen_string_literal: true

module HasAddress
  extend ActiveSupport::Concern

  included do
    has_one :address, as: :addressable, dependent: :destroy
    accepts_nested_attributes_for :address

    delegate :street, :country, :city, :zip_code, :latitude, :longitude, :door,
             :country_code, :floor, :full_address, :coordinates, to: :address
  end
end

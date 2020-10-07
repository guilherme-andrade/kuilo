# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true, autosave: true

  geocoded_by :full_address
  before_validation :geocode

  def full_address
    "#{street}, #{zip_code} - #{city} (#{state}), #{country}"
  end

  def coordinates
    { lat: latitude, lng: longitude }
  end

  def country
    IsoCountryCodes.find(country_code).name if country_code
  end

  def location_attributes
    attributes.slice('street', 'zip_code', 'city', 'state', 'country_code').symbolize_keys
  end
end

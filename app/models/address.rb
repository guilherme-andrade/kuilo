# frozen_string_literal: true

class Address < ApplicationRecord
  LOCATION_ATTRIBUTES = %i[street zip_code city country_code].freeze

  belongs_to :addressable, polymorphic: true, autosave: false

  geocoded_by :full_address
  before_validation :geocode

  validates(*LOCATION_ATTRIBUTES, presence: true)

  def full_address
    "#{street}, #{zip_code} - #{city}, #{country}"
  end

  def coordinates
    { lat: latitude, lng: longitude }
  end

  def country
    @country ||= ISO3166::Country[country_code].yield_self do |iso_country|
      iso_country&.translation(I18n.locale.to_s) || iso_country&.name
    end
  end

  def location_attributes
    attributes.slice(*LOCATION_ATTRIBUTES.map(&:to_s))
  end
end

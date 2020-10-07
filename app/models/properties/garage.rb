# frozen_string_literal: true

class Properties::Garage < Property
  TYPOLOGIES = %i[underground backyard].freeze
  CHARACTERISTICS = %i[storage_units_count storage_area_unit area_unit area_value].freeze

  enum typology: TYPOLOGIES
  store :characteristics, accessors: CHARACTERISTICS, coder: JSON
end

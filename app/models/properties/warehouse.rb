# frozen_string_literal: true

class Properties::Warehouse < Property
  TYPOLOGIES = %i[refrigerated storage_only].freeze
  CHARACTERISTICS = %i[area_unit area_value].freeze

  enum typology: TYPOLOGIES
  store :characteristics, accessors: CHARACTERISTICS, coder: JSON
end

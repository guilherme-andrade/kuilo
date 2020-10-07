# frozen_string_literal: true

class Properties::Room < Property
  TYPOLOGIES = %i[suite bedroom].freeze
  CHARACTERISTICS = %i[area_unit area_value].freeze

  enum typology: TYPOLOGIES
  store :characteristics, accessors: CHARACTERISTICS, coder: JSON
end

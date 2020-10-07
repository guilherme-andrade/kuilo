# frozen_string_literal: true

class Properties::Office < Property
  TYPOLOGIES = %i[shared private_space].freeze
  CHARACTERISTICS = %i[area_unit area_value wifi].freeze

  enum typology: TYPOLOGIES
  store :characteristics, accessors: CHARACTERISTICS, coder: JSON
end

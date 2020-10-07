# frozen_string_literal: true

class Properties::House < Property
  TYPOLOGIES = %i[penthouse street_side backyard_side ground_floor].freeze

  CHARACTERISTICS = %i[
    bedrooms_count bathrooms_count kitchen_count living_rooms_count balconies_count
    parking_spots_count storage_units_count storage_area_unit shared_gym shared_swimming_pool
    shared_garden shared_backyard shared_garage backyard_area_unit
    kitchen_area_unit living_area_unit bedrooms_area_unit
    area_unit area_value
  ].freeze

  enum typology: TYPOLOGIES
  store :characteristics, accessors: CHARACTERISTICS, coder: JSON
end

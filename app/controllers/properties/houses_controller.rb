# frozen_string_literal: true

class Properties::HousesController < PropertiesController
  def set_property_class
    @property_class = Properties::House
  end
end

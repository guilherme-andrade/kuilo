# frozen_string_literal: true

class Properties::GaragesController < PropertiesController
  def set_property_class
    @property_class = Properties::Garage
  end
end

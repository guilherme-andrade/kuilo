# frozen_string_literal: true

class Properties::RoomsController < PropertiesController
  def set_property_class
    @property_class = Properties::Room
  end
end

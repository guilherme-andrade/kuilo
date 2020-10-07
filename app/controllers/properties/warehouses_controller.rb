# frozen_string_literal: true

class Properties::WarehousesController < PropertiesController
  def set_property_class
    @property_class = Properties::Warehouse
  end
end

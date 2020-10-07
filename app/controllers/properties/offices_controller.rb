# frozen_string_literal: true

class Properties::OfficesController < PropertiesController
  def set_property_class
    @property_class = Properties::Office
  end
end

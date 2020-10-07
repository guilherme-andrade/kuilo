# frozen_string_literal: true

class Properties::ApartmentsController < PropertiesController
  def set_property_class
    @property_class = Properties::Apartment
  end
end

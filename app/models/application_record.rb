# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include Defaults
  self.abstract_class = true

  def perform_validations_on(*attributes)
    attributes.each do |attribute|
      self.class.validators_on(attribute).each do |validator|
        validator.validate_each(self, attribute, send(attribute))
      end
    end
  end
end

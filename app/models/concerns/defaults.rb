# frozen_string_literal: true

module Defaults
  extend ActiveSupport::Concern

  included do
    after_initialize :apply_default_values
  end

  def apply_default_values
    self.class.defaults.each do |attribute, param|
      next unless send(attribute).nil?

      value = param.respond_to?(:call) ? param.call(self) : param
      self[attribute] = value
    end
  end

  class_methods do
    def default(attribute, value = nil)
      defaults[attribute] = value
    end

    def defaults
      @defaults ||= {}
    end
  end
end

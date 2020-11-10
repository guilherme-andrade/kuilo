# frozen_string_literal: true

# IncludesModules
module IncludesModules
  def self.included(base)
    base.class_eval do
      extend ClassMethods
    end
  end

  # IncludesModules::ClassMethods
  module ClassMethods
    def modules(*module_names)
      module_names.each { |module_name| include module_name }
    end
  end
end

module ViewComponent::WithContext
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    attr_reader :context

    def initialize(context = {})
      @context = context
      _contextualize
    end

    private

    def _contextualize
      context.each do |key, value|
        instance_variable_set(:"@#{key}", value)
      end
    end
  end
end

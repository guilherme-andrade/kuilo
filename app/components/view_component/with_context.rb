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

    def render_with_context(component_class, additional_context = {}, &blk)
      render component_class.new(context.deeper_merge(additional_context)) { capture(&blk) }
    end

    private

    def _contextualize
      context.each do |key, value|
        instance_variable_set(:"@#{key}", value)
      end
    end
  end
end

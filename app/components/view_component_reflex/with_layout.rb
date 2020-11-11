module ViewComponentReflex::WithLayout
  def self.included(base)
    base.extend ClassMethods
  end

  def layout
    layout_component_class.new(layout_context)
  end

  def layout_key
    @layout_key ||= Digest::SHA2.hexdigest(self.class.name)
  end

  def layout_context
    {
      key: layout_key,
      page_reflex_attributes: component_reflex_attributes
    }
  end

  def layout_reflex_attributes
    {
      controller: layout_component_class.stimulus_controller,
      key: layout_key,
      class_name: layout_component
    }
  end

  def stimulate_layout(reflex, payload = {})
    stimulate([layout_component_class, reflex].join('#'), payload.merge({ key: layout_key }))
  end

  module ClassMethods
    def layout(component)
      define_method(:layout_component_class) { component }
    end
  end
end

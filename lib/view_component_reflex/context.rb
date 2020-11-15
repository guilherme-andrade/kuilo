class ViewComponentReflex::Context
  attr_reader :app_data_attributes, :page_data_attributes, :layout_data_attributes,
              :app_component_class, :layout_component_class, :page_component_class

  def initialize(app_component_class, layout_component_class, page_component_class)
    @app_component_class = app_component_class
    @layout_component_class = layout_component_class
    @page_component_class = page_component_class
    @app_data_attributes = _component_data_attributes(app_component_class) if app_component_class
    @page_data_attributes = _component_data_attributes(page_component_class) if page_component_class
    @layout_data_attributes = _component_data_attributes(layout_component_class) if layout_component_class
  end

  def valid?
    _inherits_from_context_component?(@app_component_class) &&
      _inherits_from_context_component?(@layout_component_class) &&
      _inherits_from_context_component?(@page_component_class)
  end

  def to_h
    instance_variables.each_with_object({}) do |variable, result|
      result[variable] = instance_variable_get(variable)
    end
  end

  def app_reflex_data_attributes(reflex)
    class_name, page_key = @app_data_attributes.values_at(:class_name, :key)

    action, method = reflex.to_s.split('->')

    if method.nil?
      method = action
      action = 'click'
    end

    { data: { reflex: "#{action}->#{class_name}##{method}", key: page_key } }
  end

  def page_reflex_data_attributes(reflex)
    class_name, page_key = @page_data_attributes.values_at(:class_name, :key)

    action, method = reflex.to_s.split('->')

    if method.nil?
      method = action
      action = 'click'
    end

    { data: { reflex: "#{action}->#{class_name}##{method}", key: page_key } }
  end

  def layout_reflex_data_attributes(reflex)
    class_name, page_key = @layout_data_attributes.values_at(:class_name, :key)

    action, method = reflex.to_s.split('->')

    if method.nil?
      method = action
      action = 'click'
    end

    { data: { reflex: "#{action}->#{class_name}##{method}", key: page_key } }
  end

  def stimulate_app_payload(reflex, payload)
    [[@app_component_class, reflex].join('#'), payload.merge(@app_data_attributes)]
  end

  def stimulate_page_payload(reflex, payload)
    [[@page_component_class, reflex].join('#'), payload.merge(@page_data_attributes)]
  end

  def stimulate_layout_payload(reflex, payload)
    [[@layout_component_class, reflex].join('#'), payload.merge(@layout_data_attributes)]
  end

  def add(extra_context)
    _contextualize(extra_context)
  end

  def remove(*variable_names)
    variable_names.each do |key|
      instance_variable_set(:"@#{key}", nil)
    end
  end

  private

  def _inherits_from_context_component?(component_class)
    base_component_class = ViewComponentReflex::ContextComponent::BaseComponent
    component_class&.ancestors&.include?(base_component_class)
  end

  def _component_data_attributes(component_class)
    {
      controller: component_class.stimulus_controller,
      key: component_class.key,
      class_name: component_class.name
    }
  end

  def _contextualize(variables)
    variables.each do |key, value|
      instance_variable_set(:"@#{key}", value)

      self.class.class_eval { attr_reader key }
    end
  end
end

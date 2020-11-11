class ReflexComponent < ViewComponentReflex::Component
  include ViewComponent::ViewHelpers

  def component_reflex_attributes
    init_key unless @key
    {
      controller: self.class.stimulus_controller,
      key: key,
      class_name: self.class.name
    }
  end

  def loader
    content_tag(:div, class: 'flexbox flexbox-center-center loader d-none', data: { loader: key } ) do
      content_tag(:span, '', class: 'loading')
    end
  end
end

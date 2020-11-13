class ReflexComponent < ViewComponentReflex::Component
  include ViewComponent::ViewHelpers
  include CableReady::Broadcaster

  def component_reflex_attributes
    init_key if @key.blank?
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

  def broadcast
    cable = cable_ready['StimulusReflex::Channel']
    yield(cable)
    cable_ready.broadcast
  end

  def init_key
    @key = Digest::SHA2.hexdigest(self.class.name)
  end
end

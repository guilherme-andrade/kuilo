class ViewComponentReflex::ContextComponent::BaseComponent < ViewComponentReflex::Component
  include ViewComponentReflex::ContextComponent::Helpers

  delegate :layout_context, :app_context, :page_context, to: :context, allow_nil: true

  def initialize(context = nil, additional_context = {})
    @context = context
    @additional_context = additional_context

    additional_context.each do |key, value|
      instance_variable_set(:"@#{key}", value)
    end
  end

  def render_with_context(component_class, additional_context = {}, &blk)
    render(component_class.new(context, additional_context)) { capture(&blk) if blk }
  end

  def context
    return @context if @context

    return session[context_session_key] if session_context_valid?

    session[context_session_key] = new_context
    @context = session[context_session_key]
  end

  def new_context
    ViewComponentReflex::Context.new(app_component_class, layout_component_class, page_component_class)
  end

  def session_context_valid?
    session[context_session_key]&.valid?
  end

  def context_session_key
    :view_component_reflex_context
  end

  def app_component_class
    session[context_session_key]&.app_component_class
  end

  def page_component_class
    session[context_session_key]&.page_component_class
  end

  def layout_component_class
    session[context_session_key]&.layout_component_class
  end

  def stimulate_layout(reflex, payload = {})
    stimulate(*session[context_session_key].stimulate_layout_payload(reflex, payload))
  end

  def stimulate_app(reflex, payload = {})
    stimulate(*session[context_session_key].stimulate_app_payload(reflex, payload))
  end

  def stimulate_page(reflex, payload = {})
    stimulate(*session[context_session_key].stimulate_page_payload(reflex, payload))
  end

  def key
    super
    @key = self.class.key
  end

  class << self
    def key
      @key = Digest::SHA256.hexdigest to_s
    end
  end
end

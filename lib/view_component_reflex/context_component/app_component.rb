class ViewComponentReflex::ContextComponent::AppComponent <ViewComponentReflex::ContextComponent::BaseComponent
  def page
    page_component_class.new(base_context)
  end

  def app_component_class
    self.class
  end

  def page_component_class
    routes[request.path]
  end

  def call
    render_layout_with_context do
      render_with_context(page_component_class)
    end
  end

  class << self
    def layout(component)
      define_method(:layout_component_class) { component }
      include [component.to_s, 'Methods'].join.safe_constantize
    end

    def routes(routes = {})
      define_method(:routes) { routes }
    end
  end
end

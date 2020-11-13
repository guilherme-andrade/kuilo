module ViewComponentReflex::WithRouter
  def self.included(base)
    base.extend ClassMethods
    base.include ViewComponentReflex::WithLayout
  end

  def page
    page_component.new(page_context)
  end

  def page_component
    routes[request.path]
  end

  def page_context
    layout_context
  end

  module ClassMethods
    def routes(routes = {})
      define_method(:routes) do
        routes
      end

      define_method(:call) do
        render(layout) { render(page) }
      end
    end
  end
end

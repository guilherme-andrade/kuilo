module ViewComponentReflex::Layout
  include ViewComponentReflex::LayoutComponent

  def component_controller(*args)
    super do
      yield(*args) && next unless @page_reflex_attributes

      content_tag(:div, data: @page_reflex_attributes) do
        yield(*args)
      end
    end
  end
end

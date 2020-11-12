class Application::SidepaneComponent < ReflexComponent
  include ViewComponent::WithContext
  include ViewComponentReflex::LayoutComponent

  with_content_areas :header, :footer

  def wrapper_class
    %w[sidepane].tap do |classes|
      classes << 'show' if show?
    end
  end

  def show?
    @show
  end
end

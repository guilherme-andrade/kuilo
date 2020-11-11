class Application::FlashesComponent < ReflexComponent
  include ViewComponent::WithContext

  def flash
    @flash || {}
  end
end

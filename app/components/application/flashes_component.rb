class Application::FlashesComponent < ApplicationComponent
  def flash
    @flash || {}
  end
end

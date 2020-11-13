class Application::SidepaneComponent < ReflexComponent
  include ViewComponentReflex::Layout

  with_content_areas :header, :footer

  def wrapper_class
    %w[sidepane].tap do |classes|
      classes << 'show' if show?
    end
  end

  def show?
    @content.present?
  end
end

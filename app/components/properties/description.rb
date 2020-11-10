class Properties::Description < ReflexComponent
  def initialize(property:)
    @property = property
    @editing = false
  end

  def toggle_edit
    @editing = !@editing
  end

  def update_description
    @editing = false if @property.update(description: params.dig(:property, :description))
  end
end

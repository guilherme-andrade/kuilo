class Enterprises::DescriptionComponent < ReflexComponent
  def initialize(enterprise:)
    @enterprise = enterprise
    @editing = false
  end

  def toggle_edit
    @editing = !@editing
  end

  def update_description
    @editing = false if @enterprise.update(description: params.dig(:enterprise, :description))
  end
end

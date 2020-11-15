class Properties::EditComponent < ApplicationComponent
  def initialize(*args)
    super(*args)
    @property = Property.find(@id)
  end

  def call
    render_with_context Properties::FormComponent, record: @property, current_user: current_user
  end
end

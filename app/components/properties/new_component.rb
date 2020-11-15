class Properties::NewComponent < ApplicationComponent
  def initialize(*args)
    super(args)
    @property = Property.new
  end

  def call
    render_with_context Properties::FormComponent, record: @property, current_user: current_user
  end
end

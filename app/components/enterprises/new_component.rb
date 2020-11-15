class Enterprises::NewComponent < ApplicationComponent
  def initialize(*args)
    super(args)
    @enterprise = Enterprise.new
  end

  def call
    render_with_context Enterprises::FormComponent, record: @enterprise, current_user: current_user
  end
end

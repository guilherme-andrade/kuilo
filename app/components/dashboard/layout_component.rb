class Dashboard::LayoutComponent < ReflexComponent
  include ViewComponentReflex::Layout

  with_content_areas :sidebar_extension, :modal, :flashes

  def extended?
    @extended
  end

  def dashboard_class
    %w[dashboard dashboard-horizontal].tap do |classes|
      classes << 'extended' if extended?
    end
  end

  def toggle_class
    %w[dashboard-aside-toggle].tap do |classes|
      classes << 'flip' if extended?
    end
  end

  def flashes
    Application::FlashesComponent.new(flash: @flash)
  end

  def sidebar
    Dashboard::SidebarComponent.new(@sidebar_context)
  end

  def sidebar_extension(&blk)
    content_tag(:div, class: 'dashboard-sidebar-extension') { @sidebar_extension }
  end
end

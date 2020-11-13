class Dashboard::LayoutComponent < ReflexComponent
  include ViewComponentReflex::Layout

  with_layout_areas sidebar_extension: Dashboard::SidebarExtensionComponent,
                    sidepane: Application::SidepaneComponent,
                    sidebar: Dashboard::SidebarComponent

  def dashboard_class
    %w[dashboard dashboard-horizontal].tap do |classes|
      classes << 'extended' if sidebar_extension_present?
    end
  end

  def toggle_class
    %w[dashboard-aside-toggle].tap do |classes|
      classes << 'flip' if sidebar_extension_present?
    end
  end

  def flashes
    Application::FlashesComponent.new(flash: @flash)
  end
end

class Dashboard::SidebarComponent < ReflexComponent
  def sidebar_link_to(path, icon_name = nil, **options, &blk)
    default_options = { class: 'dashboard-sidebar-link', data: { toggle: 'tooltip' }, title: options.delete(:tip) }

    active_link_to(path, combine_options(options, default_options)) do
      icon_name ? icon(icon_name) : blk.call
    end
  end
end

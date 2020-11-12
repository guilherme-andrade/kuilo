class Properties::SidebarExtensionComponent < ReflexComponent
  include Dashboard::Helpers
  include ViewComponent::WithContext
  include ViewComponentReflex::LayoutComponent

  def initialize(page_reflex_attributes:)
    @page_reflex_attributes = page_reflex_attributes
  end

  def enterprises
    @enterprises ||= Enterprise.includes(:cover_photo_attachment)
  end

  def enterprise_cards
    render Properties::SidebarExtension::EnterpriseComponent.with_collection(@enterprises)
  end

  def reflex_filter_tag(tag, filter_name, value, content = nil, options = {}, &blk)
    opts = blk ? content : options

    opts = opts.deeper_merge(data: { filter: filter_name, filter_name.to_sym => value })

    if blk
      reflex_tag(:filter, tag, **opts) { blk.call }
    else
      reflex_tag(:filter, tag, content, **opts)
    end
  end

  def filter
    class_name, page_key = @page_reflex_attributes.values_at(:class_name, :key)
    filter_name = element.dataset.filter
    filter_value = element.dataset.send(filter_name)

    stimulate([class_name, :filter].join('#'), { key: page_key, filter: filter_name, filter_name => filter_value })
  end
end

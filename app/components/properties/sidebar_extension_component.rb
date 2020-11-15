class Properties::SidebarExtensionComponent < ApplicationComponent
  include Dashboard::Helpers

  def enterprises
    @enterprises ||= Enterprise.includes(:cover_photo_attachment)
  end

  def reflex_filter_tag(tag, filter_name, value, content = nil, options = {}, &blk)
    opts = blk ? content : options

    opts = opts.deeper_merge(data: { filter: filter_name, filter_name.to_sym => value })

    if blk
      page_reflex_tag(:filter, tag, capture(&blk), **opts)
    else
      page_reflex_tag(:filter, tag, content, **opts)
    end
  end

  def filter
    class_name, page_key = @page_reflex_attributes.values_at(:class_name, :key)
    filter_name = element.dataset.filter
    filter_value = element.dataset.send(filter_name)

    stimulate([class_name, :filter].join('#'), { key: page_key, filter: filter_name, filter_name => filter_value })
  end
end

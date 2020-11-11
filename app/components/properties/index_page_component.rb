class Properties::IndexPageComponent < ReflexComponent
  include ApplicationHelper
  include ViewComponentReflex::WithLayout

  layout Dashboard::LayoutComponent

  STATUS_LABEL_COLORS = {
    available: 'bg-success',
    occupied: 'bg-danger',
    contract_confirmed: 'bg-warning',
    ooo: 'bg-muted'
  }.with_indifferent_access.freeze

  def before_render
    @properties = PropertiesFinder.find(query.merge(scope: Property.includes(:enterprise, :address))).records
  end

  def toggle_sidebar_extension
    @show_sidebar_extension = !@show_sidebar_extension
  end

  def sidebar_extension
    Properties::SidebarExtensionComponent.new(page_reflex_attributes: component_reflex_attributes)
  end

  def filter
    query[element.dataset.filter] = element.dataset.send(element.dataset.filter)
  end

  def properties
    @properties ||= []
  end

  def change_property_type
    query[:type] = element.dataset.type
  end

  def sort_properties
    query[:sort] = if query[:sort] == element.dataset.sort
                     element.dataset.sort.prepend('-')
                   else
                     element.dataset.sort
                   end
  end

  def search
    query[:search] = element.value
  end

  def change_page
    query[:pagination] = { page: element.dataset.page }
  end

  def query
    @query ||= {}
  end

  def layout_context
    super.merge(extended: @show_sidebar_extension)
  end

  def label_class_for_property(property)
    label_class_for_status(property.status)
  end

  def label_class_for_status(status)
    STATUS_LABEL_COLORS[status]
  end

  def label_for_property(property)
    class_name = label_class_for_property(property)
    text = I18n.t(['properties.status_labels.', property.status].join)

    content_tag(:span, text, class: ['badge', class_name])
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
end

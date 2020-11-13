module ViewComponentReflex::WithFilters
  def filter
    query[element.dataset.filter] = element.dataset.send(element.dataset.filter)
  end

  def change_property_type
    query[:type] = element.dataset.type
  end

  def sort
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

  def reflex_filter_tag(tag, filter_name, value, content = nil, options = {}, &blk)
    opts = blk ? content : options

    opts = opts.deeper_merge(data: { filter: filter_name, filter_name.to_sym => value })

    if blk
      reflex_tag(:filter, tag, capture(&blk), **opts)
    else
      reflex_tag(:filter, tag, content, **opts)
    end
  end
end

module ViewComponentReflex::ContextComponent::Helpers
  def page_reflex_tag(reflex, tag, content_or_options, options = {}, &blk)
    opts = if content_or_options.is_a? Hash
             combine_options(content_or_options, context.page_reflex_data_attributes(reflex))
           else
             combine_options(options, context.page_reflex_data_attributes(reflex))
           end
    content = content_or_options.is_a?(Hash) ? capture(&blk) : content_or_options

    content_tag(tag, content, opts, options)
  end

  def layout_reflex_tag(reflex, tag, content_or_options, options = {}, &blk)
    opts = if content_or_options.is_a? Hash
             combine_options(content_or_options, context.layout_reflex_data_attributes(reflex))
           else
             combine_options(options, context.layout_reflex_data_attributes(reflex))
           end
    content = content_or_options.is_a?(Hash) ? capture(&blk) : content_or_options

    content_tag(tag, content, opts, options)
  end

  def app_reflex_tag(reflex, tag, content_or_options, options = {}, &blk)
    opts = if content_or_options.is_a? Hash
             combine_options(content_or_options,  context.app_reflex_data_attributes(reflex))
           else
             combine_options(options, context.app_reflex_data_attributes(reflex))
           end
    content = content_or_options.is_a?(Hash) ? capture(&blk) : content_or_options

    content_tag(tag, content, opts, options)
  end

  def loader
    content_tag(:div, class: 'flexbox flexbox-center-center loader d-none', data: { loader: key } ) do
      content_tag(:span, '', class: 'loading')
    end
  end
end

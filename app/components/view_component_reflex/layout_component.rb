module ViewComponentReflex::LayoutComponent
  include ViewComponent::WithContext

  def page_reflex_tag(reflex, tag, content_or_options, options = {}, &blk)
    opts = if content_or_options.is_a? Hash
             combine_options(content_or_options, page_reflex_data_attributes(reflex))
           else
             combine_options(options, page_reflex_data_attributes(reflex))
           end
    content = content_or_options.is_a?(Hash) ? blk.call : content_or_options

    content_tag(tag, opts, options) { content }
  end

  def page_reflex_data_attributes(reflex)
    class_name, page_key = @page_reflex_attributes.values_at(:class_name, :key)

    action, method = reflex.to_s.split('->')

    if method.nil?
      method = action
      action = 'click'
    end

    { data: { reflex: "#{action}->#{class_name}##{method}", key: page_key } }
  end
end

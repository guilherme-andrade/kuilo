module Dashboard::Helpers
  def sidebar_extension_title(content = nil, icon_name = nil, options = {}, &blk)
    options.deeper_merge!(class: 'h5 d-flex align-items-center mb-3')

    content_tag(:h3, options) do
      [content || capture(&blk)].tap do |template|
        template << content_tag(:span, class: 'btn-round rounded btn-light mr-2') { icon(icon_name) } if icon_name
      end.reverse.join.html_safe
    end
  end

  def sidebar_extension_subtitle(content = nil, options = {}, &blk)
    options.deeper_merge!(class: 'small d-flex align-items-center pb-3 border-bottom')

    content_tag(:p, options) do
      content || capture(&blk)
    end
  end
end

module ViewComponentReflex::Form::FileInputs
  def file_input(attribute, **options)
    default_options = {
      data: input_reflex_data_attributes,
      accept: 'image/png,image/gif,image/jpeg'
    }

    if @record.send(attribute).attached?
      base64 = Base64.encode64(URI.open(record.send(attribute).blob.service_url).read)
      options.merge!(value: 'data:image/png;base64,' + base64)
    end

    content_tag :div, class: 'form-control border-dashed' do
      template = []
      template << file_field_tag(attribute, combine_options(default_options, options))
      template << image_tag(@record.send(attribute)) if @record.send(attribute).attached?
      template.join.html_safe
    end
  end
end

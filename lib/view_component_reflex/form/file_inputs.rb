module ViewComponentReflex::Form::FileInputs
  def file_input(attribute, **options)
    default_options = { data: file_input_reflex_data_attributes }
    file_input_options = {
      accept: 'image/png,image/gif,image/jpeg',
      data: { controller: 'file-input', action: 'change->file-input#changeHiddenInput' }
    }

    if @record.send(attribute).attached?
      base64 = Base64.encode64(URI.open(record.send(attribute).blob.service_url).read)
      value = 'data:image/png;base64,' + base64
    end

    combine_options(default_options, options)
    content_tag :div, class: 'form-control border-dashed' do
      template = []
      template << file_field_tag('', file_input_options)
      template << hidden_field_tag(_input_name_for(attribute), value, combine_options(default_options, options))
      template << image_tag(@record.send(attribute), class: 'w-100') if @record.send(attribute).attached?
      template.join.html_safe
    end
  end
end

class AttachmentsInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag(:div, wrapper_options.merge(class: 'p-4 rounded bg-light')) do
      @builder.file_field(attribute_name, input_options)
    end
  end
end

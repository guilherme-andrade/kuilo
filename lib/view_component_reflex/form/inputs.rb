module ViewComponentReflex::Form::Inputs
  def text_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    text_field_tag(_input_name_for(attribute), record.send(attribute), combine_options(default_options, options))
  end

  def number_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    number_field_tag(_input_name_for(attribute), record.send(attribute), combine_options(default_options, options))
  end

  def check_box(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }
    value = options.delete(:value)
    checked = record.send(attribute) == value

    check_box_tag(_input_name_for(attribute), record.send(attribute), checked, combine_options(default_options, options))
  end

  def color_input(attribute, **options)
    default_options = { class: %w[form-control form-control-color], data: input_reflex_data_attributes }

    color_field_tag(_input_name_for(attribute), record.send(attribute), combine_options(default_options, options))
  end

  def email_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    email_field_tag(_input_name_for(attribute), record.send(attribute), combine_options(default_options, options))
  end

  def password_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    password_field_tag(_input_name_for(attribute), record.send(attribute), combine_options(default_options, options))
  end

  def search_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    search_field_tag(_input_name_for(attribute), record.send(attribute), combine_options(default_options, options))
  end

  def url_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    url_field_tag(_input_name_for(attribute), record.send(attribute), combine_options(default_options, options))
  end

  def range_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    range_field_tag(_input_name_for(attribute), record.send(attribute), combine_options(default_options, options))
  end

  def radio_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    radio_field_tag(_input_name_for(attribute), record.send(attribute), combine_options(default_options, options))
  end

  def textarea_input(attribute, **options)
    default_options = { data: input_reflex_data_attributes, class: ['form-control'] }

    text_area_tag(_input_name_for(attribute), record.send(attribute), combine_options(default_options, options))
  end

  def rich_text_input(attribute, **options)
    options = options.symbolize_keys

    options[:input] ||= "trix_input_#{ActionText::TagHelper.id += 1}"
    options[:class] ||= 'trix-content'

    options[:data] ||= {}

    editor_tag = content_tag('trix-editor', '', combine_options(options, { class: ['form-control form-textarea'] }))
    input_tag = hidden_field_tag(_input_name_for(attribute), record.send(attribute), id: options[:input], data: input_reflex_data_attributes)

    input_tag + editor_tag
  end
end

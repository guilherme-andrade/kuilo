module ViewComponentReflex::Form::Inputs
  def text_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    text_field_tag(attribute, record.send(attribute), combine_options(default_options, options))
  end

  def number_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    number_field_tag(attribute, record.send(attribute), combine_options(default_options, options))
  end

  def check_box(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }
    value = options.delete(:value)
    checked = record.send(attribute) == value

    check_box_tag(attribute, record.send(attribute), checked, combine_options(default_options, options))
  end

  def color_input(attribute, **options)
    default_options = { class: %w[form-control form-control-color], data: input_reflex_data_attributes }

    color_field_tag(attribute, record.send(attribute), combine_options(default_options, options))
  end

  def email_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    email_field_tag(attribute, record.send(attribute), combine_options(default_options, options))
  end

  def password_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    password_field_tag(attribute, record.send(attribute), combine_options(default_options, options))
  end

  def search_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    search_field_tag(attribute, record.send(attribute), combine_options(default_options, options))
  end

  def url_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    url_field_tag(attribute, record.send(attribute), combine_options(default_options, options))
  end

  def range_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    range_field_tag(attribute, record.send(attribute), combine_options(default_options, options))
  end

  def radio_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    radio_field_tag(attribute, record.send(attribute), combine_options(default_options, options))
  end
end

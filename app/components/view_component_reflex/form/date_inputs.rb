module ViewComponentReflex::Form::DateInputs
  def day_select(attribute, **options)
    default_options = { class: ['form-select'], data: input_reflex_data_attributes, collection: (1..28) }

    select(attribute, combine_options(default_options, options))
  end

  def date_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes(controller: 'flatpickr') }

    date_field_tag(attribute, record.send(attribute), combine_options(default_options, options))
  end

  def month_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    month_field_tag(attribute, record.send(attribute), combine_options(default_options, options))
  end
end

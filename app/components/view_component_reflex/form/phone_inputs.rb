module ViewComponentReflex::Form::PhoneInputs
  def phone_input(attribute, **options)
    input_group(attribute: attribute, label: options.dig(:label)) do
      [
        phone_country_code_select([attribute, :country_code].join('_'), options.merge(style: 'width: 33%; flex-grow: 0;')),
        phone_number_input([attribute, :number].join('_'), options.deeper_merge(style: 'width: auto;', extend_existing_arrays: true))
      ].join.html_safe
    end
  end

  def phone_number_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    phone_field_tag(attribute, record.send(attribute), combine_options(default_options, options))
  end

  def phone_country_code_select(attribute, **options)
    default_options = {
      class: ['form-select'],
      data: input_reflex_data_attributes,
      collection: _phone_country_code_options,
      prompt: t('globals.select_one')
    }

    select(attribute, combine_options(default_options, options))
  end

  private

  def _phone_country_code_options
    label_method = ->(country_code) {
      country = ISO3166::Country[country_code]
      country_name = country.translation(I18n.locale.to_s)
      "#{country_name} (+#{country.country_code})"
    }
    ISO3166::Country.translations.keys.map do |country_code|
      code = country_code.downcase
      [code, code, { label: label_method.call(country_code) }]
    end
  end
end

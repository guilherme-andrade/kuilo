module ViewComponentReflex::Form::MoneyInputs
  def money_input(attribute, **options)
    input_group(attribute: attribute, label: options.dig(:label)) do
      [
        money_amount_input([attribute, :cents].join('_'), options),
        currency_select([attribute, :currency].join('_'), options)
      ].join.html_safe
    end
  end

  def money_amount_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes, step: '0.1' }
    number_field_tag(_input_name_for(attribute), record.send(attribute), combine_options(default_options, options))
  end

  def currency_select(attribute, **options)
    default_options = {
      class: ['form-select'],
      data: input_reflex_data_attributes,
      collection: _currency_options,
      prompt: t('globals.select_one')
    }

    select(attribute, combine_options(default_options, options))
  end

  private

  def _currency_options
    Money::Currency.table.values.map do |currency|
      # country = ISO3166::Country[country_code]
      # currency = Money::Currency.new(country.currency_code.upcase)
      [currency[:iso_code], currency[:iso_code], { label: "#{currency[:iso_code]} (#{currency[:name]})" }]
    end
  end
end

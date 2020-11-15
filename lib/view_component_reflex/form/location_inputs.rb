module ViewComponentReflex::Form::LocationInputs
  def country_code_select(attribute, **options)
    select_options = {
      include_blank: t('globals.select_a_country'),
      selected: @record.send(attribute)&.upcase
    }.merge(options.delete(:country_select_options) || {})

    default_options = { class: ['form-select'], data: input_reflex_data_attributes }

    country_select('', _input_name_for(attribute), select_options, combine_options(default_options, options))
  end

  def city_select(attribute, **options)
    if @record.country_code
      default_options = { collection: _city_options }
      select(attribute, combine_options(default_options, options))
    else
      text_input(attribute, options)
    end
  end

  def _city_options
    ISO3166::Country[@record.country_code].yield_self do |country|
      country.subdivisions.values.map { |city_hash| city_hash[:name] }
    end
  end
end

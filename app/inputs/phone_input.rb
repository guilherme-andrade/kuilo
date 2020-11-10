class PhoneInput < SimpleForm::Inputs::Base
  PHONE_COUNTRY_CODES = IsoCountryCodes.for_select.map do |(_, code)|
    country_name = I18n.t(['countries', code.downcase].join('.'))
    [
      IsoCountryCodes.find(code).calling.to_s,
      code,
      { label: "#{country_name} (#{IsoCountryCodes.find(code).calling})" }
    ]
  end

  def input(_wrapper_options)
    template.content_tag(:div, class: 'input-group') do
      @builder.input [attribute_name, :country_code].join('_'), as: :select, collection: PHONE_COUNTRY_CODES, label: false, wrapper: false, input_html: { class: 'w-25 form-select'}
      @builder.input [attribute_name, :number].join('_'), as: :tel, label: false, wrapper: false, placeholder: t('components.contacts.form.phone_placeholder')
    end
  end
end

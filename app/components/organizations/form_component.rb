class Organizations::FormComponent < ReflexComponent
  def initialize(organization:)
    @organization = organization
    @organization.build_address
    @organization.build_contact
    @organization.bank_accounts.new
  end

  def form_path
    @organization.persisted? ? organization_url(@organization) : url_for(controller: controller_name, action: :create)
  end

  def submit_copy
    @organization.persisted? ? 'Salvar mudanças' : 'Adicionar propriedade'
  end

  def phone_country_codes
    label_method = ->(code) { "#{IsoCountryCodes.find(code).name} (#{IsoCountryCodes.find(code).calling})"}
    value_method = ->(code) { IsoCountryCodes.find(code).calling }
    IsoCountryCodes.for_select.map do |(_, code)|
      [label_method.call(code), code, { label: value_method.call(code) }]
    end
  end

  def validate_name
    @organization.errors.clear
    @organization.name = element.value
    @organization.perform_validations_on(:name)
  end
end

class Organizations::FormComponent < ApplicationComponent
  def before_render
    @organization = current_organization
    @organization.build_address
    @organization.build_contact
    @organization.build_bank_account
  end

  def form_path
    @organization.persisted? ? current_organization_url(@organization) : organizations_url
  end

  def submit_copy
    @organization.persisted? ? 'Salvar mudanças' : 'Adicionar Organizacao'
  end

  def validate_name
    @organization.errors.clear
    @organization.name = element.value
    @organization.perform_validations_on(:name)
  end
end

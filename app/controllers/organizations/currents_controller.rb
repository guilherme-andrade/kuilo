class Organizations::CurrentsController < TenantController
  layout 'organizations/currents'

  before_action :select_organization!

  def show; end

  def update
    if current_organization.update(organization_params)
      redirect_to current_organization_path, notice: I18n.t('alerts.organization_updated')
    else
      redirect_to current_organization_path, alert: I18n.t('alerts.could_not_update_organization')
    end
  end

  def edit; end

  private

  def organization_params
    params.require(:organization).permit(
      :name, :logo, :default_rent_due_day, :default_rent_issuing_day,
      bank_accounts_attributes: %i[name number bank_name IBAN SWIFT],
      contact_attributes: %i[name vat_number government_id email phone_number phone_country_code],
      address_attributes: %i[street door floor city country_code zip_code]
    )
  end
end

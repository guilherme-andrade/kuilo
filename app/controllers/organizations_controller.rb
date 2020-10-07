# frozen_string_literal: true

class OrganizationsController < PrivateController
  def new
    @organization = current_user.owned_organizations.new
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.owner = current_user

    if @organization.save
      flash[:success] = 'Organization created!'
      session[:current_organization_id] = @organization.id
      redirect_to current_organization_path
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  private

  def organization_params
    params.require(:organization).permit(
      :name, :logo, :default_rent_due_day, :default_rent_issuing_day,
      bank_accounts_attributes: %i[name number bank_name IBAN SWIFT],
      contact_attributes: %i[name vat_number government_id email phone_number phone_country_code],
      address_attributes: %i[street door floor city country zip_code]
    )
  end
end

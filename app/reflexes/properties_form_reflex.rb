# frozen_string_literal: true

class PropertiesFormReflex < ApplicationReflex
  before_reflex do
    session[:property].assign_attributes = property_params
  end

  def update_owner_type
    @owners_options = session[:property].owners_from_type
    session[:property].owner_id = @owners_options.first.id
  end

  def update_owner_id
    session[:property].build_address
  end

  private

  def property_params
    params.require(:property).permit(
      :name, :code, :default_charges_cents, :default_charges_currency, :market_value_cents,
      :market_value_currency, :default_rent_cents, :default_rent_currency, :type, :typology,
      :photos, :description, :owner_id, :owner_type,
      address_attributes: %i[street door floor city country zip_code]
    )
  end
end

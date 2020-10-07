class Enterprises::PropertiesController < Enterprises::BaseController
  def new
    @property = Property.new
    @property.owner = @enterprise
    render 'properties/new'
  end

  def create
    @property = Property.new(property_params)
    @property.assign_attributes(creator: current_user, owner: @enterprise, manager: current_user, organization: current_organization)
    if @property.save
      redirect_to property_path(@property), success: 'Property successfully created'
    else
      render 'properties/new', error: 'Something went wrong'
    end
  end

  private

  def property_params
    params.require(:property).permit(
      :name, :code, :default_charges_cents, :default_charges_currency, :market_value_cents,
      :market_value_currency, :default_rent_cents, :default_rent_currency, :type, :typology,
      :default_invoice_description, :default_charges_description, :owner_id, :owner_type,
      :description, :cover_photo,
      photos: [],
      address_attributes: %i[street door floor city country zip_code]
    )
  end
end

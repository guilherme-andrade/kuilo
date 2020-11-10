# frozen_string_literal: true

class PropertiesController < TenantController
  before_action :set_property_class
  before_action :find_property, except: %i[index new create]

  def index
    @query = @property_class.ransack(params[:q])
    @properties = @query.result.paginate(page: params[:page], per_page: 7)
  end

  def show; end

  def new
    @property = Property.new
    @property.build_address
  end

  def edit; end

  def create
    @property = Property.new(property_params)
    @property.assign_attributes(creator: current_user, manager: current_user, organization: current_organization)
    if @property.save
      flash[:success] = 'Property successfully created'
      redirect_to property_path(@property)
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def update
    if @property.update(property_params)
      flash[:success] = 'Property was successfully updated'
      redirect_to property_path(@property)
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    if @property.destroy
      flash[:success] = 'Property was successfully deleted'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to properties_path
  end

  private

  def property_params
    params.require(:property).permit(
      :name, :code, :default_charges_cents, :default_charges_currency, :market_value_cents,
      :market_value_currency, :default_rent_cents, :default_rent_currency, :type, :typology,
      :default_invoice_description, :default_charges_description, :owner_id, :owner_type,
      :description, :cover_photo, :enterprise_id,
      photos: [],
      address_attributes: %i[street door floor city country_code zip_code]
    )
  end

  def find_property
    @property = Property.find(params[:id])
  end

  def set_property_class
    @property_class = Property
  end
end

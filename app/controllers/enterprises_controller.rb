# frozen_string_literal: true

class EnterprisesController < TenantController
  before_action :find_enterprise, except: %i[index new create]

  def index
    @query = Enterprise.includes(:address).ransack(params[:q])
    @enterprises = @query.result.paginate(page: params[:page], per_page: 7)
  end

  def show
    @query = @enterprise.properties.ransack(params[:q])
    @properties = @query.result.paginate(page: params[:page], per_page: 7)
  end

  def new
    @enterprise = Enterprise.new
    @enterprise.build_contact
    @enterprise.build_address
  end

  def edit; end

  def create
    @enterprise = Enterprise.new(enterprise_params)
    @enterprise.assign_attributes(manager: current_user, creator: current_user)
    if @enterprise.save
      flash[:success] = 'Enterprise successfully created'
      redirect_to @enterprise
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def update
    if @enterprise.update(enterprise_params)
      flash[:success] = 'Enterprise was successfully updated'
      redirect_to @enterprise
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    if @enterprise.destroy
      flash[:success] = 'Enterprise was successfully deleted'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to @enterprises_path
  end

  private

  def find_enterprise
    @enterprise = Enterprise.find(params[:id])
  end

  def enterprise_params
    params.require(:enterprise).permit(
      :name, :description, photos: [],
      address_attributes: %i[street door floor city country zip_code],
      contact_attributes: %i[name vat_number government_id email phone_number phone_country_code]
    )
  end
end

# frozen_string_literal: true

class EnterprisesController < OrganizationController
  before_action :find_enterprise, except: %i[index new create]

  def index
    @query = Enterprise.ransack(params[:q])
    @enterprises = @query.result.page(params[:page])
  end

  def show
    @query = @enterprise.properties.ransack(params[:q])
    @properties = @query.result.page(params[:page])
  end

  def new
    @enterprise = Enterprise.new
  end

  def edit; end

  def create
    @enterprise = Enterprise.new(params[:enterprise])
    if @enterprise.save
      flash[:success] = 'User successfully created'
      redirect_to @enterprise
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def update
    if @enterprise.update_attributes(params[:enterprise])
      flash[:success] = 'User was successfully updated'
      redirect_to @enterprise
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    if @enterprise.destroy
      flash[:success] = 'User was successfully deleted'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to @enterprises_path
  end

  private

  def find_enterprise
    @enterprise = Enterprise.find(params[:id])
  end
end

# frozen_string_literal: true

class OrganizationsController < PrivateController
  before_action :find_organization, except: %i[index new create]

  def index
    @organizations = Organization.all
  end

  def show; end

  def new
    @organization = Organization.new
  end

  def edit; end

  def create
    @organization = Organization.new(params[:organization])
    if @organization.save
      flash[:success] = 'User successfully created'
      redirect_to @organization
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def update
    if @organization.update_attributes(params[:organization])
      flash[:success] = 'User was successfully updated'
      redirect_to @organization
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    if @organization.destroy
      flash[:success] = 'User was successfully deleted'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to @organizations_path
  end

  private

  def find_organization
    @organization = Organization.find(params[:id])
  end
end

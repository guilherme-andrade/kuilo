# frozen_string_literal: true

class OrganizationMembersController < PrivateController
  before_action :find_organization_member, except: %i[index new create]

  def index
    @organization_members = OrganizationMember.all
  end

  def show; end

  def new
    @organization_member = OrganizationMember.new
  end

  def edit; end

  def create
    @organization_member = OrganizationMember.new(params[:organization_member])
    if @organization_member.save
      flash[:success] = 'User successfully created'
      redirect_to @organization_member
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def update
    if @organization_member.update_attributes(params[:organization_member])
      flash[:success] = 'User was successfully updated'
      redirect_to @organization_member
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    if @organization_member.destroy
      flash[:success] = 'User was successfully deleted'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to @organization_members_path
  end

  private

  def find_organization_member
    @organization_member = OrganizationMember.find(params[:id])
  end
end

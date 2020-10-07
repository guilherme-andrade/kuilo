class Organizations::CurrentsController < OrganizationController
  before_action :select_organization!

  def show
    @organization = current_organization
  end

  def update
    @organization = current_user.organizations.find_by_id(params[:id])
    if @organization
      session[:current_organization_id] = @organization.id
      redirect_to after_new_organization_session_path, success: "Iniciada sessão em #{@organization.name}!"
    else
      render :new, alert: 'Não foi possível iniciar sessão em organização'
    end
  end

  def destroy
  end
end

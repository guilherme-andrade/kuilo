class Organizations::SessionsController < OrganizationController
  skip_before_action :select_organization!

  def new
    @organizations = current_user.organizations
  end

  def create
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

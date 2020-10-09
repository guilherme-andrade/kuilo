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
    @organization = current_organization
    if session.delete(:current_organization_id) && session.delete(:current_organization)
      redirect_to new_organization_session_path, success: "Successfully logged out of #{@organization.name}!"
    else
      redirect_back fallback_location: session[:user_return_to], error: 'Could not log out.'
    end
  end
end

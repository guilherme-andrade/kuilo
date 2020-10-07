class OrganizationController < PrivateController
  before_action :select_organization!
  set_current_tenant_through_filter

  def select_organization!
    return if current_organization

    session[:user_return_to] = request.original_url

    if current_user.memberships.any?
      redirect_to new_organization_session_path, error: 'You need to select an organization before continuing.'
    else
      redirect_to new_organization_path, error: 'You don\'t have an organization created yet.'
    end
  end

  def current_organization
    current_user.organizations.find_by_id(session[:current_organization_id])
  end

  def set_customer_as_tenant
    set_current_tenant(current_organization)
  end

  def after_new_organization_session_path
    session[:user_return_to] || root_path
  end
end

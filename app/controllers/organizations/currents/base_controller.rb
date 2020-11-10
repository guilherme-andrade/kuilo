class Organizations::Currents::BaseController < TenantController
  layout 'organizations/currents'

  before_action :select_organization!
end

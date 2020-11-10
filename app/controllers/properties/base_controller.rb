class Properties::BaseController < TenantController
  before_action :find_property

  def find_property
    @property = current_organization.properties.find(params[:property_id])
  end
end

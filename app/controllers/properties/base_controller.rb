class Properties::BaseController < OrganizationController
  before_action :find_property

  def find_property
    @property = current_organization.properties.find(params[:property_id])
  end
end

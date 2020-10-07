class Enterprises::BaseController < OrganizationController
  before_action :find_enterprise

  private

  def find_enterprise
    @enterprise = Enterprise.find(params[:enterprise_id])
  end
end

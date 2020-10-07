class PrivateController < ApplicationController
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit

  def current_organization
    Organization.first
  end
end

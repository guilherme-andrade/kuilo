class PrivateController < ApplicationController
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit
  before_action :create_profile!

  def create_profile!
    return if current_user.profile_complete?

    redirect_to profile_path
  end
end

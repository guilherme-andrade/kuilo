class Organizations::Currents::MembersController < Organizations::Currents::BaseController
  def create

  end

  def index
  end

  def update
    if current_organization.me.update_attributes(params[:user])
      flash[:success] = 'Setting was successfully updated'
      redirect_to @settings
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy

  end
end

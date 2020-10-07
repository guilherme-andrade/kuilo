class ProfilesController < PrivateController
  skip_before_action :create_profile!

  def show
    current_user.build_profile
  end

  def update
    if current_user.update(profile_params)
      redirect_to authenticated_root_path, success: 'Profile updated!'
    else
      render :show, alert: 'Could not save profile'
    end
  end

  private

  def profile_params
    params.require(:user).permit(
      bank_accounts_attributes: %i[name number bank_name IBAN SWIFT],
      contact_attributes: %i[name avatar vat_number government_id email phone_number phone_country_code],
      address_attributes: %i[street door floor city country zip_code]
    )
  end
end

class ReflexComponent < ViewComponentReflex::Component
  include ApplicationHelper
  include Ransack::Helpers::FormHelper

  def current_organization
    session[:current_organization]
  end

  def current_user
    @current_user ||= User.find(session['warden.user.user.key'].first.first)
  end

  def current_user_id
    session['warden.user.user.key'].first.first
  end

  # here for action text to work
  def main_app
    Rails.application.class.routes.default_url_options[:host] = 'lvh.me:3000'
    Rails.application.class.routes.url_helpers
  end
end

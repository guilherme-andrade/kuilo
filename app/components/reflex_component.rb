require 'ransack/helpers'

class ReflexComponent < ViewComponentReflex::Component
  include Ransack::Helpers::FormHelper if defined? Ransack::Helpers
  include ApplicationHelper
  include ImageHelper

  def current_organization
    Organization.find_by_id(session[:current_organization_id])
  end

  def organization_selected?
    current_organization.present?
  end

  def user_signed_in?
    current_user.present?
  end

  def current_user
    User.find_by_id(session['warden.user.user.key']&.first&.first)
  end

  def current_user_id
    session['warden.user.user.key'].first.first
  end

  def flash(**flashes)
    return if flashes.empty?

    FlashRenderer.render(
      type: flashes.keys.first,
      content: flashes.values.first,
      to: current_user.id
    )
  end

  # here for action text to work
  def main_app
    Rails.application.class.routes.default_url_options[:host] = 'lvh.me:3000'
    Rails.application.class.routes.url_helpers
  end
end

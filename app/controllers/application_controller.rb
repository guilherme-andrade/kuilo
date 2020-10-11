# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include DeliverServerErrors

  helper ActionText::Engine.helpers

  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :organization_selected?, :current_organization

  def organization_selected?
    current_organization.present?
  end

  def current_organization
    false
  end

  def after_sign_in_path_for(user)
    super && return if user.organizations.empty?

    main_organization = if user.owned_organizations.any?
                          user.owned_organizations.first
                        else
                          user.organizations.first
                        end

    session[:current_organization_id] = main_organization.id
    properties_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [
                                        :email,
                                        memberships_attributes: %i[organization_id role],
                                        contact_attributes: %i[name]
                                      ])
  end
end

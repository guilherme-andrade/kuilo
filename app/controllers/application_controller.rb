# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper ActionText::Engine.helpers

  helper_method :organization_selected?, :current_organization

  def organization_selected?
    current_organization.present?
  end

  def current_organization
    false
  end
end

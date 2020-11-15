class Enterprises::FormComponent < ApplicationComponent
  include ViewComponentReflex::Form

  attr_reader :record

  alias enterprise record

  delegate :address, :contact, to: :enterprise, prefix: true, allow_nil: true

  # after_reflex :close_sidepane

  def after_save
    close_sidepane
    stimulate_page(:reload_properties)
  end

  def close_sidepane
    stimulate_app(:hide_sidepane)
  end

  def show_typology_input?
    enterprise.type.present?
  end

  def before_render
    enterprise.creator = current_user
    enterprise.organization = current_organization
    enterprise.build_address unless enterprise_address
    enterprise.build_contact unless enterprise_contact
  end
end

class Properties::FormComponent < ApplicationComponent
  include ViewComponentReflex::Form

  attr_reader :record

  alias property record

  delegate :address, to: :property, prefix: true, allow_nil: true

  # after_reflex :close_sidepane

  def after_save
    close_sidepane
    stimulate_page(:reload_properties)
  end

  def close_sidepane
    stimulate_app(:hide_sidepane)
  end

  def show_typology_input?
    property.type.present?
  end

  def before_render
    @owner_options = property.owners_from_type
    property.organization = current_organization
    property.owner = current_organization
    property.creator = current_user
    property.build_address unless property_address
  end

  def types_for_select
    property.class::TYPES.map { |type| [t("property.types.#{type.underscore}"), ['Properties', type].join('::')] }
  end

  def typologies_for_select
    property_class = property.type.safe_constantize
    return [] unless property_class

    property_class::TYPOLOGIES.map { |type| [t("property.types.#{type}"), type.to_s] }
  end
end

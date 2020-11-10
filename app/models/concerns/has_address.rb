# frozen_string_literal: true

module HasAddress
  extend ActiveSupport::Concern

  included do
    has_one :address, as: :addressable, dependent: :destroy, autosave: false
    accepts_nested_attributes_for :address

    delegate :street, :country, :city, :zip_code, :latitude, :longitude, :door,
             :country_code, :floor, :full_address, :coordinates, to: :address, allow_nil: true
  end

  class_methods do
    def inherit_address_from(*parent_address_names)
      define_method :address_attributes= do |attributes|
        parent_address_names.each do |name|
          parent_address = send(name).address if respond_to?(name, true) && send(name)&.address
          super(attributes) && break unless parent_address

          attributes = parent_address ? parent_address.location_attributes.merge(attributes) : attributes
          break super(attributes)
        end
      end
    end
  end
end

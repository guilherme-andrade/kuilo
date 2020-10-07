# frozen_string_literal: true

require 'faker'

@logger.debug '-- Adding Properties --'

file = File.read(Rails.root.join('db/seeds', 'data/properties.json'))
properties_params = JSON.parse(file)

properties_params.each do |property_params|
  photos_urls     = property_params.delete('photos_urls')
  cover_photo_url = property_params.delete('cover_photo_url')
  owner       = User.find_by_email(property_params.delete('organization_owner_email'))
  org         = owner.owned_organizations.find_by_name(property_params.delete('organization_name'))
  enterprise  = Enterprise.find_by_name(property_params.delete('enterprise_name'))
  creator     = User.find_by_email(property_params.delete('creator_email'))
  manager     = User.find_by_email(property_params.delete('manager_email'))
  property    = Property.create!(property_params.merge(creator: creator, manager: manager, enterprise: enterprise, organization: org))
  photos      = photos_urls.map { |url| URI.open(url) }
  cover_photo = URI.open(cover_photo_url)

  property.cover_photo.attach(io: cover_photo, filename: "#{property.name}_cover")
  photos.each_with_index { |photo, i| property.photos.attach(io: photo, filename: "#{property.name}_photo_#{1 + i}") }
end

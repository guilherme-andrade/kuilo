# frozen_string_literal: true

require 'faker'

@logger.debug '-- Adding Enterprises --'

file = File.read(Rails.root.join('db/seeds', 'data/enterprises.json'))
enterprises_params = JSON.parse(file)

enterprises_params.each do |enterprise_params|
  photos_urls     = enterprise_params.delete('photos_urls')
  cover_photo_url = enterprise_params.delete('cover_photo_url')
  owner           = User.find_by_email(enterprise_params.delete('organization_owner_email'))
  org             = owner.owned_organizations.find_by_name(enterprise_params.delete('organization_name'))
  creator         = User.find_by_email(enterprise_params.delete('creator_email'))
  enterprise      = org.enterprises.create!(enterprise_params.merge(creator: creator))
  photos          = photos_urls.map { |url| URI.open(url) }
  cover_photo     = URI.open(cover_photo_url)

  enterprise.cover_photo.attach(io: cover_photo, filename:  "#{enterprise.name}_cover")
  photos.each_with_index { |photo, i| enterprise.photos.attach(io: photo, filename: "#{enterprise.name}_photo_#{1 + i}") }
end

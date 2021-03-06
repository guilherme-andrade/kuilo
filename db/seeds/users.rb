# frozen_string_literal: true

require 'faker'

@logger.debug '-- Adding Users --'

file = File.read(Rails.root.join('db/seeds', 'data/users.json'))
users_params = JSON.parse(file)

users_params.each do |user_params|
  avatar_url  = user_params.delete('avatar_url')
  user        = User.new(user_params)
  user.skip_confirmation!
  user.save!

  avatar = URI.open(avatar_url)

  user.contact.avatar.attach(io: avatar, filename: "#{user.contact_name}_avatar")
end

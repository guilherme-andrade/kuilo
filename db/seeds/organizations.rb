# frozen_string_literal: true

require 'faker'

@logger.debug '-- Adding Organizations --'

file = File.read(Rails.root.join('db/seeds', 'data/organizations.json'))
organizations_params = JSON.parse(file)

organizations_params.each do |organization_params|
  members   = User.where(email: organization_params.delete('members_emails'))
  logo_url  = organization_params.delete('logo_url')
  logo      = URI.open(logo_url)

  org = User.find_by_email(organization_params.delete('owner_email')).yield_self do |owner|
    owner.owned_organizations.build(organization_params)
  end

  org.members = members
  org.logo.attach(io: logo, filename: "#{org.name}_logo")
  org.save!
end

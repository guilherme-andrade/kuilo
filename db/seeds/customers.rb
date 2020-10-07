# frozen_string_literal: true

require 'faker'

@logger.debug '-- Adding Customers --'

file = File.read(Rails.root.join('db/seeds', 'data/customers.json'))
customers_params = JSON.parse(file)

customers_params.each do |customer_params|
  owner               = User.find_by_email(customer_params.delete('organization_owner_email'))
  org                 = owner.organizations.find_by_name(customer_params.delete('organization_name'))
  creator             = User.find_by_email(customer_params.delete('creator_email'))
  account_manager     = User.find_by_email(customer_params.delete('account_manager_email'))

  org.customers.create!(customer_params.merge(creator: creator, account_manager: account_manager))
end

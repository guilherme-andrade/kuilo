# frozen_string_literal: true

require 'faker'

@logger.debug '-- Adding Contracts --'

file = File.read(Rails.root.join('db/seeds', 'data/contracts.json'))
contracts_params = JSON.parse(file)

contracts_params.each do |contract_params|
  owner       = User.find_by_email(contract_params.delete('organization_owner_email'))
  org         = owner.owned_organizations.find_by_name(contract_params.delete('organization_name'))
  property    = org.enterprised_properties.find_by_code(contract_params.delete('property_code'))
  customer    = Customer.find_by_name(contract_params.delete('customer_name'))

  contract = property.contracts.build(contract_params.merge(customer: customer, organization: org))
  contract.save!
end

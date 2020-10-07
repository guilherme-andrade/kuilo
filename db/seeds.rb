# frozen_string_literal: true

ENV['SEEDING'] = 'true'

# if ENV['SEEDING']
#   require 'email_interceptor'
#   ActionMailer::Base.register_interceptor(EmailInterceptor)
# end

# Rails.env = 'production'
seeds_dir = Rails.root.join('db/seeds')

@logger = Logger.new(STDOUT)
@logger.formatter = proc { |_severity, _time, _progname, msg| "#{msg}\n" }

@env = ENV['env'] || Rails.env

return if @env == 'test'

@logger.debug '**** ADDING DEMO DATA ****'

Contract.destroy_all
Customer.destroy_all
Organization.destroy_all
User.destroy_all

load seeds_dir.join('users.rb')
load seeds_dir.join('organizations.rb')
load seeds_dir.join('enterprises.rb')
load seeds_dir.join('customers.rb')
load seeds_dir.join('properties.rb')
load seeds_dir.join('contracts.rb')

@logger.debug '**** FINISHED SEEDING DATABASE ****'

# contract = Contract.create!(
#   customer: customer,
#   property: apartment,
#   start_date: Time.zone.today + 1.week,
#   end_date: Time.zone.today + 1.year,
#   taxation_type: 'retained',
#   invoicing_frequency_value: 1,
#   invoicing_frequency_unit: 'month'
# )

# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require 'view_component/engine'
require 'grover'
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kuilo
  class Application < Rails::Application
    config.generators do |generate|
      generate.helper false
      generate.assets false
      generate.view_specs false
      generate.orm :active_record, primary_key_type: :uuid
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.active_job.queue_adapter = :sidekiq

    config.middleware.use Grover::Middleware
    config.ignore_path = '/assets/'
    config.ignore_path = '/media/'

    config.i18n.default_locale = :pt
    config.i18n.available_locales = :pt

    config.active_record.observers = %i[
      contract_observer user_observer notifications_observer comment_observer
      rent_observer property_observer transaction_observer
    ]

    # Don't generate system test files.
    config.generators.system_tests = nil

  end
end

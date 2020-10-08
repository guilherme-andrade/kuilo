# frozen_string_literal: true

unless ENV['INTERCEPT_EMAILS'] == 'false'
  require 'email_interceptor'
  ActionMailer::Base.register_interceptor(EmailInterceptor)
end

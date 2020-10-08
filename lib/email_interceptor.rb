# frozen_string_literal: true

class EmailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = ENV['EMAIL_INTERCEPTOR_RECIPIENTS'].split(',')
  end
end

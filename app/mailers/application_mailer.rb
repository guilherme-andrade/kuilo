# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  prepend_view_path 'app/mailers/views'
  default from: "Guilherme Andrade <#{ENV['SENDGRID_SENDER_EMAIL']}>"
  layout 'mailer'

  before_action :add_logo_attachment

  add_template_helper(DateFormatHelper)

  private

  def add_logo_attachment
    logo = File.read(Rails.root.join('app/javascript/images/logo.png'))
    attachments.inline['logo.png'] = logo
  end
end

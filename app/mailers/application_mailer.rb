# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  prepend_view_path 'app/mailers/views'
  default from: 'Guilherme Andrade <please-reply@kuilo-pms.com>'
  layout 'mailer'

  before_action :add_logo_attachment

  add_template_helper(DateHelper)

  private

  def add_logo_attachment
    logo = File.read(Rails.root.join('app/javascript/images/logo.png'))
    attachments.inline['logo.png'] = logo
  end
end

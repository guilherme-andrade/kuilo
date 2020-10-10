require 'kramdown'

class Notification < ApplicationRecord
  include Noticed::Model

  belongs_to :recipient, polymorphic: true
  belongs_to :notifiable, polymorphic: true, optional: true

  def message
    params[:message] || 'no message available'
  end

  def message_html
    Kramdown::Document.new(message).to_html.html_safe
  end

  def url
    params[:url]
  end
end

require 'kramdown'

class Notification < ApplicationRecord
  include Noticed::Model
  include CableReady::Broadcaster

  belongs_to :recipient, polymorphic: true
  belongs_to :notifiable, polymorphic: true, optional: true

  after_commit :remove_signal, if: :saved_change_to_read_at?

  def message
    params[:message] || 'no message available'
  end

  def message_html
    Kramdown::Document.new(message).to_html.html_safe
  end

  def url
    params[:url]
  end

  def remove_signal
    return unless recipient.notifications.unread.empty?

    cable = cable_ready[recipient.id]
    cable.remove_css_class(selector: '#notifications-dropdown-toggle', name: %w[signal-notification])
    cable_ready.broadcast
  end
end

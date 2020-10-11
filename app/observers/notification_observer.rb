class NotificationObserver < ApplicationObserver
  attr_reader :notification
  alias notification record
  delegate :recipient, to: :notification
  delegate :notifications, to: :recipient, prefix: true

  def after_create(record)
    super
    add_signal_if_unread
  end

  def after_commit(record)
    super
    remove_signal_if_read
  end

  private

  def add_signal_if_unread
    return unless recipient_notifications.unread.any?

    broadcast_to(recipient.id) do |channel|
      channel.add_css_class(selector: '#notifications-dropdown-toggle', name: %w[signal-notification])
    end
  end

  def remove_signal_if_read
    return unless recipient_notifications.unread.empty?

    broadcast_to(recipient.id) do |channel|
      channel.remove_css_class(selector: '#notifications-dropdown-toggle', name: %w[signal-notification])
    end
  end
end
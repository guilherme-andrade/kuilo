class NotificationSubscriber < ApplicationSubscriber
  attr_reader :notification
  delegate :recipient, to: :notification
  delegate :notifications, to: :recipient, prefix: true

  def after_create(notification)
    @notification = notification
    add_signal_if_unread
    toast_the_user
  end

  def after_commit(notification)
    @notification = notification
    remove_signal_if_read
  end

  private

  def toast_the_user
    ToastRenderer.render(
      to: recipient.id,
      body: notification.message_html,
      title: I18n.t('notifications.new_notification'),
      type: 'success'
    )
  end

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

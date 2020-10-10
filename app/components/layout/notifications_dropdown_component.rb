class Layout::NotificationsDropdownComponent < ReflexComponent
  def notifications
    @notifications || []
  end

  def load_notifications
    @notifications = current_user.notifications.unread
    refresh! '#notifications-dropdown-menu-content'
  end

  def mark_as_read
    @notifications = current_user.notifications.unread
    @notifications.find(element.dataset.id).mark_as_read!
    @notifications.reload
  end
end

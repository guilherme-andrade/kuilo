class NotificationsReflex < ApplicationReflex
  def show
    @notifications = current_user.notifications.unread
    @show_notifications = true
  end

  def hide
    @show_notifications = false
  end

  def toggle
    @show_notifications = !@show_notifications
  end


  private

  def notifications_component
    Notifications::DropdownComponent.new
  end
end


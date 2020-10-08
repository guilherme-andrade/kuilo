# frozen_string_literal: true

class NotificationsReflex < ApplicationReflex
  def toggle_pane
    @show_notifications_pane = true
  end
end

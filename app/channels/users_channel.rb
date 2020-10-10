class UsersChannel < ApplicationCable::Channel
  def subscribed
    stream_from current_user.id
  end
end

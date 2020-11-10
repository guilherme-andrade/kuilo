module TriggersNotifications
  extend ActiveSupport::Concern

  included do
    subscribe NotifiableSubscriber.new
  end
end

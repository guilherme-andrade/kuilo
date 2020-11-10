# frozen_string_literal: true

# Subscribes
module SubscribedByListeners
  def self.included(base)
    base.extend ClassMethods
  end

  # Subscribes::ClassMethods
  module ClassMethods
    def inherited(subclass)
      super
      subclass.class_eval do
        subscribed_by_resource
      end
    end

    def subscribed_by_async(*listeners)
      listeners.each { |listener| subscribe(listener, async: true) }
    end

    def subscribed_by(*listeners)
      listeners.each { |listener| subscribe(listener) }
    end

    def subscribed_by_resource(subscriber_name = :subscriber)
      resource_subscriber = [to_s.underscore, subscriber_name].join('_').classify

      resource_subscriber.safe_constantize.tap do |subscriber_class|
        subscribe(subscriber_class.new) if subscriber_class
      end
    end
  end
end

class DeliveryMethods::PushNotification < Noticed::DeliveryMethods::Base
  include CableReady::Broadcaster

  def deliver
    cable_ready[recipient.id].tap do |cable|
      cable.notification(
        title: 'Actividade!',
        options: {
          body: options[:format][:message],
          vibrate: [200, 200, 200],
          silent: false
        }
      )
    end
    cable_ready.broadcast
  end
end

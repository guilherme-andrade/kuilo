class DeliveryMethods::CableReady < Noticed::DeliveryMethods::Base
  include CableReady::Broadcaster

  def deliver
    if options[:method] == :warn
      cable = cable_ready[recipient.id]
      cable.add_css_class(selector: '#notifications-dropdown-toggle', name: %w[signal-notification])
      cable_ready.broadcast
    end
  end
end

class ApplicationSubscriber
  include CableReady::Broadcaster

  attr_reader :record

  private

  def broadcast_to(stream, &blk)
    cable = cable_ready[stream]
    blk.call(cable)
    cable_ready.broadcast
  end

  def broadcast(&blk)
    broadcast_to('StimulusReflex::Channel', &blk)
  end
end

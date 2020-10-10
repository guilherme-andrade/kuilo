class ApplicationObserver < ActiveRecord::Observer
  include CableReady::Broadcaster

  def broadcast_to(stream, &blk)
    cable = cable_ready[stream]
    yield(cable)
    cable_ready.broadcast
  end

  def broadcast(&blk)
    broadcast_to('StimulusReflex::Channel', &blk)
  end
end

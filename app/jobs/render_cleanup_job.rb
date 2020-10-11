class RenderCleanupJob < ApplicationJob
  include CableReady::Broadcaster

  def perform(to:, id:)
    cable = cable_ready[to]
    cable.remove(selector: "##{id}")
    cable_ready.broadcast
  end
end

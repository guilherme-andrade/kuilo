class RenderJob < ApplicationJob
  include CableReady::Broadcaster

  def perform(to:, mutation:, mutation_payload:, id: nil, cleanup_after: nil)
    cable = cable_ready[to]
    cable.send(mutation, mutation_payload)
    cable_ready.broadcast

    RenderCleanupJob.set(wait: cleanup_after).perform_later(to: to, id: id) if cleanup_after
  end
end

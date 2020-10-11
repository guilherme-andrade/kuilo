class ApplicationRenderer
  include CableReady::Broadcaster
  include Interactor
  delegate :render, to: ApplicationController, prefix: :controller

  attr_reader :cable
  delegate :insert_adjacent_html, to: :cable
  delegate :async, to: :context, allow_nil: true

  class << self
    alias render call
  end

  def call
    context.async ||= true

    if async
      broadcast_later { render }
    else
      broadcast { render }
    end
  end

  def broadcast(&blk)
    @cable = cable_ready[stream]
    blk.call
    cable_ready.broadcast
  end

  def broadcast_later(&blk)
    RenderJob.perform_later(to: stream, **blk.call)
  end

  def stream
    context.to
  end
end

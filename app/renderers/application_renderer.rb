class ApplicationRenderer
  include CableReady::Broadcaster
  include Interactor
  delegate :render, to: ApplicationController, prefix: :controller
  delegate :wait, to: :context

  class << self
    alias render call
  end

  def call
    broadcast_later { render }
  end

  def broadcast_later(&blk)
    if wait
      RenderJob.set(wait: wait).perform_later(to: stream, **blk.call)
    else
      RenderJob.perform_later(to: stream, **blk.call)
    end
  end

  def stream
    context.to
  end
end

class ApplicationRenderer
  include CableReady::Broadcaster
  include Interactor
  delegate :render, to: ApplicationController, prefix: :controller

  attr_reader :cable
  delegate :insert_adjacent_html, to: :cable

  class << self
    alias render call
  end

  def call
    broadcast { render }
  end

  def broadcast(&blk)
    @cable = cable_ready[stream]
    blk.call
    cable_ready.broadcast
  end

  def stream
    context.to
  end
end

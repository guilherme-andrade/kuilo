class ApplicationObserver < ActiveRecord::Observer
  include CableReady::Broadcaster

  attr_reader :record

  def after_commit(record)
    @record = record
  end

  def after_save(record)
    @record = record
  end

  def after_create(record)
    @record = record
  end

  private

  def run_status_change_callbacks
    ActiveRecord::Base.transaction do
      on_status_change if record.saved_change_to_status?
    end
  end

  def broadcast_to(stream, &blk)
    cable = cable_ready[stream]
    yield(cable)
    cable_ready.broadcast
  end

  def broadcast(&blk)
    broadcast_to('StimulusReflex::Channel', &blk)
  end

  def status_callback_name
    "on_status_change_to_#{record.status}"
  end

  def on_status_change
    send(status_callback_name) if respond_to?(status_callback_name)
  end
end

class ApplicationComponent < ContextComponent
  include ViewComponent::ViewHelpers
  include CableReady::Broadcaster

  def broadcast
    cable = cable_ready['StimulusReflex::Channel']
    yield(cable)
    cable_ready.broadcast
  end

  def init_key
    @key = Digest::SHA2.hexdigest(self.class.name)
  end
end

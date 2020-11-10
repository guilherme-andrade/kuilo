# frozen_string_literal: true

class ApplicationReflex < StimulusReflex::Reflex
  delegate :render, to: :controller
  delegate :current_user, to: :connection
  delegate :insert_adjacent_html, to: :reflex_cable_ready

  def reflex_cable_ready
    cable_ready[channel.class.to_s]
  end

  def flash(**flashes)
    return if flashes.empty?

    FlashRenderer.render(
      type: flashes.keys.first,
      content: flashes.values.first,
      to: current_user.id
    )
  end

  def toast(**toasts)
    return if toasts.empty?

    ToastRenderer.render(
      type: toasts.keys.first,
      body: toasts.values.first,
      to: current_user.id
    )
  end
end

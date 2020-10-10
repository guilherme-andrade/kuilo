# frozen_string_literal: true

class ApplicationReflex < StimulusReflex::Reflex
  delegate :render, to: :controller
  delegate :current_user, to: :connection
  delegate :insert_adjacent_html, to: :reflex_cable_ready

  def reflex_cable_ready
    cable_ready[channel.class.to_s]
  end
end

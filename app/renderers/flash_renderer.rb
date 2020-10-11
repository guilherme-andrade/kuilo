class FlashRenderer < ApplicationRenderer
  delegate :content, :type, to: :context

  def render
    {
      mutation: :insert_adjacent_html,
      mutation_payload: { selector: '#flash-root', html: html }
    }
  end

  def html
    controller_render(partial: 'application/flashes', locals: locals)
  end

  def locals
    { flash: {} }.tap do |locals|
      locals[:flash][type.to_sym] = content
    end
  end
end

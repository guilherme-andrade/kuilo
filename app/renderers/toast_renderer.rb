class ToastRenderer < ApplicationRenderer
  Toast = Struct.new(:title, :body, :time_ago, :type, :id) do
    def success?
      type != 'error'
    end

    def error?
      type == 'error'
    end
  end

  delegate :title, :body, :type, to: :context

  def render
    {
      mutation: :insert_adjacent_html,
      mutation_payload: { selector: '#toast-root', html: html, position: 'afterbegin' }
    }
  end

  def html
    controller_render(partial: 'application/toasts', locals: locals)
  end

  def locals
    { toast: toast }
  end

  def toast
    @toast ||= Toast.new(title, body, I18n.t('globals.moments_ago'), type, SecureRandom.hex)
  end
end

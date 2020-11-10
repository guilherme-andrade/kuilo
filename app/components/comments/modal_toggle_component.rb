class Comments::ModalToggleComponent < ReflexComponent
  def initialize(commentable:, **options)
    @commentable = commentable
    @options = options
  end

  def color
    return 'light' if @commentable.comments.any?

    'default'
  end
end

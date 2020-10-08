class Comments::ModalToggleComponent < ReflexComponent
  def initialize(commentable:, **options)
    @commentable = commentable
    @options = options
  end
end

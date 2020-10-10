class Comments::ModalComponent < ReflexComponent
  include ImageHelper

  def initialize(commentable_type:, commentable_id:)
    @commentable_type = commentable_type
    @commentable_id = commentable_id
    @commentable = commentable_type.constantize.find(commentable_id)
    @comment = Comment.new
  end

  def organization_members
    current_organization.members
  end

  def comments
    @commentable.comments.includes(user: :contact)
  end

  def create_comment
    current_user.comments.create!(
      comment_params.merge(commentable_type: @commentable_type, commentable_id: @commentable_id)
    )
    @commentable = @commentable_type.constantize.find(@commentable_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, mentioned_user_ids: []).tap do |cp|
      cp[:mentioned_user_ids].delete_if(&:blank?)
    end
  end
end

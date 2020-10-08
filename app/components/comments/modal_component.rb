class Comments::ModalComponent < ReflexComponent
  include ImageHelper

  attr_reader :commentable

  def initialize(commentable:)
    @commentable = commentable
    @comment = Comment.new
    @comments = @commentable.comments.includes(user: :contact)
  end

  def organization_members
    current_organization.members
  end

  def create_comment
    Comment.create!(comment_params.merge(commentable: commentable, user_id: current_user_id))
    @comments = @commentable.comments.includes(user: :contact)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, mentioned_user_ids: []).tap do |cp|
      cp[:mentioned_user_ids].delete_if(&:blank?)
    end
  end
end

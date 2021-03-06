class Comments::ModalComponent < ApplicationComponent
  include ImageHelper

  def initialize(commentable_type:, commentable_id:)
    @commentable_type = commentable_type
    @commentable_id = commentable_id
    @commentable = commentable_type.constantize.find(commentable_id)
    @comment = Comment.new
  end

  def organization_members
    current_organization.members - [current_user]
  end

  def comments
    @commentable.comments.includes(user: :contact)
  end

  def create_comment
    attrs = comment_params.merge(commentable_type: @commentable_type, commentable_id: @commentable_id)
    if current_user.comments.create!(attrs)
      render_toast(success: 'Comentário adicionado')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, mentioned_user_ids: []).tap do |cp|
      cp[:mentioned_user_ids].delete_if(&:blank?)
    end
  end
end

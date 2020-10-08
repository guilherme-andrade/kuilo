# frozen_string_literal: true

class CommentsReflex < ApplicationReflex
  def toggle_modal
    @show_comments_modal = !@show_comments_modal
    find_commentable if @show_comments_modal
  end

  def close_modal
    @show_comments_modal = false
  end

  private

  def find_commentable
    commentable_type, commentable_id = element.dataset.to_h.values_at(:commentable_type, :commentable_id)
    @commentable = commentable_type.constantize.find(commentable_id)
  end
end

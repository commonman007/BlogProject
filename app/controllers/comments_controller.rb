# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      ActionCable.server.broadcast "comments_#{comment.blog_id}",
                                   message: comment.message,
                                   user: comment.user.name,
                                   time: comment.created_at.to_datetime.strftime('%Y %h %d %H:%m'),
                                   blog_id: comment.blog_id
      head :ok
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :blog_id)
  end
end

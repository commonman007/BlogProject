# frozen_string_literal: true

class CommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "comments_#{params[:blog_id]}"
  end
end

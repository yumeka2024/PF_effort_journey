class Admin::CommentsController < ApplicationController

  def index
    @comments = Comment.order(created_at: :desc).page(params[:page])
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to admin_post_comments_path
  end

end

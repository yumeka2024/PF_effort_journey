class Admin::CommentsController < ApplicationController

  def index
    @comments = Comment.page(params[:page]).order(created_at: :desc)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to admin_post_comments_path
  end

end

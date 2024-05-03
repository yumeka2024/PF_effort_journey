class Admin::CommentsController < ApplicationController

  def index
    @comments = Comment.order(created_at: :desc).page(params[:page])
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_back fallback_location: root_path
  end

end

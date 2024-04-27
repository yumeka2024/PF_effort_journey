class Admin::PostsController < ApplicationController

  def index
    @posts = Post.order(created_at: :desc).page(params[:page])
  end

  def show
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      redirect_to admin_posts_path
      return
    end
    @comments = @post.comments.page(params[:page])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

end

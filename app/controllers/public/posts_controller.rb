class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    post.save
    redirect_to root_path, notice_center: '投稿が完了しました'
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path, notice_center: '投稿を削除しました'
  end

  def confirm
    @post = Post.new(post_params)
  end

  private

  def post_params
    params.require(:post).permit(:posted_on, :body)
  end

end

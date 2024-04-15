class Public::PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:destroy]

  def new
    @post = Post.new
  end

  def show
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      redirect_to root_path
      return
    end
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    post.save
    redirect_to root_path, flash: { center_notice: '投稿が完了しました' }
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path, flash: { center_notice: '投稿を削除しました' }
  end

  def confirm
    @post = Post.new(post_params)
    if @post.posted_on.blank?||@post.body.blank?
      redirect_to new_post_path, flash: { center_notice: "設定されていない項目があります" }
    end
  end

  private

  def is_matching_login_user
    post = Post.find(params[:id])
    unless post.user_id == current_user.id
      redirect_to root_path
    end
  end

  def post_params
    params.require(:post).permit(:posted_on, :body)
  end

end

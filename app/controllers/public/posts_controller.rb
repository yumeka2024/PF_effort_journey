class Public::PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:destroy]

  def new
    @post = Post.new
    @user = current_user
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
    @day = Date.today
    @punches = current_user.punches.where(in: @day.all_day)
    @punch = Punch.new
  end

  def show
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      redirect_to root_path
      return
    end
    @user = @post.user
    @comment = Comment.new
    @comments = @post.comments.all
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
    @day = @post.posted_on
    @punches = current_user.punches.where(in: @day.all_day)
    @punch = Punch.new
    current_user.view_counts.create(post_id: @post.id)
  end

  def create
    post = current_user.posts.new(post_params)
    post.save
    redirect_to root_path, flash: { center_notice: '投稿が完了しました' }
  end

  def destroy
    post = Post.find_by(id: params[:id])
    if post.nil?
      redirect_to root_path
      return
    end
    post.destroy
    redirect_to user_path(current_user), flash: { center_notice: '投稿を削除しました' }
  end

  def confirm
    @post = Post.new(post_params)
    if @post.posted_on.blank?||@post.body.blank?
      redirect_to new_post_path, flash: { center_notice: "設定されていない項目があります" }
      return
    end
    @user = current_user
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
    @day = @post.posted_on
    @punches = current_user.punches.where(in: @day.all_day)
    @punch = Punch.new
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

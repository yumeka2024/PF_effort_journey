# app/controllers/public/homes_controller.rb
class Public::HomesController < ApplicationController

  def top
    @posts = Post.includes(user: { image_attachment: :blob }).where(users: { private: false }).page(params[:page]).per(5).order(created_at: :desc)
    if user_signed_in?
      @user = current_user
      @approved_followers = @user.followers.where('relationships.approved = ?', true)
      @approved_following = @user.followings.where('relationships.approved = ?', true)
      @follow_posts = Post.joins(user: { active_relationships: :follower }).where(relationships: { approved: true, follower_id: @user.id }).includes(user: { image_attachment: :blob }).page(params[:page]).per(5).order(created_at: :desc)
    end
  end

  def about
  end

end

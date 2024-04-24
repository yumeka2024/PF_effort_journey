# app/controllers/public/homes_controller.rb
class Public::HomesController < ApplicationController

  def top
    @posts = Post.includes(user: { image_attachment: :blob }).where(users: { private: false }).order(created_at: :desc).page(params[:page]).per(5)
    if user_signed_in?
      @user = current_user
      @approved_followers = @user.followers.where('relationships.approved = ?', true)
      @approved_following = @user.followings.where('relationships.approved = ?', true)
      @follow_posts = Post.joins(user: { active_relationships: :follower }).where(relationships: { approved: true, follower_id: @user.id }).includes(user: { image_attachment: :blob }).page(params[:page]).per(5).order(created_at: :desc)
    end
  end

  def favorites
    @posts = Post.includes(user: { image_attachment: :blob }).where(users: { private: false }).order(created_at: :desc).page(params[:page]).per(5)
    if user_signed_in?
      @user = current_user
      @approved_followers = @user.followers.where('relationships.approved = ?', true)
      @approved_following = @user.followings.where('relationships.approved = ?', true)
      @follow_posts = Post.joins(user: { active_relationships: :follower }).where(relationships: { approved: true, follower_id: @user.id }).includes(user: { image_attachment: :blob }).page(params[:page]).per(5).order(created_at: :desc)
    end
    @header_hidden = true
  end

  def follow
    @posts = Post.includes(user: { image_attachment: :blob }).where(users: { private: false }).order(created_at: :desc).page(params[:page]).per(5)
    @posts_day = @posts.beginning_of_day
    if user_signed_in?
      @user = current_user
      @approved_followers = @user.followers.where('relationships.approved = ?', true)
      @approved_following = @user.followings.where('relationships.approved = ?', true)
      @follow_posts = Post.joins(user: { active_relationships: :follower }).where(relationships: { approved: true, follower_id: @user.id }).includes(user: { image_attachment: :blob }).page(params[:page]).per(5).order(created_at: :desc)
    end
    @header_hidden = true
  end

  def about
  end

end

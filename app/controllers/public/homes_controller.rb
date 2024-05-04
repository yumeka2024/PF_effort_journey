# app/controllers/public/homes_controller.rb
class Public::HomesController < ApplicationController

  def top
    # @posts = Post.includes(user: { image_attachment: :blob }).where(users: { private: false }).page(params[:page]).per(5)
    # @posts = Post.includes(user: { image_attachment: :blob }).where(users: { private: false }).sorted_by_recommendation(current_user).page(params[:page]).per(5)
    # @posts = Kaminari.paginate_array(Post.includes(user: { image_attachment: :blob }).where(users: { private: false }).sorted_by_recommendation(current_user)).page(params[:page]).per(5)
    @posts = Kaminari.paginate_array(Post.includes(user: { image_attachment: :blob }).where(users: { private: false }).sorted_by_recommendation(current_user))
    if user_signed_in?
      @user = current_user
      @approved_followers = @user.followers.where('relationships.approved = ?', true)
      @approved_following = @user.followings.where('relationships.approved = ?', true)
    end
  end

  def followed
    @user = current_user
    @posts = Post.joins(user: { passive_relationships: :follower }).where(relationships: { approved: true, follower_id: @user.id }).includes(user: { image_attachment: :blob }).order(created_at: :desc).page(params[:page]).per(5)
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
  end

  def about
  end

  def notfound
    @user = current_user
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
  end

end

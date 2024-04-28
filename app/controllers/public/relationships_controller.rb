# app/controllers/public/relationships_controller.rb
class Public::RelationshipsController < ApplicationController

  def create
    @user = User.find_by(id: params[:user_custom_identifier])
    current_user.follow(@user)
  end

  def update
    @user = User.find_by(custom_identifier: params[:user_custom_identifier])
    current_user.approved(@user)
  end

  def destroy
    @user = User.find_by(id: params[:user_custom_identifier])
    current_user.unfollow(@user)
  end

  def followers
    @user = User.find_by(custom_identifier: params[:user_custom_identifier])
    if @user.nil?
      redirect_to notfound_path
      return
    end
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @pending_followers = @user.followers.where('relationships.approved = ?', false)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
    @approve_follow = true
  end

  def following
    @user = User.find_by(custom_identifier: params[:user_custom_identifier])
    if @user.nil?
      redirect_to notfound_path
      return
    end
    @approved_following = @user.followings.where('relationships.approved = ?', true)
    @pending_following = @user.followings.where('relationships.approved = ?', false)
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approve_follow = false
  end

end

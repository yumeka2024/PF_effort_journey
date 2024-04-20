# app/controllers/public/relationships_controller.rb
class Public::RelationshipsController < ApplicationController

  def create
    @user = User.find_by!(id: params[:user_custom_identifier])
    current_user.follow(@user)
    # redirect_to request.referer
  end

  def update
    @user = User.find_by!(custom_identifier: params[:user_custom_identifier])
    current_user.approved(@user)
    # redirect_to request.referer
  end

  def destroy
    @user = User.find_by!(id: params[:user_custom_identifier])
    current_user.unfollow(@user)
    # redirect_to  request.referer
  end

  def followers
    @user = User.find_by!(custom_identifier: params[:user_custom_identifier])
    if @user.nil?
      redirect_to root_path
      return
    end
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @pending_followers = @user.followers.where('relationships.approved = ?', false)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
  end

  def following
    @user = User.find_by!(custom_identifier: params[:user_custom_identifier])
    if @user.nil?
      redirect_to root_path
      return
    end
    @approved_following = @user.followings.where('relationships.approved = ?', true)
    @pending_following = @user.followings.where('relationships.approved = ?', false)
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
  end

end

class Public::RelationshipsController < ApplicationController

  def create
    user = User.find_by!(custom_identifier: params[:custom_identifier])
    current_user.follow(user)
    redirect_to request.referer
  end

  def update
    user = User.find_by!(custom_identifier: params[:custom_identifier])
    current_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    user = User.find_by!(custom_identifier: params[:custom_identifier])
    current_user.unfollow(user)
    redirect_to  request.referer
  end

  def followers
    user = User.find_by!(custom_identifier: params[:custom_identifier])
    if user.nil?
      redirect_to root_path
      return
    end
    @users = user.followers
    @user_identifier = User.find_by!(custom_identifier: params[:custom_identifier])
  end

  def following
    user = User.find_by!(custom_identifier: params[:custom_identifier])
    if user.nil?
      redirect_to root_path
      return
    end
    @users = user.followings
    @user_identifier = User.find_by!(custom_identifier: params[:custom_identifier])
  end

  private

  def relationship_params
    params.require(:relationship).permit(:approved)
  end

end

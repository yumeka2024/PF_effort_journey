class Public::HomesController < ApplicationController

  def top
    @posts = Post.includes(user: {image_attachment: :blob}).page(params[:page]).per(5).order(created_at: :desc)
    if user_signed_in?
      @user_identifier = User.find(current_user.id)
      @user = current_user
      @approved_followers = @user.followers.where('relationships.approved = ?', true)
      @approved_following = @user.followings.where('relationships.approved = ?', true)
    end
  end

  def about
  end

end

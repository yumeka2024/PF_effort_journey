class Public::HomesController < ApplicationController

  def top
    @posts = Post.includes(user: {image_attachment: :blob}).page(params[:page]).per(10).order(created_at: :desc)
    if user_signed_in?
      @user_identifier = User.find(current_user.id)
      @user = current_user
    end
  end

  def about
  end

end

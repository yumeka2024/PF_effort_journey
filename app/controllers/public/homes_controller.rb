class Public::HomesController < ApplicationController

  def top
    @posts = Post.includes(user: {image_attachment: :blob}).all
    if user_signed_in?
      @user_identifier = User.find(current_user.id)
      @user = current_user
    end
  end

  def about
  end

end

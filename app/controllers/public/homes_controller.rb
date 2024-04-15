class Public::HomesController < ApplicationController

  def top
    @posts = Post.includes(user: {image_attachment: :blob}).all
    @user_identifier = User.find(current_user.id)
    @user = current_user
  end

  def about
  end

end

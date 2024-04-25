class Admin::UsersController < ApplicationController

  def index
    @users = User.order(created_at: :desc).page(params[:page])
  end

  def show
    @user = User.find_by!(custom_identifier: params[:id])
    if @user.nil?
      redirect_to admin_users_path
      return
    end
    @posts = @user.posts.order(created_at: :desc).page(params[:page])
    @comments = @user.comments.order(created_at: :desc).page(params[:page])
    @likes = Post.joins(:likes).where(likes: { user_id: @user.id }).order(created_at: :desc).page(params[:page])
  end

  def update
    user = User.find_by!(custom_identifier: params[:id])
    if user.deleted == false
      user.update(deleted: true)
      redirect_to admin_user_custom_id_path(user)
      return
    else
      user.update(deleted: false)
      redirect_to admin_user_custom_id_path(user)
      return
    end
  end

end

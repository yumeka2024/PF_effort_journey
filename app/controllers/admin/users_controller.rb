class Admin::UsersController < ApplicationController

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find_by!(custom_identifier: params[:id])
    if @user.nil?
      redirect_to admin_users_path
      return
    end
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

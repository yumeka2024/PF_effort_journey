class Admin::UsersController < ApplicationController
  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to admin_users_path
      return
    end
  end
end

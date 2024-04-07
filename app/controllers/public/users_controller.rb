class Public::UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :withdraw ]

  def show
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_profile_edit_path
    else
      render :edit
    end
  end

  def confirm
  end

  def withdraw
    @user.update(deleted: true)
    reset_session
    flash[:center_notice] = "退会が完了いたしました"
    redirect_to root_path
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:custom_identifier, :name, :introduction, :birthday, :private, :email)
  end

end

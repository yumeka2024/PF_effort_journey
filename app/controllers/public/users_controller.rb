class Public::UsersController < ApplicationController
  def show
    @users = User.all
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
  @user = current_user
    if @user.update(user_params)
      redirect_to users_profile_edit
    else
      render :edit
    end
  end

  def confirm
  end

  def withdraw
    @user = current_user
    @user.update(deleted: false)
    reset_session
    flash[:center_notice] = "退会が完了いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:custom_identifier, :name, :introduction, :birthday, :private, :email)
  end

end

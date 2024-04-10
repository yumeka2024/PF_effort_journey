class Public::UsersController < ApplicationController

  def show
    @user = User.find_by!(custom_identifier: params[:custom_identifier])
    @posts = @user.posts.all
  end

  def edit
    @user = current_user
  end

  def update
  user = current_user
    if user.update(user_params)
      redirect_to users_profile_edit_path
    else
      render :edit
    end
  end

  def confirm
  end

  def withdraw
    user = current_user
    user.update(deleted: true)
    reset_session
    flash[:center_notice] = "退会が完了いたしました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:custom_identifier, :name, :introduction, :birthday, :private, :email)
  end

end

# app/controllers/public/users_controller.rb
class Public::UsersController < ApplicationController

  def show
    @user = User.find_by!(custom_identifier: params[:custom_identifier])
    if @user.nil?
      redirect_to root_path
      return
    end
    @user_identifier = User.find_by!(custom_identifier: params[:custom_identifier])
    @posts = @user.posts.all.includes(user: {image_attachment: :blob}).page(params[:page]).per(5).order(created_at: :desc)
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
  end

  def edit
    @user = current_user
    @user_identifier = User.find(current_user.id)
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, flash: { center_notice: '編集を保存しました' }
    else
      @user_identifier = User.find(current_user.id)
      render :edit
    end
  end

  def confirm
  end

  def deactivate
    user = current_user
    user.update(deleted: true)
    reset_session
    redirect_to root_path, flash: { center_notice: '退会が完了しました' }
  end

  private

  def user_params
    params.require(:user).permit(:custom_identifier, :name, :introduction, :birthday, :private, :email)
  end

end

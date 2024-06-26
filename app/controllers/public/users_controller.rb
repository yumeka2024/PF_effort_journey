# app/controllers/public/users_controller.rb
class Public::UsersController < ApplicationController

  def show
    @user = User.find_by(custom_identifier: params[:custom_identifier])
    if @user.nil? || @user.deleted == true
      redirect_to notfound_path
      return
    end

    if @user == current_user || @user.private == false || current_user.approved_following?(@user)
      @posts = @user.posts.with_user_image.order(created_at: :desc).page(params[:page]).per(5)
    end

    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
    @prev_punch = current_user.punches.find_by(out_time: nil)
  end

  def edit
    @user = current_user
    @user_identifier = User.find(current_user.id)
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
    @prev_punch = current_user.punches.find_by(out_time: nil)
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, flash: { success: '編集を保存しました' }
    else
      @user_identifier = User.find(current_user.id)
      @approved_followers = @user.followers.where('relationships.approved = ?', true)
      @approved_following = @user.followings.where('relationships.approved = ?', true)
      @prev_punch = current_user.punches.find_by(out_time: nil)
      render :edit
    end
  end

  def confirm
  end

  def likes
    @user = User.find_by(custom_identifier: params[:user_custom_identifier])
    if @user.nil?
      redirect_to notfound_path
      return
    end
    @posts = Post.with_user_image.joins(:likes).where(likes: { user_id: @user.id }).includes(user: { image_attachment: :blob }).order('likes.created_at DESC').page(params[:page]).per(5)
    @approved_followers = @user.approved_followings
    @approved_following = @user.approved_followers
    @prev_punch = current_user.punches.find_by(out_time: nil)
  end

  def deactivate
    user = current_user
    user.update(deleted: true, private: true)
    NoticeMailer.farewell(user).deliver_now

    reset_session
    redirect_to root_path, flash: { info: '退会が完了しました' }
  end

  private

  def user_params
    params.require(:user).permit(:custom_identifier, :name, :introduction, :birthday, :private, :email, :image)
  end

end

# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_user, only: [:create]

  # GET /resource/sign_in
  def new
    @posts = Post.includes(user: { image_attachment: :blob }).where(users: { private: false }).order(created_at: :desc).page(params[:page]).per(5)
    super
  end

  def guest_sign_in
    user = User.find_by(custom_identifier: "guest")
    sign_in user
    redirect_to root_path, flash: { center_notice: 'guestでログインしました' }
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def reject_user
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.deleted == true)
        redirect_to new_user_session_path
      end
    end
  end

end

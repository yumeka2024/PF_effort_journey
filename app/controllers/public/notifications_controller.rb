# app/controllers/punlic/notification_controller.rb
class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications.order(created_at: :desc).page(params[:page]).per(3)
    render json: @notifications

    @user = current_user
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
  end

  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    head :ok
  end

end

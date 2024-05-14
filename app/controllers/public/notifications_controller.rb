class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications.order(created_at: :desc).page(params[:page]).per(10)
  end

  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: false)
    redirect_to notification.notifiable_path
  end

end

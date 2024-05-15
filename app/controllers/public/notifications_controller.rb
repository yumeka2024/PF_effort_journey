# app/controllers/punlic/notification_controller.rb
class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications.order(created_at: :desc).page(params[:page]).per(10)
    # render json: @notifications

    @user = current_user
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)

    respond_to do |format|
      # リクエストされるフォーマットがHTML形式の場合
      format.html{ render :index, format: :html }

      # リクエストされるフォーマットがJSON形式の場合
      format.json{ render json: @notifications}
      # @usersをjson形式のデータへ変換して返す
    end

  end

  def update
    notifications = current_user.notifications.where(id: params[:id].split(","))
    notifications.update_all(read: true)
    #unless notification.update(read: true)
    #  notification.errors.full_message.each do | msg |
    #    pp msg
    #  end
    #end
    head :ok
  end

end

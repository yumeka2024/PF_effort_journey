# app/models/notification.rb
class Notification < ApplicationRecord

  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  def message(current_user)
    notifiable.notification_message(current_user)
  end

  def notifiable_path(current_user)
    notifiable.notification_path(current_user)
  end



end

# app/models/notification.rb
class Notification < ApplicationRecord

  belongs_to :user
  belongs_to :notifiable, polymorphic: true
  # belongs_to :sender, class_name: "User"

  enum message: 
  { get_followed: 0, get_follow_request: 1, follow_request_approved: 2, get_like: 3, get_comment: 4 }

  def message(current_user)
    notifiable.notification_message(current_user)
  end

  def notifiable_path(current_user)
    notifiable.notification_path(current_user)
  end



end

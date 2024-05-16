# app/models/notification.rb
class Notification < ApplicationRecord

  belongs_to :user
  belongs_to :sender, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  enum message:
  { get_followed: 0, get_follow_request: 1, follow_request_approved: 2, get_like: 3, get_comment: 4 }

  def notifiable_message
    "#{sender.name}#{message_i18n}"
  end

  def notifiable_icon
    if get_followed? || get_follow_request? || follow_request_approved?
      if read?
        "<i class='fa-solid fa-user fa-xl' style='color: #5b7a5f;'></i>"
      else
        "<i class='fa-solid fa-user fa-xl' style='color: #74C0FC;'></i>"
      end
    elsif get_like?
      if read?
        "<i class='fa-solid fa-heart fa-xl' style='color: #5b7a5f;'></i>"
      else
        "<i class='fa-solid fa-heart fa-xl' style='color: #ca579c;'></i>"
      end
    elsif get_comment?
      if read?
        "<i class='fa-solid fa-comment fa-xl' style='color: #5b7a5f;'></i></i>"
      else
        "<i class='fa-solid fa-comment fa-xl' style='color: #63E6BE;'></i></i>"
      end
    end
  end

  def notifiable_path
    if get_followed? || get_follow_request?
      user_followers_path(sender.custom_identifier)
    elsif follow_request_approved?
      user_following_path(sender.custom_identifier)
    else
      user_path(sender.user)
    end
  end

end

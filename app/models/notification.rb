# app/models/notification.rb
class Notification < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :sender, class_name: "User"
  belongs_to :notifiable, polymorphic: true, optional: true

  validates :message, presence: true

  enum message:
  { get_followed: 0, get_follow_request: 1, follow_request_approved: 2, get_like: 3, get_comment: 4 }

  def notifiable_message
    if sender.deleted?
      "退会済みのユーザー#{message_i18n}"
    else
      "#{sender.name}#{message_i18n}"
    end
  end

  def notifiable_icon
    if get_followed? || get_follow_request? || follow_request_approved?
      if read?
        "<i class='fa-solid fa-user fa-xl' style='color: #5b7a5f;'></i>".html_safe
      else
        "<i class='fa-solid fa-user fa-xl' style='color: #74C0FC;'></i>".html_safe
      end
    elsif get_like?
      if read?
        "<i class='fa-solid fa-heart fa-xl' style='color: #5b7a5f;'></i>".html_safe
      else
        "<i class='fa-solid fa-heart fa-xl' style='color: #ca579c;'></i>".html_safe
      end
    elsif get_comment?
      if read?
        "<i class='fa-solid fa-comment fa-xl' style='color: #5b7a5f;'></i></i>".html_safe
      else
        "<i class='fa-solid fa-comment fa-xl' style='color: #63E6BE;'></i></i>".html_safe
      end
    end
  end

  def notifiable_path
    if get_followed? || get_follow_request?
      user_followers_path(user)
    elsif follow_request_approved?
      user_following_path(user)
    else
      user_path(sender)
    end
  end

end

# app/models/relationship.rb
class Relationship < ApplicationRecord
  include Notifiable

  # followerがfollowedをフォローしている
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  has_many :notifications, as: :notifiable, dependent: :nullify

  validates :follower_id, uniqueness: { scope: :followed_id }

  def notification_needed?
    true
  end

  def notification_message_type
    approved? ? :get_followed : :get_follow_request
  end

  def notification_user_id
    followed_id
  end

  def notification_post
    nil
  end

  def notification_sender
    follower
  end

  after_commit :create_notification_on_update, on: :update, if: :approved_changed_to_true?

  private

  def approved_changed_to_true?
    saved_change_to_attribute?(:approved) && approved?
  end

  def create_notification_on_update
    create_notification(:get_follow_approval)
  end


  # relationshipsレコードが作成されたらnotificationsレコードを作成する
  # after_commit :create_notification_on_create, on: :create
  # after_commit on: :create do
    # if approved
    #   Rails.logger.debug("Notification creation: Relationship approved")
    #   notifications.create(user_id: followed_id, post: nil, sender: follower, message: 0)
    # else
    #   Rails.logger.debug("Notification creation: Relationship not approved")
    #   notifications.create(user_id: followed_id, post: nil, sender: follower, message: 1)
    # end
  # end

  # relationshipレコードのapprovedカラムがfalseからtrueに更新されたらnotificationレコードを作成する
  # after_commit on: :update do
  #   if saved_change_to_attribute?(:approved) && approved?
  #     Rails.logger.debug("Notification creation: Relationship approval updated")
  #     notifications.create(user_id: follower_id, post: nil, sender_id: followed_id, message: 2)
  #   end
  # end

  # private

  # def create_notification_on_create
  #   if approved?
  #     create_notification(:get_followed)
  #   else
  #     create_notification(:get_follow_request)
  #   end
  # end

  # def create_notification(message_type)
  #   Notification.create(
  #     user_id: followed_id,
  #     post: nil,
  #     sender: follower,
  #     message: message_type
  #   )
  # end

end

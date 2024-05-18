# app/models/relationship.rb
class Relationship < ApplicationRecord
  include Notifiable

  # followerがfollowedをフォローしている
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  has_many :notifications, as: :notifiable, dependent: :nullify

  validates :follower_id, uniqueness: { scope: :followed_id }

  # relationshipレコードのapprovedカラムがfalseからtrueに更新されたらnotificationレコードを作成する
  after_commit on: :update, if: -> { saved_change_to_attribute?(:approved) && approved? } do
    Notification.create(
      user_id: follower_id,
      post: nil,
      sender_id: followed_id,
      message: 2
    )
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

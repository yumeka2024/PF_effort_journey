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

end

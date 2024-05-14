# app/models/relationship.rb
class Relationship < ApplicationRecord

  # followerがfollowedをフォローしている
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :follower_id, uniqueness: { scope: :followed_id }

  # relationshipsレコードが作成されたらnotificationsレコードを作成する
  after_create do
    notifications.create(user_id: followed_id)
  end

  # relationshipレコードのapprovedカラムがfalseからtrueに更新されたらnotificationレコードを作成する
  after_update do
    if saved_change_to_attribute?(:approved) && approved?
      notifications.create(user_id: follower_id)
    end
  end

  # このメソッドは特定のnotificationレコードに対して使用される
  def notification_message(current_user)
    if followed_id == current_user.id
      if approved?
        "#{follower.name}さんが　あなたを　フォロー　しました"
      else
        "#{follower.name}さんが　あなたに　フォローリクエストを送りました"
      end
    else
      "#{followed.name}さんが　あなたのフォローリクエストを　承認しました"
    end
  end

  # このメソッドは特定のnotificationレコードに対して使用される
  def notification_path
    user = User.find_by(id: follower_id)
    user ? "/users/#{user.custom_identifier}" : "#"
  end

end

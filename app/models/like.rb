# app/models/like.rb
class Like < ApplicationRecord
  # include Notifiable

  belongs_to :user
  belongs_to :post
  has_one :notification, as: :notifiable, dependent: :nullify

  validates :user_id, uniqueness: {scope: :post_id}

  after_create do
    create_notification(user_id: post.user_id, sender_id: id, message: 3)
  end

  # def notification_message(current_user)
  #   "#{user.name}さんが　あなたの投稿に　いいね　しました"
  # end

  # def notification_path(current_user)
  #   user_path(user)
  # end

end

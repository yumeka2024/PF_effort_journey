class Comment < ApplicationRecord
  # include Notifiable

  belongs_to :user
  belongs_to :post
  has_one :notification, as: :notifiable, dependent: :nullify

  validates :body, presence: true

  after_create do
    create_notification(user_id: post.user_id, post_id: post_id, sender_id: user_id, message: 4)
  end

  # def notification_message(current_user)
  #   "#{user.name}さんが　あなたの投稿に　コメント　しました"
  # end

  # def notification_path(current_user)
  #   user_path(user)
  # end

end

class Like < ApplicationRecord
  include Notifiable

  belongs_to :user
  belongs_to :post
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :user_id, uniqueness: {scope: :post_id}

  after_create do
    create_notification(user_id: post.user_id)
  end

  def notification_message
    "投稿した#{post.body.truncate(30)}が#{user.name}さんにいいねされました"
  end

  def notification_path
    user_path(user)
  end

end

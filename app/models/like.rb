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
    "#{user.name}さんが　あなたの投稿に　いいね　しました"
  end

  def notification_path
    user_path(user)
  end

end

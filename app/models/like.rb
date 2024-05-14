class Like < ApplicationRecord

  belongs_to :user
  belongs_to :post
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :user_id, uniqueness: {scope: :post_id}

  after_create do
    create_notification(user_id: post.user_id)
  end

  def notification_message
    "#{user.name}さんに、投稿した#{post.posted_on.strftime('%-Y年%-m月%-d日')}の振り返りがいいねされました"
  end

  def notification_path
    user_path(user)
  end

end

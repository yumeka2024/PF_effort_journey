class Comment < ApplicationRecord
  include Notifiable

  belongs_to :user
  belongs_to :post
  has_one :notification, as: :notifiable, dependent: :nullify

  validates :body, presence: true

  # after_commit on: :create do
  #   create_notification(user_id: post.user_id, post_id: post_id, sender_id: user_id, message: 4)
  # end

  def notification_needed?
    true
  end

  def notification_message_type
    4
  end

  def notification_user_id
    post.user_id
  end

  def notification_post
    post
  end

  def notification_sender
    user
  end

end

# app/models/like.rb
class Like < ApplicationRecord
  include Notifiable

  belongs_to :user
  belongs_to :post
  has_one :notification, as: :notifiable, dependent: :nullify

  validates :user_id, uniqueness: {scope: :post_id}

  # after_commit on: :create do
  #   create_notification(user_id: post.user_id, post_id: post_id, sender_id: user_id, message: 3)
  # end

end

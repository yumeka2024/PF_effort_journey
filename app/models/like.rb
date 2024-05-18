# app/models/like.rb
class Like < ApplicationRecord
  include Notifiable

  belongs_to :user
  belongs_to :post
  has_one :notification, as: :notifiable, dependent: :nullify

  validates :user_id, uniqueness: {scope: :post_id}

end

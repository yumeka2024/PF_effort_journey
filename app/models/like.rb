class Like < ApplicationRecord

  belongs_to :user
  belongs_to :poset

  validates :user_id, uniqueness: {scope: :post_id}

end

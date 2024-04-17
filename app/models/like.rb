class Like < ApplicationRecord

  belongs_to :user, optional:true
  belongs_to :poset, optional:true

  validates :user_id, uniqueness: {scope: :post_id}

end

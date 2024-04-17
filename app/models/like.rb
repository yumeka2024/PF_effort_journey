class Like < ApplicationRecord

  belongs_to :user, optional:true
  belongs_to :poset, optional:true

end

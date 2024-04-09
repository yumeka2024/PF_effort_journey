class Post < ApplicationRecord

  belongs_to :user, optional:true

  validates :posted_on, presence: true
  validates :body, presence: true

end

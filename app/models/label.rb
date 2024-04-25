class Label < ApplicationRecord

  belongs_to :user, optional:true
  has_many :punches, dependent: :destroy

  validates :genre, presence: true
  validates :name, presence: true

  enum genre: { study: 0, exercise: 1, hobby: 2, other: 3 }

end

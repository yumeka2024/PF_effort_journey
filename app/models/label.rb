class Label < ApplicationRecord

  belongs_to :user, optional:true
  has_many :punches, dependent: :destroy

end

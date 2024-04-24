class Punch < ApplicationRecord

  belongs_to :user, optional:true
  belongs_to :label, optional:true
  has_many :punch_logs, dependent: :destroy

end

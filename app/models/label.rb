# app/models/label.rb
class Label < ApplicationRecord

  belongs_to :user
  has_many :punches, dependent: :destroy

  validates :genre, presence: true
  validates :name, presence: true, length: { maximum: 20 }

  enum genre: { study: 0, exercise: 1, hobby: 2, other: 3 }

  def label_display
    genre_i18n + ' ' + name
  end

end

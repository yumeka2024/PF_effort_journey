# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  has_many :posts, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  validates :custom_identifier, presence: true, uniqueness: true, length: { maximum: 20 },
    format: { with: /\A[a-zA-Z0-9]+\z/, message: "は英数字のみで設定してください" }

  def to_param
    custom_identifier
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end

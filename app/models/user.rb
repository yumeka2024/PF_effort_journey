class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 30 }
  validates :custom_identifier, presence: true, uniqueness: true, length: { maximum: 20 },
    format: { with: /\A[a-zA-Z0-9]+\z/, message: "は英数字のみで設定してください" }

end

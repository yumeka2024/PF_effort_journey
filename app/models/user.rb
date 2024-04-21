# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# アソシエーション
  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

# バリデーション
  validates :name, presence: true, length: { maximum: 30 }
  validates :custom_identifier, presence: true, uniqueness: true, length: { maximum: 20 },
    format: { with: /\A[a-zA-Z0-9]+\z/, message: "は英数字のみで設定してください" }

# メソッド等
  # URLに組み込まれるデータをカラム名で指定
  def to_param
    custom_identifier
  end

  # 画像表示（リサイズ）、画像がない場合の処理
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  # フォローする（非公開ならばフォロリクを送る）
  def follow(user)
    if user.private == true
      active_relationships.create(followed_id: user.id, approved: false)
    else
      active_relationships.create(followed_id: user.id, approved: true)
    end
  end

  # フォロリクを承認する
  def approved(user)
    passive_relationships.find_by(follower_id: user.id).update(approved: true)
  end

  # フォローを解除する（フォロリクを拒否する）
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  # フォローしているか判定
  def following?(user)
    active_relationships.exists?(followed_id: user.id)
  end

  # フォローされているか判定
  def followed?(user)
    passive_relationships.exists?(follower_id: user.id)
  end

end

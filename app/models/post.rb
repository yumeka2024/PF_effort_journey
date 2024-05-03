# app/models/post.rb
class Post < ApplicationRecord

# アソシエーション
  belongs_to :user, optional:true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :view_counts, dependent: :destroy

# バリデーション
  validates :posted_on, presence: true
  validates :body, presence: true

# メソッド等
  # いいねされているか確認する
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  # 直近7レコードの平均感情スコアを算出する
  # scoreカラムがnilのレコードが含まれていた場合、nilは0として計算に含まれる仕様
  def self.average_recent_score
    recent_posts = order(created_at: :desc).limit(7)
    recent_posts.average(:score).to_f
  end

  # 上記の平均感情スコアを元に、評価を返す
  def self.score_evaluation
    average_score = average_recent_score

    case average_score
    when 0.5..1.0
      '絶好調ですね！その調子！'
    when 0.0...0.5    #0.5を含まない
      '頑張っていますね！すごい！'
    when -0.5...0.0   #0.0を含まない
      '今が踏ん張り時！ファイト！'
    when -1.0...-0.5  #-0.5を含まない
      '息抜きが必要かも…無理しないで！'
    else
      '投稿からスコアが計算できません'
    end
  end

end

# app/models/post.rb
class Post < ApplicationRecord

# アソシエーション
  belongs_to :user
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
      "絶好調ですね！\nその調子！"
    when 0.0...0.5    #0.5を含まない
      "頑張っていますね！\nすごい！"
    when -0.5...0.0   #0.0を含まない
      "今が踏ん張り時！\nファイト！"
    when -1.0...-0.5  #-0.5を含まない
      "息抜きが必要かも…\n無理しないで！"
    else
      "投稿からスコアが\n計算できません"
    end
  end

  # 作成日の降順、作成日が同じ場合はスコア降順、どちらも同じ場合は作成日時降順で並び替える
  def self.sorted_by_recommendation
    order(Arel.sql("DATE(created_at) DESC, score DESC, created_at DESC"))
    
  end

end

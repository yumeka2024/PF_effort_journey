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

  # おすすめタイムラインを形成する
  def self.sorted_by_recommendation(user_average_recent_score)
    within_weeks = Post.includes(user: { image_attachment: :blob }).where(users: { private: false }).where(posted_on: 2.weeks.ago..Time.now)
    outside_weeks = Post.includes(user: { image_attachment: :blob }).where(users: { private: false }).where.not(posted_on: 2.weeks.ago..Time.now)

    within_weeks_with_score_range = within_weeks.where("score>= ? and score <= ?", user_average_recent_score - 0.2, user_average_recent_score + 0.2).order("RANDOM()")
    within_weeks_without_score_range = within_weeks.where.not("score>= ? and score <= ?", user_average_recent_score - 0.2, user_average_recent_score + 0.2).order("RANDOM()")
    outside_weeks_with_score_range = outside_weeks.where("score>= ? and score <= ?", user_average_recent_score - 0.2, user_average_recent_score + 0.2).order("RANDOM()")
    outside_weeks_without_score_range = outside_weeks.where.not("score>= ? and score <= ?", user_average_recent_score - 0.2, user_average_recent_score + 0.2).order("RANDOM()")

    all_posts = within_weeks_with_score_range + within_weeks_without_score_range +  outside_weeks_with_score_range +  outside_weeks_without_score_range
  end

end

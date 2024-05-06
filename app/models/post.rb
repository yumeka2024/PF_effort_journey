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

  # # 直近7レコードの平均感情スコアを算出する
  # # scoreカラムがnilのレコードが含まれていた場合、nilは0として計算に含まれる仕様
  # def average_recent_score
  #   recent_posts = user.posts.order(created_at: :desc).limit(7)
  #   recent_posts.average(:score).to_f
  # end

  # # 上記の平均感情スコアを元に、評価を返す
  # def score_evaluation
  #   average_score = average_recent_score

  #   case average_score
  #   when 0.5..1.0
  #     "絶好調ですね！\nその調子！"
  #   when 0.0...0.5    #0.5を含まない
  #     "頑張っていますね！\nすごい！"
  #   when -0.5...0.0   #0.0を含まない
  #     "今が踏ん張り時！\nファイト！"
  #   when -1.0...-0.5  #-0.5を含まない
  #     "息抜きが必要かも…\n無理しないで！"
  #   else
  #     "投稿からスコアが\n計算できません"
  #   end
  # end

  # おすすめタイムラインの並べ順
  # def self.sorted_by_recommendation
  #   # post.created_atが1週間以内のものをとってくる
  #   # かつ
  #   # ユーザーの平均感情スコアから、+-0.2の範囲をとってくる

  #   # かつ
  #   # 閲覧数が10以上
  #   # または
  #   # user.created_atが1週間以内

  #   # ランダム
  #   # --
  #   # post.created_atが1～4週間以内のものをとってくる
  #   # かつ
  #   # ユーザーの平均感情スコアから、+-0.2～+-0.4の範囲をとってくる

  #   # かつ
  #   # 閲覧数が10～3をとってくる

  #   # ランダム
  #   # --
  #   # post.created_atが4週間～のものをとってくる

  #   # ランダム
  # end


# def self.sorted_by_recommendation(user)
#     # 現在の日付から1週間以内の投稿を取得
#     recent_posts = Post.where("posts.created_at >= ?", 1.week.ago)

#     # 条件を満たす投稿をフィルタリング
#     first_posts = recent_posts.select do |post|
#       # ユーザーのスコアの±0.2以内にあるスコアを持つ投稿を選択
#       (user.average_recent_score - 0.2 <= post.score) && (post.score <= user.average_recent_score + 0.2) &&
#       # 閲覧数が10以上の場合、または投稿者が1週間以内に作成されたユーザーの場合
#       (post.view_counts.count >= 10 || post.user.created_at >= 1.week.ago)
#     end
# # --------------------------------------------------------

#     # 現在の日付から1~4週間以内の投稿を取得
#     recent_posts = Post.where(created_at: 4.weeks.ago..1.week.ago)

#     # 条件を満たす投稿をフィルタリング
#     second_posts = recent_posts.select do |post|
#       # ユーザーのスコアの±0.2~±0.4以内にあるスコアを持つ投稿を選択
#       (user.average_recent_score - 0.4 <= post.score) && (post.score <= user.average_recent_score + 0.4) &&
#       # 閲覧数が10~4の場合
#       (post.view_counts.count <= 10 && post.view_counts.count >= 4)
#     end
# # --------------------------------------------------------

#     # 現在の日付から1週間以内の投稿を取得
#     recent_posts = Post.where("posts.created_at < ?", 1.week.ago)

#     # 条件を満たす投稿をフィルタリング
#     third_posts = recent_posts.select do |post|
#       # ユーザーのスコアの±0.2以内にあるスコアを持つ投稿を選択
#       (user.average_recent_score - 0.2 > post.score) && (post.score > user.average_recent_score + 0.2) &&
#       # 閲覧数が10以上の場合、または投稿者が1週間以内に作成されたユーザーの場合
#       (post.view_counts.count < 10)
#     end


#     arr = first_posts +  third_posts
#     arr


#     # さらに必要であれば、結果を並べ替えることができる
#     # filtered_posts.sort_by(&:created_at).reverse
#   end

  def self.sorted_by_recommendation(user)
    user_posts = user.posts

    if user_posts.any?
      user_average_recent_score = user_posts.average_recent_score
    else
      user_average_recent_score = 0
    end

    within_weeks = Post.where(posted_on: 2.weeks.ago..Time.now)
    outside_weeks = Post.where.not(posted_on: 2.weeks.ago..Time.now)

    within_weeks_with_score_range = within_weeks.joins(:user).where("users.id = ? AND users.average_recent_score BETWEEN ? AND ?", user.id, user_average_recent_score - 0.2, user_average_recent_score + 0.2).order("RANDOM()")
    within_weeks_without_score_range = within_weeks.joins(:user).where("users.id = ? AND NOT (users.average_recent_score BETWEEN ? AND ?)", user.id, user_average_recent_score - 0.2, user_average_recent_score + 0.2).order("RANDOM()")
    outside_weeks_with_score_range = outside_weeks.joins(:user).where("users.id = ? AND users.average_recent_score BETWEEN ? AND ?", user.id, user_average_recent_score - 0.2, user_average_recent_score + 0.2).order("RANDOM()")
    outside_weeks_without_score_range = outside_weeks.joins(:user).where("users.id = ? AND NOT (users.average_recent_score BETWEEN ? AND ?)", user.id, user_average_recent_score - 0.2, user_average_recent_score + 0.2).order("RANDOM()")

    all_posts = within_weeks_with_score_range.or(within_weeks_without_score_range).or(outside_weeks_with_score_range).or(outside_weeks_without_score_range)

  end

end

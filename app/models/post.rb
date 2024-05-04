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


  # おすすめタイムラインの並べ順
  # def self.sorted_by_recommendation
    # 1.
    # post.created_atが2週間以内のもの
    # かつ
    # ユーザーの平均感情スコアから、+-0.2の範囲のもの
    # を取得し、ランダムに並べる
    
    # 2.
    # post.created_atが2週間以内のもの
    # かつ
    # ユーザーの平均感情スコアから、+-0.2の範囲ではないもの
    # を取得し、ランダムに並べる
    
    # 3.
    # post.created_atが2週間以内ではないもの
    # かつ
    # ユーザーの平均感情スコアから、+-0.2の範囲のもの
    # を取得し、ランダムに並べる
    
    # 4.
    # post.created_atが2週間以内ではないもの
    # かつ
    # ユーザーの平均感情スコアから、+-0.2の範囲ではないもの
    # を取得し、ランダムに並べる
    
    # 5.
    # 並び順を保持したまま1.、2.、3.、4.の順番になるように結合する
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

#     arr = first_posts +  second_posts
#     arr
#     # さらに必要であれば、結果を並べ替えることができる
#     # filtered_posts.sort_by(&:created_at).reverse
#   end

  def self.sorted_by_recommendation
    
    within_weeks = Post.where(created_at: 2.weeks.ago..Time.now)
    outside_weeks = Post.where.not(created_at: 2.weeks.ago..Time.now)
  
    within_weeks_with_score_range = within_weeks.joins(:user).where("users.average_recent_score BETWEEN ? AND ?", user_average_recent_score - 0.2, user_average_recent_score + 0.2).order("RANDOM()")
    within_weeks_without_score_range = within_weeks.joins(:user).where.not("users.average_recent_score BETWEEN ? AND ?", user_average_recent_score - 0.2, user_average_recent_score + 0.2).order("RANDOM()")
    outside_weeks_with_score_range = outside_weeks.joins(:user).where("users.average_recent_score BETWEEN ? AND ?", user_average_recent_score - 0.2, user_average_recent_score + 0.2).order("RANDOM()")
    outside_weeks_without_score_range = outside_weeks.joins(:user).where.not("users.average_recent_score BETWEEN ? AND ?", user_average_recent_score - 0.2, user_average_recent_score + 0.2).order("RANDOM()")
  
    all_posts = within_weeks_with_score_range.or(within_weeks_without_score_range).or(outside_weeks_with_score_range).or(outside_weeks_without_score_range)
    
  end


  TWO_WEEKS = 2.weeks.ago
  
    def self.randomized_posts(user)
      posts = Post.all.joins(:user).order('RANDOM()')
      recent_near_score = posts.select { |post| recent?(post) && near_user_score?(post, user) }
      recent_not_near_score = posts.select { |post| recent?(post) && !near_user_score?(post, user) }
      not_recent_near_score = posts.select { |post| !recent?(post) && near_user_score?(post, user) }
      not_recent_not_near_score = posts.select { |post| !recent?(post) && !near_user_score?(post, user) }
  
      combined_posts = recent_near_score + recent_not_near_score + not_recent_near_score + not_recent_not_near_score
      combined_posts.shuffle
    end
  
    def self.recent?(post)
      post.created_at >= TWO_WEEKS
    end
  
    def self.near_user_score?(post, user)
      score_range = user.average_recent_score - 0.2..user.average_recent_score + 0.2
      score_range.cover?(post.score)
    end

end

class SearchService
  def initialize(query)
    @query = query
  end

  def perform_search
    users = User.where('name LIKE ? AND deleted = ?', "%#{@query}%", false).to_a
    posts = Post.joins(:user).where('posts.body LIKE ? AND users.deleted = ?', "%#{@query}%", false).to_a

    {
      users: users,
      posts: posts,
    }
  end
end

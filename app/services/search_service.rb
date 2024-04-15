class SearchService
  def initialize(query)
    @query = query
  end

  def perform_search
    users = User.where('name LIKE ?', "%#{@query}%").to_a
    posts = Post.where('body LIKE ?', "%#{@query}%").to_a

    {
      users: users,
      posts: posts,
    }
  end
end
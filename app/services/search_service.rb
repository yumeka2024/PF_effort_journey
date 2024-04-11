class SearchService
  def initialize(query)
    @query = query
  end

  def perform_search
    users = User.where('name LIKE ?', "%#{@query}%")
    posts = Post.where('body LIKE ?', "%#{@query}%")
    # labels = Label.where('name LIKE ?', "%#{@query}%")

    {
      users: users,
      posts: posts,
      # labels: labels
    }
  end
end
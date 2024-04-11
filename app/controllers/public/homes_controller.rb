class Public::HomesController < ApplicationController
  
  def top
    @posts = Post.all
    @search_results = session.delete(:search_results)
  end

  def about
  end
  
end

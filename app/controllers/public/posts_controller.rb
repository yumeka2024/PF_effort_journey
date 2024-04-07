class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end

  def show
    
  end

  def create
  end

  def destroy
  end

  def confirm
  end
  
  private
  
  def post_params
    params.require(:post).permit(:posted_on, :body)
  end
  
end

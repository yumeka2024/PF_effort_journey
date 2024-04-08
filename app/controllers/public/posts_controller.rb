class Public::PostsController < ApplicationController
  before_action :set_user, only: [ :new, :show, :create, :confirm ]

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    post = Pst
  end

  def destroy
  end

  def confirm
  end

  private

  def set_user
    @user = current_user
  end

  def post_params
    params.require(:post).permit(:posted_on, :body)
  end

end

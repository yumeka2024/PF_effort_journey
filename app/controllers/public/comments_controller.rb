class Public::CommentsController < ApplicationController
  before_action :is_matching_login_user, only: [:update, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      redirect_to post_path(@post), flash: { comment_notice: 'コメントを投稿しました' }
    else
      render template: "public/posts/show"
    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
    if @comment.nil?
      redirect_to root_path
      return
    end
    @post = Post.find_by(id: params[:post_id])
    @user = @post.user
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to post_path(@post), flash: { comment_notice: 'コメントを編集しました' }
    else
      render template: "public/posts/show"
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to post_path(post), flash: { comment_notice: 'コメントを削除しました' }
  end

  private

  def is_matching_login_user
    comment = Comment.find(params[:id])
    unless comment.user_id == current_user.id
      redirect_to root_path
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end

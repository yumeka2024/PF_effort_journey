# app/controllers/public/homes_controller.rb
class Public::HomesController < ApplicationController

  def top
    average_score_before_login = 0.8
    @posts = Kaminari.paginate_array(Post.sorted_by_recommendation(average_score_before_login)).page(params[:page]).per(5)
    if user_signed_in?
      @user = current_user
      @approved_followers = @user.followers.where('relationships.approved = ?', true)
      @approved_following = @user.followings.where('relationships.approved = ?', true)
      @posts = Kaminari.paginate_array(Post.sorted_by_recommendation(@user.average_recent_score)).page(params[:page]).per(5)
      @prev_punch = current_user.punches.find_by(out_time: nil)
    end
  end

  def followed
    @user = current_user
    @posts = Post.where(user_id:Relationship.where(follower_id:@user.id).where(approved: true).pluck(:followed_id).push(@user.id)).includes(user: { image_attachment: :blob }).order(created_at: :desc).page(params[:page]).per(5)
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
    @prev_punch = current_user.punches.find_by(out_time: nil)
  end

  def about
    if user_signed_in?
      @user = current_user
     @prev_punch = current_user.punches.find_by(out_time: nil)
    end
  end

  def notfound
    @user = current_user
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
    @prev_punch = current_user.punches.find_by(out_time: nil)
  end

end

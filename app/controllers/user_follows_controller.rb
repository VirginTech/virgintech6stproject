class UserFollowsController < ApplicationController
  before_action :logged_in?

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    flash[:success] = "#{@user.nickname}さんをフォローしました。"
    redirect_to session[:forwarding_url]
  end

  def destroy
    @user = current_user.following_relationships.find(params[:id]).followed
    current_user.unfollow(@user)
    flash[:danger] = "#{@user.nickname}さんをフォロー解除しました。"
    redirect_to session[:forwarding_url]
  end
  
  private
  
  # ログインしてる？
  def logged_in?
    unless user_logged_in?
      flash[:danger] = "ユーザーログインが必要です。"
      return redirect_to root_path
    end
  end
  
end

class BookmarksController < ApplicationController
  
  before_action :logged_in?

  def create
    @comment = UserComment.find(params[:comment_id])
    current_user.bookmarking(@comment)
    flash[:success] = "コメントをブクマしました。"
    redirect_to session[:forwarding_url]
  end

  def destroy
    #@comment = current_user.bookmarking_comments.find(params[:id])
    @comment = current_user.bookmarking_relationships.find(params[:id]).comment
    current_user.unbookmarking(@comment)
    flash[:danger] = "コメントのブクマを解除しました。"
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

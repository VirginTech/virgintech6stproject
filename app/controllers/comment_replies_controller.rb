class CommentRepliesController < ApplicationController

  before_action :is_are_comment?, only: [:show]
  
  #==================
  # 全リプライ表示
  #==================
  def show
    @comment=UserComment.find(params[:id])
    @product = @comment.product
    @developer=@product.developer
    @reply = current_user.comment_replies.build if user_logged_in?
  end
  
  #==================
  # リプライ
  #==================
  def create
    @reply = current_user.comment_replies.build(reply_params)
    if @reply.save
      flash[:success] = "返信を投稿しました。"
      redirect_to session[:forwarding_url]
    else
      flash[:danger] = "返信の投稿に失敗しました。"
      redirect_to session[:forwarding_url]
    end
  end

  def destroy
    @user=current_user
    @reply = @user.comment_replies.find_by(id: params[:id])
    return redirect_to session[:forwarding_url] if @reply.nil?
    @reply.destroy
    flash[:danger] = "返信を削除しました。"
    redirect_to session[:forwarding_url]
  end
  



  private

  # 存在チェック
  def is_are_comment?
    unless UserComment.find_by_id(params[:id])
      flash[:danger] = "セッションエラーが発生しました。存在しないIDです。"
      return redirect_to root_path
    end
  end

  def reply_params
    params.require(:comment_reply).permit(:user_comment_id, :reply_comment, :image)
  end
  
end
class CommentRepliesController < ApplicationController


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
  
  def reply_params
    params.require(:comment_reply).permit(:user_comment_id, :reply_comment, :image)
  end
  
end
class UserCommentsController < ApplicationController
  
  #before_action :logged_in_user, only: [:create]
  
  def show
    @product = Product.find(params[:id])
    @developer=@product.developer
    @comments = @product.user_comments.order(created_at: :desc).page(params[:page]).per(10)
    @user_comment = current_user.user_comments.build if user_logged_in?
    #binding.pry
  end
  
  def create
    @user_comment = current_user.user_comments.build(comment_params)
    if @user_comment.save
      flash[:success] = "つぶやきが投稿されました。"
      redirect_to user_comment_path(@user_comment.product)
    else
      @product=@user_comment.product
      @developer=@product.developer
      @comments = @product.user_comments.order(created_at: :desc).page(params[:page]).per(10)
      render 'user_comments/show'
    end
  end
  
  def destroy
    @user=current_user
    @comment = @user.user_comments.find_by(id: params[:id])
    return redirect_to session[:forwarding_url] if @comment.nil?
    @comment.destroy
    flash[:danger] = "つぶやきが削除されました。"
    redirect_to session[:forwarding_url]
  end
  
  private
  
  def comment_params
    params.require(:user_comment).permit(:product_id, :comment, :image, :image_cache)
  end

end

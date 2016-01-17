class UserCommentsController < ApplicationController
  
  #before_action :logged_in_user, only: [:create]
  
  def show
    @product = Product.find(params[:id])
    @developer=@product.developer
    @comments = @product.user_comments
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
      @comments = @product.user_comments
      render 'user_comments/show'
    end
  end
  
  private
  
  def comment_params
    params.require(:user_comment).permit(:product_id, :comment, :image)
  end

end

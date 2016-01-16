class UserCommentsController < ApplicationController
  
  before_action :logged_in_user, only: [:create]
  
  def show
    @product = Product.find(params[:id])
    @developer=@product.developer
    @comments = @product.user_comments
    @user_comment = current_user.user_comments.build if user_logged_in?
    #binding.pry
  end
  
  def create
    binding.pry
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:product_id, :comment, :image)
  end

end

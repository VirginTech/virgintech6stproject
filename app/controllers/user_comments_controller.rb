class UserCommentsController < ApplicationController
  
  before_action :logged_in_user, only: [:create]
  
  def show
    @product = Product.find(params[:id])
    @developer=@product.developer
    @comments = @product.user_comments
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:product_id, :comment, :image)
  end

end

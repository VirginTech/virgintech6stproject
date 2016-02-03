class FavoritesController < ApplicationController
  
  before_action :logged_in?

  def create
    @product = Product.find(params[:product_id])
    current_user.favoriting(@product)
    flash[:success] = "#{@product.appname}をお気に入りしました。"
    redirect_to session[:forwarding_url]
  end

  def destroy
    @product = current_user.favoriting_relationships.find(params[:id]).product
    current_user.unfavoriting(@product)
    flash[:danger] = "#{@product.appname}をお気に入り解除しました。"
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

class DevCommentsController < ApplicationController

  before_action :logged_in?, only: [:create]
  before_action :is_developer_comment?, only: [:edit, :update, :destroy]
  before_action :is_are_product?, only: [:show]
  
  def edit
    @dev_comment = DevComment.find(params[:id])
    @product = @dev_comment.product
    @developer=@product.developer
  end
  
  def update
    @dev_comment = DevComment.find(params[:id])
    if @dev_comment.update(comment_params)
      flash[:success] = "コメントを変更しました。"
      redirect_to dev_comment_path(@dev_comment.product)
    else
      @product = @dev_comment.product
      @developer=@product.developer
      render 'dev_comments/edit'
    end
  end
  
  def show
    @product = Product.find(params[:id])
    @developer=@product.developer
    @comments = @product.dev_comments.order(created_at: :desc).page(params[:page]).per(10)
    @dev_comment = current_developer.dev_comments.build if dev_logged_in?
  end
  
  def create
    @dev_comment = current_developer.dev_comments.build(comment_params)
    if @dev_comment.save
      flash[:success] = "コメントが投稿されました。"
      redirect_to dev_comment_path(@dev_comment.product)
    else
      @product=@dev_comment.product
      @developer=@product.developer
      @comments = @product.dev_comments.order(created_at: :desc).page(params[:page]).per(10)
      render 'dev_comments/show'
    end
  end
  
  def destroy
    @developer=current_developer
    @comment = @developer.dev_comments.find_by(id: params[:id])
    return redirect_to session[:forwarding_url] if @comment.nil?
    @comment.destroy
    flash[:danger] = "コメントが削除されました。"
    redirect_to session[:forwarding_url]
  end

  private

  # ログインしてる？
  def logged_in?
    unless dev_logged_in?
      flash[:danger] = "デバロッパーログインが必要です。"
      return redirect_to root_path
    end
  end

  # コメントがデヴェロッパーのものかチェック
  def is_developer_comment?
    unless dev_logged_in?
      flash[:danger] = "ログインして下さい。"
      return redirect_to root_path
    end
    unless DevComment.find_by_id(params[:id])
      flash[:danger] = "セッションエラーが発生しました。パラメーターが不正です。"
      return redirect_to root_path
    end
    unless same_developer?(DevComment.find(params[:id]).developer.id)
      flash[:danger] = "セッションエラーが発生しました。不正なURLです。"
      return redirect_to root_path
    end
  end

  # 存在チェック
  def is_are_product?
    unless Product.find_by_id(params[:id])
      flash[:danger] = "セッションエラーが発生しました。存在しないIDです。"
      return redirect_to root_path
    end
  end
  
  def comment_params
    params.require(:dev_comment).permit(:product_id, :comment, :image, :image_cache, :remove_image)
  end
  
end

class TopPagesController < ApplicationController
  
  def top
    @products=Product.all.order(created_at: :desc).limit(10)
    @user_comments = UserComment.all.order(created_at: :desc).limit(10)
    @dev_comments = DevComment.all.order(created_at: :desc).limit(10)
    @reply = current_user.comment_replies.build if user_logged_in?
  end
  
  def user_comment_all
    @user_comments = UserComment.all.order(created_at: :desc).page(params[:page]).per(10)
    @reply = current_user.comment_replies.build if user_logged_in?
  end
  
  def dev_comment_all
    @dev_comments = DevComment.all.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  #======================
  # 検索メソッド
  #======================
  def result
    # 新着順
    if params[:order]=="0"
      @products=Product.order(created_at: :desc).page(params[:page]).per(10)
    # ランキング順
    elsif params[:order]=="1"
    
    # カテゴリー
    elsif params[:order]=="2"
      @products = Product.where(category: params[:category]).order(created_at: :desc).page(params[:page]).per(10)
    # 機種
    elsif params[:order]=="3"
      if params[:model]=="1" # iPhone
        @products = Product.where(model_iphone: true).order(created_at: :desc).page(params[:page]).per(10)
      elsif params[:model]=="2" # Android
        @products = Product.where(model_android: true).order(created_at: :desc).page(params[:page]).per(10)
      elsif params[:model]=="3" # Web-Game
        @products = Product.where(model_web: true).order(created_at: :desc).page(params[:page]).per(10)
      end
    # 価格
    elsif params[:order]=="4"
      @products = Product.where(price: params[:price]).order(created_at: :desc).page(params[:page]).per(10)
    # セール
    elsif params[:order]=="5"
      if params[:sale]=="1" # リリース済み
        @products = Product.where('sale_date <= ?',Date.today).order(created_at: :desc).page(params[:page]).per(10)
      elsif params[:sale]=="2" # リリース待ち
        @products = Product.where('sale_date > ?',Date.today).order(created_at: :desc).page(params[:page]).per(10)
      end
    # 検索ボックス
    elsif params[:order]=="6"
      @products=Product.where('appname like ?', "%#{params[:search_word]}%").order(created_at: :desc).page(params[:page]).per(10)
    end

  end
end

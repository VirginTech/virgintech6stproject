class TopPagesController < ApplicationController
  
  def top
    @products=Product.all.order(created_at: :desc).limit(15)
    @user_comments = UserComment.all.order(created_at: :desc).limit(10)
    @dev_comments = DevComment.all.order(created_at: :desc).limit(10)
    @reply = current_user.comment_replies.build if user_logged_in?
  end
  
  def user_comment_all
    @user_comments = UserComment.all.order(created_at: :desc).page(params[:page]).per(20)
    @reply = current_user.comment_replies.build if user_logged_in?
  end
  
  def dev_comment_all
    @dev_comments = DevComment.all.order(created_at: :desc).page(params[:page]).per(20)
  end
  
  #======================
  # 検索メソッド
  #======================
  def result
    # 新着順
    if params[:order]=="0"
      @products=Product.order(created_at: :desc).page(params[:page]).per(20)
    # お気に入りランキング順
    elsif params[:order]=="1"
      product_ids = Favorite.group(:product_id)
                            .order('count_product_id desc')
                            .count('product_id')
                            .keys
      # お気に入りされてないものも足す
      product_ids += Product.pluck(:id) - product_ids
      #検索して多い順に並び替え
      products_ = Product.find(product_ids).sort_by{|o| product_ids.index(o.id)}
      #配列をページング
      @products = Kaminari.paginate_array(products_).page(params[:page]).per(20)
    # カテゴリー
    elsif params[:order]=="2"
      @products = Product.where(category: params[:category]).order(created_at: :desc).page(params[:page]).per(20)
    # 機種
    elsif params[:order]=="3"
      if params[:model]=="1" # iPhone
        @products = Product.where(model_iphone: true).order(created_at: :desc).page(params[:page]).per(20)
      elsif params[:model]=="2" # Android
        @products = Product.where(model_android: true).order(created_at: :desc).page(params[:page]).per(20)
      elsif params[:model]=="3" # Web-Game
        @products = Product.where(model_web: true).order(created_at: :desc).page(params[:page]).per(20)
      end
    # 価格
    elsif params[:order]=="4"
      @products = Product.where(price: params[:price]).order(created_at: :desc).page(params[:page]).per(20)
    # セール
    elsif params[:order]=="5"
      if params[:sale]=="1" # リリース済み
        @products = Product.where('sale_date <= ?',Date.today).order(created_at: :desc).page(params[:page]).per(20)
      elsif params[:sale]=="2" # リリース待ち
        @products = Product.where('sale_date > ?',Date.today).order(created_at: :desc).page(params[:page]).per(20)
      end
    # 検索ボックス
    elsif params[:order]=="6"
      @products=Product.where('appname like ?', "%#{params[:search_word]}%").order(created_at: :desc).page(params[:page]).per(20)
    end

  end
end

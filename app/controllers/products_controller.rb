class ProductsController < ApplicationController
  
  before_action :logged_in?, only: [:new, :create]
  before_action :is_developer_app?, only: [:edit, :update, :destroy]
  before_action :is_are_product?, only: [:show]
  
  def destroy
    @developer=current_developer
    @product = @developer.products.find_by(id: params[:id])
    return redirect_to @developer if @product.nil?
    @product.destroy
    flash[:success] = "アプリを削除しました。"
    redirect_to @developer
  end

  def show
    @product = Product.find(params[:id])
    @developer=@product.developer
    
    #スクリーンショット１つをサンプリング (サイズ取得のため)
    image = MiniMagick::Image.open(@product.img_screenshot_01.url)
    #image = Magick::ImageList.new(@product.img_screenshot_01.url) RMagicを使うならこちら
    if image[:width] < image[:height]
      @screen_vertical = true #縦長
    else
      @screen_vertical = false #横長
    end
  end
  
  def edit
    @developer=current_developer
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:success] = "アプリ登録情報を変更しました。"
      redirect_to current_developer
    else
      #flash[:danger] = "アカウント変更に失敗しました。"
      @developer=current_developer
      render 'edit'
    end
  end
  
  def new
    @developer=current_developer
    @product = current_developer.products.build if dev_logged_in? 
  end

  def create
    @product = current_developer.products.build(product_params)
    if @product.save
      flash[:success] = "新規アプリを登録しました！"
      redirect_to current_developer
    else
      @developer=current_developer
      render 'new'
    end
  end

  private
  
  # ログインしてる？
  def logged_in?
    unless dev_logged_in?
      dev_store_location
      flash[:danger] = "デバロッパーログインが必要です。"
      return redirect_to root_path
    end
  end
  
  # アプリがデヴェロッパーのものかチェック
  def is_developer_app?
    unless dev_logged_in?
      dev_store_location
      flash[:danger] = "ログインして下さい。"
      return redirect_to root_path
    end
    unless Product.find_by_id(params[:id])
      dev_store_location
      flash[:danger] = "セッションエラーが発生しました。IDが不正です。"
      return redirect_to root_path
    end
    unless same_developer?(Product.find(params[:id]).developer.id)
      dev_store_location
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
  
  def product_params
    params.require(:product).permit(:appname,
                                    :summary,
                                    :description,
                                    :category,
                                    :price,
                                    :model_iphone,
                                    :model_android,
                                    :model_web,
                                    
                                    :img_icon,
                                    :img_icon_cache,
                                    :remove_img_icon,
                                    
                                    :img_screenshot_01,
                                    :img_screenshot_01_cache,
                                    :remove_img_screenshot_01,
                                    
                                    :img_screenshot_02,
                                    :img_screenshot_02_cache,
                                    :remove_img_screenshot_02,
                                    
                                    :img_screenshot_03,
                                    :img_screenshot_03_cache,
                                    :remove_img_screenshot_03,
                                    
                                    :img_screenshot_04,
                                    :img_screenshot_04_cache,
                                    :remove_img_screenshot_04,
                                    
                                    :img_screenshot_05,
                                    :img_screenshot_05_cache,
                                    :remove_img_screenshot_05,
                                    
                                    :sale_date,
                                    :store_iphone_url,
                                    :store_android_url,
                                    :store_webgame_url,
                                    :official_site,
                                    :twitter,
                                    :facebook,
                                    :etc_site,
                                    :youtube_url
                                    )
  end

end

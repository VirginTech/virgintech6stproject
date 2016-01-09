class ProductsController < ApplicationController
  
  before_action :is_developer_app?, only: [:edit, :update, :destroy]
  
  def destroy
    @developer=current_developer
    @product = @developer.products.find_by(id: params[:id])
    return redirect_to @developer if @product.nil?
    @product.destroy
    flash[:success] = "アプリを削除しました。"
    redirect_to @developer
  end

  def show
    
  end
  
  def edit
    @developer=current_developer
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:success] = "アプリ登録情報を変更しました。"
      redirect_to edit_product_path(@product)
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
                                    :etc_site
                                    )
  end

end

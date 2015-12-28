class ProductsController < ApplicationController
  
  before_action :logged_in_developer, only: [:new]
  
  def new
    @product = current_developer.products.build if dev_logged_in? 
  end

  def create
    @product = current_developer.products.build(product_params)
    if @product.save
      flash[:success] = "新規アプリを登録しました！"
      redirect_to current_developer
    else
      render 'new'
    end
  end

  private
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
                                    :img_screenshot_01,
                                    :img_screenshot_02,
                                    :img_screenshot_03,
                                    :img_screenshot_04,
                                    :img_screenshot_05)
  end

end

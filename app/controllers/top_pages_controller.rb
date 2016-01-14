class TopPagesController < ApplicationController
  
  def top
    @products=Product.all.order(created_at: :desc).limit(5)
  end
  
  def result
    
    # 新着順
    if params[:order]=="0"
      @products=Product.all.order(created_at: :desc).page(params[:page]).per(5)
    
    # ランキング順
    elsif params[:order]=="1"
      
    
    end
    
  end
  
end

class TopPagesController < ApplicationController
  
  def top
    @products=Product.all.order(created_at: :desc)
  end
  
end

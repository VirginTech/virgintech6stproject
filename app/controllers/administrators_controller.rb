class AdministratorsController < ApplicationController
  
  before_action :logged_in_admin, only: [:admin_menu, :admin_mail_info]
  
  def product_mail_info
    @user=User.all

    products=Array.new
    product=nil;
    products.push product if product=Product.find_by_id(params[:app_01])
    products.push product if product=Product.find_by_id(params[:app_02])
    products.push product if product=Product.find_by_id(params[:app_03])
    products.push product if product=Product.find_by_id(params[:app_04])
    products.push product if product=Product.find_by_id(params[:app_05])
    
    #binding.pry
    @user.each do |user|
      if user.product_mail_info
        if user.email?
          AdminMailer.product_mail_info(user,products).deliver
        end
      end
    end
    flash[:success] = "メールを一斉送信しました。"
    redirect_to admin_menu_path
  end
  
  def admin_mail_info
  end
  
  def admin_top
    uuid=params[:uuid]
    unless uuid==Rails.application.secrets.admin_page_uuid
      flash[:danger] ="URLが適切ではありません。"
      redirect_to root_path
    end
  end
  
  def admin_menu
  end
  
  def create
    if params[:admin_session][:id]==Rails.application.secrets.admin_account_key && 
                        params[:admin_session][:password]==Rails.application.secrets.admin_account_secret
      session[:admin_id] = Rails.application.secrets.admin_account_secret
      flash[:success] = "管理者ログインに成功しました。"
      redirect_to admin_menu_path
    else
      flash[:danger] = 'ログインに失敗しました。'
      render 'admin_top'
    end
  end
  
  def destroy
    session[:admin_id] = nil
    flash[:danger] = "ログアウトしました。"
    redirect_to root_path
  end
  
  
  private
  
  def logged_in_admin
    if session[:admin_id] == nil
      flash[:danger] = "管理者ではありません。"
      return redirect_to root_path
    end
  end
  
end
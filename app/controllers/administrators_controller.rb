class AdministratorsController < ApplicationController
  
  before_action :logged_in_admin, only: [:admin_menu, :product_mail_info, :dev_mail_info, :user_mail_info]

  #=========================
  # ユーザー通知
  #=========================
  def user_mail_info
  end

  def user_mail_info_send
    users=User.all
    mail_body=params[:mail_body]
    users.each do |user|
      if user.email?
        AdminMailer.user_mail_info(user,mail_body).deliver
      end
    end
    flash[:success] = "ユーザー通知メールを一斉送信しました。"
    redirect_to admin_menu_path
  end

  #=========================
  # デベロッパー通知
  #=========================
  def dev_mail_info
  end

  def dev_mail_info_send
    developers=Developer.all
    mail_body=params[:mail_body]
    developers.each do |developer|
      if developer.email?
        AdminMailer.dev_mail_info(developer,mail_body).deliver
      end
    end
    flash[:success] = "デベロッパー通知メールを一斉送信しました。"
    redirect_to admin_menu_path
  end

  #=========================
  # おすすめアプリ通知
  #=========================
  def product_mail_info
  end
  
  def product_mail_info_send
    users=User.all

    products=Array.new
    product=nil;
    products.push product if product=Product.find_by_id(params[:app_01])
    products.push product if product=Product.find_by_id(params[:app_02])
    products.push product if product=Product.find_by_id(params[:app_03])
    products.push product if product=Product.find_by_id(params[:app_04])
    products.push product if product=Product.find_by_id(params[:app_05])
    
    #binding.pry
    users.each do |user|
      if user.product_mail_info
        if user.email?
          AdminMailer.product_mail_info(user,products).deliver
        end
      end
    end
    flash[:success] = "おすすめメールを一斉送信しました。"
    redirect_to admin_menu_path
  end
  
  #=========================
  # 管理画面トップメニュー
  #=========================
  def admin_menu
  end
  
  def admin_top
    uuid=params[:uuid]
    unless uuid==Rails.application.secrets.admin_page_uuid
      flash[:danger] ="URLが適切ではありません。"
      redirect_to root_path
    end
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
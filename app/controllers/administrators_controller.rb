class AdministratorsController < ApplicationController
  
  before_action :logged_in_admin, only: [:admin_menu]
  
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
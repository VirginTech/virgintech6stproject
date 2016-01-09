class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include UserSessionsHelper
  include DevSessionsHelper

  private

  def logged_in_user
    unless user_logged_in?
      user_store_location
      flash[:danger] = "ログインして下さい。"
      return redirect_to root_path
    end
    unless same_user?(params[:id])
      user_store_location
      flash[:danger] = "セッションエラーが発生しました。不正なURLです。"
      return redirect_to root_path
    end
  end

  def logged_in_developer
    unless dev_logged_in?
      dev_store_location
      flash[:danger] = "ログインして下さい。"
      return redirect_to root_path
    end
    unless same_developer?(params[:id])
      dev_store_location
      flash[:danger] = "セッションエラーが発生しました。不正なURLです。"
      return redirect_to root_path
    end
  end
  
end

class UserSessionsController < ApplicationController
  
  def create_sns_login
    #binding.pry
    @user=User.find_or_create_from_auth(request.env['omniauth.auth'])
    if $sns_create_flg
      session[:user_id]=@user.id
      flash[:info] = "ようこそ #{@user.nickname} さん！"
    else
      flash[:danger] = 'すでに同名のニックネームが使用されています。
                        別のSNSを利用するか、メールアドレスでサインアップして下さい'
    end
    redirect_to root_path
  end
  
  def create
    @user = User.find_by(email: params[:user_session][:email].downcase)
    if @user && @user.authenticate(params[:user_session][:password])
      session[:user_id] = @user.id
      flash[:info] = "ようこそ #{@user.nickname} さん！"
      redirect_to root_path
    else
      flash[:danger] = '電子メール又は、パスワードに誤りがあります。'
      redirect_to root_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:danger] = "ログアウトしました。"
    redirect_to root_path
  end
  
  #=======================
  #SNSログインキャンセル
  #=======================
  def failure
    flash[:danger] = "認証に失敗しました。"
    redirect_to root_url
  end
  
end

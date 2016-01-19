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
      if @user.status
        session[:user_id] = @user.id
        flash[:info] = "ようこそ #{@user.nickname} さん！"
        redirect_to session[:forwarding_url] #root_path
      else
        flash[:danger] = '本登録が済んでいません。登録されたメールアドレスあてに確認用メールが届いていませんか？'
        redirect_to session[:forwarding_url]
      end
    else
      flash[:danger] = 'メールアドレス又は、パスワードに誤りがあります。'
      redirect_to session[:forwarding_url]
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

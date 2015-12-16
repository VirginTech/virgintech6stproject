class SessionsController < ApplicationController
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
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
    redirect_to root_path
  end
  
end

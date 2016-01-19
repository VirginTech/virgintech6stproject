class DevSessionsController < ApplicationController
  
  def create
    @developer = Developer.find_by(email: params[:dev_session][:email].downcase)
    if @developer && @developer.authenticate(params[:dev_session][:password])
      if @developer.status
        session[:developer_id] = @developer.id
        flash[:info] = "ようこそ #{@developer.name} さん！"
        redirect_to session[:forwarding_url]
      else
        flash[:danger] = '本登録が済んでいません。登録されたメールアドレスあてに確認用メールが届いていませんか？'
        redirect_to session[:forwarding_url]
      end
    else
      flash[:danger] = '電子メール又は、パスワードに誤りがあります。'
      redirect_to session[:forwarding_url]
    end
  end

  def destroy
    session[:developer_id] = nil
    flash[:danger] = "ログアウトしました。"
    redirect_to root_path
  end
  
end

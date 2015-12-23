class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.attributes = user_params
    #if @user.update(user_params)#コンテキストでバリデーションを分ける
    #========================
    #SNSアカウント
    #========================
    #binding.pry
    if params[:user][:provider].present?
      if @user.save(context: :snslogin)
        flash[:success] = "アカウント情報を変更しました。"
        redirect_to edit_user_path(@user)
      else
        #flash[:danger] = "アカウント変更に失敗しました。"
        render 'edit'
      end
    #========================
    #通常アカウント
    #========================
    else
      if @user.save(context: :signup)
        flash[:success] = "アカウント情報を変更しました。"
        redirect_to edit_user_path(@user)
      else
        #flash[:danger] = "アカウント変更に失敗しました。"
        render 'edit'
      end
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save(context: :signup)
      session[:user_id] = @user.id
      flash[:success] = "ようこそ" + @user.nickname + "さん！"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    current_user.destroy
    reset_session
    flash[:danger] = "退会処理に成功しました。またのご利用お待ちしております。"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:nickname, 
                                  :email,
                                  :password,
                                  :password_confirmation,
                                  :provider,
                                  :uid,
                                  :profile_img,
                                  :profile_img_cache,
                                  :remove_profile_img)
  end
  
end

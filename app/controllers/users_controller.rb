class UsersController < ApplicationController
  
  def new
    @user = User.new
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

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :uid)
  end
  
end

class DevelopersController < ApplicationController
  
  def new
    @developer=Developer.new
  end

  def show
    @developer = Developer.find(params[:id])
  end
  
  def edit
    @developer = Developer.find(params[:id])
  end
  
  def update
    @developer = Developer.find(params[:id])
    if @developer.update(dev_params)
      flash[:success] = "アカウント情報を変更しました。"
      redirect_to edit_developer_path(@developer)
    else
      #flash[:danger] = "アカウント変更に失敗しました。"
      render 'edit'
    end
  end

  def create
    #binding.pry
    @developer = Developer.new(dev_params)
    if @developer.save(context: :signup)
      session[:developer_id] = @developer.id
      flash[:success] = "ようこそ" + @developer.name + "さん！"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    current_developer.destroy
    reset_session
    flash[:danger] = "退会処理に成功しました。またのご利用お待ちしております。"
    redirect_to root_path
  end

  private

  def dev_params
    params.require(:developer).permit(:name, :email, :password, :password_confirmation,
                        :website, :twitter, :facebook, :google, :official_site, :contact_email)
  end
  
end

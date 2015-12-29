class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find_by_id(params[:id])
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

  #========================
  # 仮登録
  #========================
  def create
    # 入力したメールアドレスのユーザが存在するか調べる
    tmp_user = User.find_by_email(user_params[:email])
   
    if tmp_user && tmp_user.status
      # ユーザ作成済み
      flash[:warning] = "入力されたメールアドレスは登録済みです。"
      redirect_to root_path
   
    elsif tmp_user
      # ユーザは既にあるが、本登録していない。一度ユーザーのトークンを全て使えなくする
      @user = tmp_user
      #Token.all.each do |token|
      @user.regist_tokens.all.each do |token|
        # 有効期限を変更する
        token.update_attributes!(expired_at: Time.now)
      end
      # 新しいトークン生成
      @token = SecureRandom.uuid
      # 有効期限は２４時間
      @user.regist_tokens.create!(uuid: @token, expired_at: 24.hours.since)
      # メール通知(ActionMailer)
      @mail = RegistConfirmMailer.regist_confirm(@user,@token).deliver
      # 仮登録成功ページヘ
      flash[:success] = "ご登録ありがとうございます！入力されたメールアドレスあてに、本登録用URLを送りましたのでご確認ください。"
      redirect_to root_path
    else
      @user = User.new(user_params)
      @user.status = false
   
      if @user.save(context: :signup)
        # トークン生成
        @token = SecureRandom.uuid
        @user.regist_tokens.create!(uuid: @token, expired_at: 24.hours.since)
        # メール通知
        @mail = RegistConfirmMailer.regist_confirm(@user,@token).deliver
        flash[:success] = "ご登録ありがとうございます！入力されたメールアドレスあてに、本登録用URLを送りましたのでご確認ください。"
        redirect_to root_path
      else
        render 'new'
      end
    end    
    
    #@user = User.new(user_params)
    #if @user.save(context: :signup)
    #  session[:user_id] = @user.id
    #  flash[:success] = "ようこそ" + @user.nickname + "さん！"
    #  redirect_to root_path
    #else
    #  render 'new'
    #end
    
  end

  #========================
  # 本登録
  #========================
  def regist_token
    # 有効期限の確認
    token = RegistToken.find_by_uuid!(params[:uuid])
    # 有効期限を過ぎていないか確認
    if token && token.expired_at > Time.now
      # ２回目アクセスできないように更新
      token.update_attributes!(expired_at: Time.now)
      @user = token.user
      @user.update_attributes!(status: true)
      # 登録完了メール通知
      flash[:success] = "おめでとうございます！本登録が完了しました！"
      @mail = RegistConfirmMailer.regist_complet(@user).deliver
      # ログイン画面へ
      redirect_to root_path
    else
      # トークンがない、もしくは２回目のアクセス -> 失敗を通知、ユーザ登録ページのリンクを貼る
      if token && token.user.status
        flash[:danger] ="入力されたメールアドレスは本登録が完了しています。"
        redirect_to root_path
      else
        flash[:danger] ="仮登録の有効期限が切れている。もしくは、URLが適切ではありません。"
        redirect_to root_path
      end
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

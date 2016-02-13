class DevelopersController < ApplicationController
  
  before_action :logged_in_developer, only: [:edit, :update, :destroy]
  before_action :is_are_you?, only: [:show, :dev_comment_show, :dev_activity]

  def dev_activity
    @developer = Developer.find(params[:id])
    activity=Array.new
    #プロダクト
    @developer.products.each do |value|
      activity.push [0, value.id, value.id, value.created_at]
    end
    #コメント
    @developer.dev_comments.each do |value|
      activity.push [1, value.id, value.product_id, value.created_at]
    end
    #日付けでソート
    #@activity=activity.sort { |a,b| b[3] <=> a[3] } # sort_byの方が早いらしい
    activity_=activity.sort_by(&:last).reverse
    #配列をページング
    @activitys = Kaminari.paginate_array(activity_).page(params[:page]).per(10)
  end
  
  def dev_comment_show
    @developer = Developer.find_by_id(params[:id])
    @comments = @developer.dev_comments.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def new
    @developer=Developer.new
  end

  def show
    @developer = Developer.find(params[:id])
    @products=@developer.products.order(created_at: :desc)
  end
  
  def edit
    #未登録idでもエラーにしない(nilが入る)為にfind_by_idを使ってみたが、結局どこかでエラーになるので意味なし
    @developer = Developer.find_by_id(params[:id])
  end
  
  def update
    @developer = Developer.find(params[:id])
    if @developer.update(dev_params)
      flash[:success] = "アカウント情報を変更しました。"
      redirect_to @developer
    else
      #flash[:danger] = "アカウント変更に失敗しました。"
      render 'edit'
    end
  end

  #========================
  # 仮登録
  #========================
  def create
    # 入力したメールアドレスのユーザが存在するか調べる
    tmp_developer = Developer.find_by_email(dev_params[:email])
   
    if tmp_developer && tmp_developer.status
      # ユーザ作成済み
      flash[:warning] = "入力されたメールアドレスは登録済みです。"
      redirect_to root_path
   
    elsif tmp_developer
      # デベロッパーは既にあるが、本登録していない。一度デベロッパーのトークンを全て使えなくする
      @developer = tmp_developer
      #Token.all.each do |token|
      @developer.regist_dev_tokens.all.each do |token|
        # 有効期限を変更する
        token.update_attributes!(expired_at: Time.now)
      end
      # 新しいトークン生成
      @token = SecureRandom.uuid
      # 有効期限は２４時間
      @developer.regist_dev_tokens.create!(uuid: @token, expired_at: 24.hours.since)
      # メール通知(ActionMailer)
      @mail = RegistConfirmMailer.regist_confirm_dev(@developer,@token).deliver
      # 仮登録成功ページヘ
      flash[:success] = "ご登録ありがとうございます！入力されたメールアドレスあてに、本登録用URLを送りましたのでご確認ください。"
      redirect_to root_path
    else
      @developer = Developer.new(dev_params)
      @developer.status = false
   
      if @developer.save(context: :signup)
        # トークン生成
        @token = SecureRandom.uuid
        @developer.regist_dev_tokens.create!(uuid: @token, expired_at: 24.hours.since)
        # メール通知
        @mail = RegistConfirmMailer.regist_confirm_dev(@developer,@token).deliver
        flash[:success] = "ご登録ありがとうございます！入力されたメールアドレスあてに、本登録用URLを送りましたのでご確認ください。"
        redirect_to root_path
      else
        render 'new'
      end
    end    
    
    #@developer = Developer.new(dev_params)
    #if @developer.save(context: :signup)
    #  session[:developer_id] = @developer.id
    #  flash[:success] = "ようこそ" + @developer.name + "さん！"
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
    token = RegistDevToken.find_by_uuid(params[:uuid])
    # 有効期限を過ぎていないか確認
    if token && token.expired_at > Time.now
      # ２回目アクセスできないように更新
      token.update_attributes!(expired_at: Time.now)
      @developer = token.developer
      @developer.update_attributes!(status: true)
      # 登録完了メール通知
      flash[:success] = "おめでとうございます！本登録が完了しました！"
      @mail = RegistConfirmMailer.regist_complet_dev(@developer).deliver
      # ログイン画面へ
      redirect_to root_path
    else
      # トークンがない、もしくは２回目のアクセス -> 失敗を通知、ユーザ登録ページのリンクを貼る
      if token && token.developer.status
        flash[:danger] ="入力されたメールアドレスは本登録が完了しています。"
        redirect_to root_path
      else
        flash[:danger] ="仮登録の有効期限が切れている。もしくは、URLが適切ではありません。"
        redirect_to root_path
      end
    end
  end

  def destroy
    current_developer.destroy
    reset_session
    flash[:danger] = "退会処理に成功しました。またのご利用お待ちしております。"
    redirect_to root_path
  end

  #=======================
  #パスワードリマインダー
  #=======================
  def pass_reminder
  end
  
  def token_create
    email=params[:email]
    # 入力したメールアドレスのユーザが存在するか調べる
    @developer = Developer.find_by_email(email)
    if @developer
      #ユーザーのトークンを全て無効にする
      @developer.pass_dev_tokens.all.each do |token|
        token.update_attributes!(expired_at: Time.now) #有効期限を変更する
      end
      # 新しいトークン生成
      @token = SecureRandom.uuid
      # 有効期限は5分以内
      @developer.pass_dev_tokens.create!(uuid: @token, expired_at: 5.minutes.since)
      # メール送信
      @mail = PassRemindMailer.pass_remind_dev(@developer,@token).deliver
      flash[:success] = "#{email}あてにメールを送信しました。"
      redirect_to root_path
    else
      flash[:danger] = "#{email}は存在しないメールアドレスです。"
      redirect_to root_path
    end
  end

  def pass_token
    # 有効期限の確認
    uuid=params[:uuid]
    token = PassDevToken.find_by_uuid(uuid)
    # 有効期限を過ぎていないか確認
    if token && token.expired_at > Time.now
      # ２回目アクセスできないように更新
      token.update_attributes!(expired_at: Time.now)
      @developer = token.developer
      
      flash[:success] = "#{@developer.name}様。パスワードを設定して下さい。"
      redirect_to reset_password_dev_path(uuid: uuid)
    else
      flash[:danger] ="トークンの有効期限が切れている。もしくは、URLが適切ではありません。"
      redirect_to root_path
    end
  end

  def reset_password
    #binding.pry
    uuid=params[:uuid]
    token=PassDevToken.find_by_uuid(uuid)
    if token
      @developer=token.developer
    else
      render 'shared/_session_error'
    end
  end

  def update_password
    #binding.pry
    uuid=params[:developer][:uuid]
    token=PassDevToken.find_by_uuid!(uuid)
    @developer = token.developer
    @developer.attributes = dev_params
    if @developer.save(context: :pass_update)
      flash[:success] = "#{@developer.name}様。パスワードを変更しました。"
      redirect_to root_path
    else
      flash[:danger] ="パスワードの変更に失敗しました。もう一度入力して下さい。"
      redirect_to reset_password_dev_path(uuid: uuid)
    end
  end


  private
  
  # 存在チェック
  def is_are_you?
    unless Developer.find_by_id(params[:id])
      flash[:danger] = "セッションエラーが発生しました。存在しないIDです。"
      return redirect_to root_path
    end
  end

  def dev_params
    params.require(:developer).permit(:name,
                                      :email,
                                      :password,
                                      :password_confirmation,
                                      :profile_img,
                                      :profile_img_cache,
                                      :remove_profile_img,
                                      :status,
                                      :profile,
                                      :website,
                                      :twitter,
                                      :facebook,
                                      :google,
                                      :official_site,
                                      :contact_email)
  end
  
end

class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :is_are_you?, only: [:show, :user_timeline, :user_favorite, :user_bookmark, :user_activity]
  
  def user_activity
    @user = User.find(params[:id])
    
    activity=Array.new
    #コメント
    @user.user_comments.each do |value|
      activity.push [0,value.id,value.product_id,value.created_at]
    end
    #リプライ
    @user.comment_replies.each do |value|
      activity.push [1,value.id,value.user_comment_id,value.created_at]
    end
    #フォロー
    @user.following_relationships.each do |value|
      activity.push [2,value.id,value.followed_id,value.created_at]
    end
    #お気に入り
    @user.favoriting_relationships.each do |value|
      activity.push [3,value.id,value.product_id,value.created_at]
    end
    #ブクマ
    @user.bookmarking_relationships.each do |value|
      activity.push [4,value.id,value.comment_id,value.created_at]
    end
    #日付けでソート
    #@activity=activity.sort { |a,b| b[3] <=> a[3] } # sort_byの方が早いらしい
    activity_=activity.sort_by(&:last).reverse
    #配列をページング
    @activitys = Kaminari.paginate_array(activity_).page(params[:page]).per(10)
    getFollow()
  end
  
  def user_bookmark
    @user = User.find(params[:id])
    # コメントをブクマした日付(新しい順)で取得
    comments_ids = Bookmark.where(user_id: @user.id).order(created_at: :desc).pluck(:comment_id)
    comments_ = @user.bookmarking_comments.sort_by{|o| comments_ids.index(o.id)}
    #配列をページング
    @comments = Kaminari.paginate_array(comments_).page(params[:page]).per(10)
    
    @reply = current_user.comment_replies.build if user_logged_in?
    getFollow()
  end
  
  def user_favorite
    @user = User.find(params[:id])
    # アプリをお気に入りした日付(新しい順)で取得
    products_ids = Favorite.where(user_id: @user.id).order(created_at: :desc).pluck(:product_id)
    products_ = @user.favoriting_products.sort_by{|o| products_ids.index(o.id)}
    #配列をページング
    @products = Kaminari.paginate_array(products_).page(params[:page]).per(10)
    getFollow()
  end
  
  def user_timeline
    @user = User.find(params[:id])
    @timeline = @user.timelines.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
    @reply = current_user.comment_replies.build if user_logged_in?
    getFollow()
  end
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @comments = @user.user_comments.order(created_at: :desc).page(params[:page]).per(10)
    @reply = current_user.comment_replies.build if user_logged_in?
    getFollow()
  end
  
  def getFollow
    # フォローイングユーザーをフォローした日付(新しい順)で取得
    followings_ids = UserFollow.where(follower_id: @user.id).order(created_at: :desc).pluck(:followed_id)
    @followings = @user.following_users.sort_by{|o| followings_ids.index(o.id)}
    # フォロワーユーザーをフォローされた日付(新しい順)で取得
    followers_ids = UserFollow.where(followed_id: @user.id).order(created_at: :desc).pluck(:follower_id)
    @followers = @user.follower_users.sort_by{|o| followers_ids.index(o.id)}
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
        redirect_to @user
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
        redirect_to @user
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
      redirect_to new_user_path
   
    elsif tmp_user
      # ユーザは既にあるが、本登録していない。一度ユーザーのトークンを全て使えなくする
      @user = tmp_user
      #Token.all.each do |token|
      @user.regist_user_tokens.all.each do |token|
        # 有効期限を変更する
        token.update_attributes!(expired_at: Time.now)
      end
      # 新しいトークン生成
      @token = SecureRandom.uuid
      # 有効期限は２４時間
      @user.regist_user_tokens.create!(uuid: @token, expired_at: 24.hours.since)
      # メール通知(ActionMailer)
      @mail = RegistConfirmMailer.regist_confirm_user(@user,@token).deliver
      # 仮登録成功ページヘ
      flash[:success] = "ご登録ありがとうございます！入力されたメールアドレスあてに、本登録用URLを送りましたのでご確認ください。"
      redirect_to root_path
    else
      @user = User.new(user_params)
      @user.status = false
      #binding.pry
      if @user.save(context: :signup)
        # トークン生成
        @token = SecureRandom.uuid
        @user.regist_user_tokens.create!(uuid: @token, expired_at: 24.hours.since)
        # メール通知
        @mail = RegistConfirmMailer.regist_confirm_user(@user,@token).deliver
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
    token = RegistUserToken.find_by_uuid(params[:uuid])
    # 有効期限を過ぎていないか確認
    if token && token.expired_at > Time.now
      # ２回目アクセスできないように更新
      token.update_attributes!(expired_at: Time.now)
      @user = token.user
      @user.update_attributes!(status: true)
      # 登録完了メール通知
      flash[:success] = "おめでとうございます！本登録が完了しました！"
      @mail = RegistConfirmMailer.regist_complet_user(@user).deliver
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
  
  #=======================
  #パスワードリマインダー
  #=======================
  def pass_reminder
  end
  
  def token_create
    email=params[:email]
    # 入力したメールアドレスのユーザが存在するか調べる
    @user = User.find_by_email(email)
    if @user
      #ユーザーのトークンを全て無効にする
      @user.pass_user_tokens.all.each do |token|
        token.update_attributes!(expired_at: Time.now) #有効期限を変更する
      end
      # 新しいトークン生成
      @token = SecureRandom.uuid
      # 有効期限は5分以内
      @user.pass_user_tokens.create!(uuid: @token, expired_at: 5.minutes.since)
      # メール送信
      @mail = PassRemindMailer.pass_remind_user(@user,@token).deliver
      flash[:success] = "#{email}あてにメールを送信しました。"
      redirect_to root_path
    else
      flash[:danger] = "「#{email}」は存在しないメールアドレスです。"
      redirect_to root_path
    end
  end
  
  def pass_token
    # 有効期限の確認
    uuid=params[:uuid]
    token = PassUserToken.find_by_uuid(uuid)
    # 有効期限を過ぎていないか確認
    if token && token.expired_at > Time.now
      # ２回目アクセスできないように更新
      token.update_attributes!(expired_at: Time.now)
      @user = token.user
      
      flash[:success] = "#{@user.nickname}様。パスワードを設定して下さい。"
      redirect_to reset_password_user_path(uuid: uuid)
    else
      flash[:danger] ="トークンの有効期限が切れている。もしくは、URLが適切ではありません。"
      redirect_to root_path
    end
  end
  
  def reset_password
    #binding.pry
    uuid=params[:uuid]
    token=PassUserToken.find_by_uuid(uuid)
    if token
      @user=token.user
    else
      render 'shared/_session_error'
    end
  end
  
  def update_password
    #binding.pry
    uuid=params[:user][:uuid]
    token=PassUserToken.find_by_uuid!(uuid)
    @user = token.user
    @user.attributes = user_params
    if @user.save(context: :pass_update)
      flash[:success] = "#{@user.nickname}様。パスワードを変更しました。"
      redirect_to root_path
    else
      flash[:danger] ="パスワードの変更に失敗しました。もう一度入力して下さい。"
      redirect_to reset_password_user_path(uuid: uuid)
    end
  end
    
  private
  
  # 存在チェック
  def is_are_you?
    unless User.find_by_id(params[:id])
      dev_store_location
      flash[:danger] = "セッションエラーが発生しました。存在しないIDです。"
      return redirect_to root_path
    end
  end
  
  def user_params
    params.require(:user).permit(:nickname, 
                                  :email,
                                  :password,
                                  :password_confirmation,
                                  :provider,
                                  :uid,
                                  :profile_img,
                                  :profile_img_cache,
                                  :remove_profile_img,
                                  :status,
                                  :profile,
                                  :product_mail_info)
  end
  
end

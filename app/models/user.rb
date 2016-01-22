class User < ActiveRecord::Base
  
  has_many :regist_user_tokens
  has_many :pass_user_tokens
  has_many :user_comments, :dependent => :delete_all
  has_many :comment_replies, :dependent => :delete_all
  
  #============================
  #イメージアップローダー
  #============================
  mount_uploader :profile_img, ProfileUploader

  #============================
  #バリデーション
  #============================
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save { self.email = email.downcase if self.email.present? } #空(SNS)でなければ
  validates :nickname, presence: true, length: { maximum: 50 },
                                            uniqueness: { case_sensitive: false },
                                            on: [:signup,:snslogin]
  validates :email, presence: true, length: { maximum: 255 },
                                            format: { with: VALID_EMAIL_REGEX },
                                            uniqueness: { case_sensitive: false },
                                            on: [:signup]
  
  validates :password,presence: true,on: [:pass_update]

  #=====================================================
  #OAuthの情報からユーザーを検索し、なければ新規レコード作成
  #=====================================================
  def self.find_or_create_from_auth(auth)
    #binding.pry
    if auth[:provider] == "twitter"
      nickname=auth[:info][:nickname]
    elsif auth[:provider] == "facebook"
      nickname=auth[:info][:name]
    elsif auth[:provider] == "google_oauth2"
      nickname=auth[:info][:name]
    end

    sns_user = User.find_or_initialize_by(provider: auth[:provider],
                                          uid: auth[:uid],
                                          nickname: nickname) do |user|
      #バリデーション対処、ダミーを入れる
      if auth[:provider] == "twitter"
        #user.email = Rails.application.secrets.twitter_login_key
        user.password = Rails.application.secrets.twitter_login_secret
      elsif auth[:provider] == "facebook"
        #user.email = Rails.application.secrets.facebook_login_key
        user.password = Rails.application.secrets.facebook_login_secret
      elsif auth[:provider] == "google_oauth2"
        #user.email = Rails.application.secrets.google_login_key
        user.password = Rails.application.secrets.google_login_secret
      end
    end

    if sns_user.new_record? #新規レコードだったら
      if sns_user.save(context: :snslogin) #保存成功
        $sns_create_flg=true
      else #保存失敗（バリデーションエラー:ニックネーム重複）
        $sns_create_flg=false
      end
    else #既存SNSユーザー
      $sns_create_flg=true
    end
    
    return sns_user
  end
  
end

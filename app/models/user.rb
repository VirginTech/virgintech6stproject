class User < ActiveRecord::Base
  
  has_secure_password
  
  #============================
  #バリデーション
  #============================
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save { self.email = email.downcase }
  validates :nickname, presence: true, length: { maximum: 50 },
                                            uniqueness: { case_sensitive: false },
                                            on: [:signup,:snslogin,:update]
  validates :email, presence: true, length: { maximum: 255 },
                                            format: { with: VALID_EMAIL_REGEX },
                                            uniqueness: { case_sensitive: false },
                                            on: [:signup,:update]

  #=====================================================
  #OAuthの情報からユーザーを検索し、なければ新規レコード作成
  #=====================================================
  def self.find_or_create_from_auth(auth)
    
    if auth[:provider] == "twitter"
      nickname=auth[:info][:nickname]
    elsif auth[:provider] == "facebook"
      nickname=auth[:info][:name]
    else
    end

    sns_user = User.find_or_initialize_by(uid: auth[:uid], nickname: nickname) do |user|
      #binding.pry
      if auth[:provider] == "twitter"
        user.email = Rails.application.secrets.twitter_login_key
        user.password = Rails.application.secrets.twitter_login_secret
      elsif auth[:provider] == "facebook"
        user.email = 'facebook@account.user'
        user.password = 'facebook'
      else
      end
    end

    if sns_user.new_record? #新規レコードだったら
      if sns_user.save(context: :snslogin) #保存成功
        $sns_create_flg=true
        return sns_user
      else #保存失敗（バリデーションエラー:ニックネーム重複）
        $sns_create_flg=false
      end
    else #既存SNSユーザー
      $sns_create_flg=true
      return sns_user
    end
    
  end
  
end

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

  #============================
  # フォロー・フォロワー
  #============================
  has_many :following_relationships, class_name:  "UserFollow",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  has_many :following_users, through: :following_relationships, source: :followed  
  
  has_many :follower_relationships, class_name:  "UserFollow",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  
  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  # 自分とフォローしているユーザーのつぶやきを全部取得
  def timelines
    UserComment.where(user_id: following_user_ids + [self.id])
  end

  #===========================
  #お気に入り(正引：ユーザー〜プロダクト)
  #===========================
  has_many :favoriting_relationships, class_name:  "Favorite",
                                            foreign_key: "user_id",
                                            dependent:   :destroy
  has_many :favoriting_products, through: :favoriting_relationships, source: :product
  
  # アプリをお気に入りする
  def favoriting(other_product)
    favoriting_relationships.create(product_id: other_product.id)
  end

  # お気に入りを解除する
  def unfavoriting(other_product)
    favoriting_relationships.find_by(product_id: other_product.id).destroy
  end

  # アプリをお気に入りしてるかどうか？
  def favoriting?(other_product)
    favoriting_products.include?(other_product)
  end
  
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

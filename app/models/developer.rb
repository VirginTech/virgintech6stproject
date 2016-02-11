class Developer < ActiveRecord::Base
  
  has_many :regist_dev_tokens, :dependent => :delete_all
  has_many :pass_dev_tokens, :dependent => :delete_all
  has_many :products, :dependent => :destroy
  has_many :dev_comments, :dependent => :delete_all
  
  #============================
  #イメージアップローダー
  #============================
  mount_uploader :profile_img, ProfileUploader
  
  #============================
  #バリデーション
  #============================
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 },
                                            uniqueness: { case_sensitive: false },
                                            on: [:signup,:update]
  validates :email, presence: true, length: { maximum: 255 },
                                            format: { with: VALID_EMAIL_REGEX },
                                            uniqueness: { case_sensitive: false },
                                            on: [:signup,:update]  
  validates :password,presence: true,on: [:pass_update]
end

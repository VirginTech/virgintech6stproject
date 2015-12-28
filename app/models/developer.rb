class Developer < ActiveRecord::Base
  
  has_many :products
  
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

end

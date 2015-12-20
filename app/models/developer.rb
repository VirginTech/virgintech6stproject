class Developer < ActiveRecord::Base
  
  has_secure_password
  
  #============================
  #バリデーション
  #============================
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

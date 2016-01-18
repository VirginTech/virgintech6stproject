class UserComment < ActiveRecord::Base
  
  belongs_to :product
  belongs_to :user

  #============================
  #イメージアップローダー
  #============================
  mount_uploader :image, UserCommentImgUploader
  
  #=====================
  # バリデーション
  #=====================
  validates :user_id, presence: true
  validates :comment, presence: true, length: { maximum: 300 }
  
end

class DevComment < ActiveRecord::Base
  
  belongs_to :product
  belongs_to :developer

  #============================
  #イメージアップローダー
  #============================
  mount_uploader :image, UserCommentImgUploader
  
  #=====================
  # バリデーション
  #=====================
  validates :developer_id, presence: true
  validates :comment, presence: true, length: { maximum: 500 }

end

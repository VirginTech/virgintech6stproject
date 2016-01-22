class CommentReply < ActiveRecord::Base

  belongs_to :user_comment
  belongs_to :user

  #============================
  #イメージアップローダー
  #============================
  mount_uploader :image, UserCommentImgUploader
  
  #=====================
  # バリデーション
  #=====================
  validates :user_id, presence: true
  validates :reply_comment, presence: true, length: { maximum: 150 }

end

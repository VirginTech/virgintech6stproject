class UserComment < ActiveRecord::Base
  
  belongs_to :product
  belongs_to :user
  has_many :comment_replies, :dependent => :delete_all

  #============================
  #イメージアップローダー
  #============================
  mount_uploader :image, UserCommentImgUploader
  
  #=====================
  # バリデーション
  #=====================
  validates :user_id, presence: true
  validates :comment, presence: true, length: { maximum: 300 }
  
  #===========================
  #ブックマーク(逆引：コメント〜ユーザー)
  #===========================
  has_many :bookmarked_relationships, class_name:  "Bookmark",
                                          foreign_key: "comment_id",
                                          dependent:   :destroy
  has_many :bookmarked_users, through: :bookmarked_relationships, source: :user
  
end

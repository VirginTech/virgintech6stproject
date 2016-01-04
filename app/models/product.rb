class Product < ActiveRecord::Base
  
  belongs_to :developer

  #============================
  #イメージアップローダー
  #============================
  mount_uploader :img_icon, ProductIconUploader

  #============================
  #バリデーション
  #============================
  attr_accessor :model

  validates :appname, presence: true, length: { maximum: 50 }
  validates :summary, presence: true, length: { maximum: 250 }
  validates :description, presence: true
  validates :category, presence: true
  validates :price, presence: true
  validates :model, present_model: true
  validates :img_icon, presence: true
  
end

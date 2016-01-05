class Product < ActiveRecord::Base
  
  belongs_to :developer

  #============================
  #イメージアップローダー
  #============================
  mount_uploader :img_icon, ProductIconUploader
  mount_uploader :img_screenshot_01, ProductScreenShotUploader
  mount_uploader :img_screenshot_02, ProductScreenShotUploader
  mount_uploader :img_screenshot_03, ProductScreenShotUploader
  mount_uploader :img_screenshot_04, ProductScreenShotUploader
  mount_uploader :img_screenshot_05, ProductScreenShotUploader
  
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
  validates :img_screenshot_01, presence: true
  validates :sale_date, presence: true
  
end

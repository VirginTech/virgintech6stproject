class Product < ActiveRecord::Base
  
  belongs_to :developer

  #============================
  #バリデーション
  #============================
  validates :appname, presence: true, length: { maximum: 50 }
  validates :summary, presence: true, length: { maximum: 250 }

end

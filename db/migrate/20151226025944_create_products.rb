class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :developer, index: true
      t.string :appname
      t.text :summary
      t.text :description
      t.integer :category
      t.integer :price
      t.boolean :model_iphone
      t.boolean :model_android
      t.boolean :model_web
      t.string :img_icon
      t.string :img_screenshot_01
      t.string :img_screenshot_02
      t.string :img_screenshot_03
      t.string :img_screenshot_04
      t.string :img_screenshot_05
      t.date :sale_date
      t.string :store_iphone_url
      t.string :store_android_url
      t.string :store_webgame_url
      t.string :official_site
      t.string :twitter
      t.string :facebook
      t.string :etc_site
      t.string :youtube_url
      t.text :update_info
      t.text :operating_notes
      t.text :how_to_play
      t.text :features_cheats
      t.text :history_of_develop
      t.text :word_to_user
      t.text :finally_something

      t.timestamps null: false
      
      t.index [:developer_id, :created_at]
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :email
      t.string :password_digest
      t.string :provider
      t.string :uid
      t.string :profile_img
      t.boolean :status # 本登録済み確認用
      t.text :profile
      t.boolean :product_mail_info
      
      t.timestamps null: false
      
      t.index :email, unique: true
      t.index :nickname, unique: true
    end
  end
end

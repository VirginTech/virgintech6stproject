class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :email
      t.string :password_digest

      t.timestamps null: false
      
      t.index :email, unique: true
      t.index :nickname, unique: true
    end
  end
end

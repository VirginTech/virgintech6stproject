class CreateDevelopers < ActiveRecord::Migration
  def change
    create_table :developers do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :profile_img
      t.boolean :status
      t.text :profile
      
      t.string :website
      t.string :twitter
      t.string :facebook
      t.string :google
      t.string :official_site
      t.string :contact_email

      t.timestamps null: false
      
      t.index :email, unique: true
      t.index :name, unique: true
    end
  end
end

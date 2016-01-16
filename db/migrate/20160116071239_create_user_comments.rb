class CreateUserComments < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.references :user, index: true
      t.references :product, index: true
      t.text :comment
      t.string :image

      t.timestamps null: false
    end
  end
end

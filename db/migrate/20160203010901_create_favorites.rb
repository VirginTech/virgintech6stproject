class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user, index: true
      t.references :product, index: true

      t.timestamps null: false
      t.index [:user_id, :product_id], unique: true 
    end
  end
end

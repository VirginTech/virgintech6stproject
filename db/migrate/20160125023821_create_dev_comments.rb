class CreateDevComments < ActiveRecord::Migration
  def change
    create_table :dev_comments do |t|
      t.references :developer, index: true
      t.references :product, index: true
      t.text :comment
      t.string :image

      t.timestamps null: false
    end
  end
end

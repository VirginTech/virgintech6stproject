class CreateUserFollows < ActiveRecord::Migration
  def change
    create_table :user_follows do |t|
      t.references :follower, index: true
      t.references :followed, index: true

      t.timestamps null: false
      t.index [:follower_id, :followed_id], unique: true 
    end
  end
end

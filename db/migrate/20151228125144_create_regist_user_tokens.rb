class CreateRegistUserTokens < ActiveRecord::Migration
  def change
    create_table :regist_user_tokens do |t|

      t.references :user, null: false     # ユーザと紐付け
      t.string :uuid, null: false         # トークン
      t.datetime :expired_at, null: false
      
      t.timestamps null: false
    end
    
    add_index :regist_user_tokens, :user_id
    
  end
end

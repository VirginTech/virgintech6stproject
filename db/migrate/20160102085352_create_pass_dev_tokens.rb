class CreatePassDevTokens < ActiveRecord::Migration
  def change
    create_table :pass_dev_tokens do |t|

      t.references :developer, null: false     # ユーザと紐付け
      t.string :uuid, null: false         # トークン
      t.datetime :expired_at, null: false

      t.timestamps null: false
    end
    add_index :pass_dev_tokens, :developer_id
  end
end

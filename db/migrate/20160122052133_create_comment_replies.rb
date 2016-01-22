class CreateCommentReplies < ActiveRecord::Migration
  def change
    create_table :comment_replies do |t|
      t.references :user, index: true
      t.references :user_comment, index: true
      t.text :reply_comment
      t.string :image

      t.timestamps null: false
    end
  end
end

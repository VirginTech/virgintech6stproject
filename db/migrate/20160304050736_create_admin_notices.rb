class CreateAdminNotices < ActiveRecord::Migration
  def change
    create_table :admin_notices do |t|

      t.date :release_date
      t.string :subject
      t.text :notice_body

      t.timestamps null: false
    end
  end
end

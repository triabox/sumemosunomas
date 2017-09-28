class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.boolean :is_view
      t.string :mensaje
      t.string :link
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

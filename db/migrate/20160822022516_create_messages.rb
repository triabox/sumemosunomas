class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_user_id
      t.integer :subject_user_id
      t.string :text
      t.integer :is_view

      t.timestamps null: false
    end
  end
end

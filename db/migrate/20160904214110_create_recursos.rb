class CreateRecursos < ActiveRecord::Migration
  def change
    create_table :recursos do |t|
      t.string :nombre
      t.integer :user_id
      t.references :curso, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end

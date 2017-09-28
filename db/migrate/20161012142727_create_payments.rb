class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :name
      t.string :description
      t.string :external_id
      t.string :external_referent
      t.decimal :amount
      t.timestamps null: false
    end
  end
end

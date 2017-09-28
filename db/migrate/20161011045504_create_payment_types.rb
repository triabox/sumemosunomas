class CreatePaymentTypes < ActiveRecord::Migration
  def change
    create_table :payment_types do |t|
      t.string :name
      t.string :description
      t.string :tipe
      t.integer :user_id
      t.string :authorization
      t.string :merchant

      t.timestamps null: false
    end
  end
end

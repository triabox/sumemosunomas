class AddStateToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :state, :boolean
  end
end

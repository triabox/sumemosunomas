class AddPaymentIdToInscriptos < ActiveRecord::Migration
  def change
    add_column :inscriptos, :payment_id, :integer
  end
end

class AddTipeToInscriptos < ActiveRecord::Migration
  def change
    add_column :inscriptos, :tipe, :string
  end
end

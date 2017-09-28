class AddTipeToRecurso < ActiveRecord::Migration
  def change
    add_column :recursos, :tipe, :string
  end
end
class AddConseguidoToRecursos < ActiveRecord::Migration
  def change
    add_column :recursos, :conseguido, :boolean , default: :false
  end
end

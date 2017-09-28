class AddDescriptionToRecurso < ActiveRecord::Migration
  def change
    add_column :recursos, :description, :string
  end
end

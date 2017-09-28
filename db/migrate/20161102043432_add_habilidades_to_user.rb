class AddHabilidadesToUser < ActiveRecord::Migration
  def change
    add_column :users, :habilidades, :string
  end
end

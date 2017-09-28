class AddExperienciaToUser < ActiveRecord::Migration
  def change
    add_column :users, :experiencia, :string
  end
end

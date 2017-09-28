class AddNotasToUser < ActiveRecord::Migration
  def change
    add_column :users, :notas, :string
  end
end

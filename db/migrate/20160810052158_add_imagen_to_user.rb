class AddImagenToUser < ActiveRecord::Migration
  def change
    add_column :users, :imagen, :string
  end
end

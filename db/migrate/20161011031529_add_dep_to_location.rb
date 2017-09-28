class AddDepToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :dep, :string
  end
end

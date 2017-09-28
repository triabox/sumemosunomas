class AddFloorToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :floor, :integer
  end
end

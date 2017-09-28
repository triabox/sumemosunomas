class AddUserToReputacion < ActiveRecord::Migration
  def change
    add_column :reputacions, :user_id, :integer
  end
end
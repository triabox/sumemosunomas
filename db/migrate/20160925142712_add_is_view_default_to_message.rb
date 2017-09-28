class AddIsViewDefaultToMessage < ActiveRecord::Migration
  def change
    remove_column :messages, :is_view
    add_column :messages, :is_view, :boolean, default: false
  end
end

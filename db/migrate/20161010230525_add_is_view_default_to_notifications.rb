class AddIsViewDefaultToNotifications < ActiveRecord::Migration
  def change
    remove_column :notifications, :is_view
    add_column :notifications, :is_view, :boolean, default: false
  end
end



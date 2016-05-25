class AddDisplayToggleToOptimadminMenuItems < ActiveRecord::Migration
  def change
    add_column :optimadmin_menu_items, :display, :boolean, default: true, null: false
  end
end

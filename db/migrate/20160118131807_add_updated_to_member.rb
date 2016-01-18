class AddUpdatedToMember < ActiveRecord::Migration
  def change
    add_column :members, :updated, :boolean
    add_column :member_locations, :updated, :boolean
  end
end

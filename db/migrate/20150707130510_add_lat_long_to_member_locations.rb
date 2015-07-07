class AddLatLongToMemberLocations < ActiveRecord::Migration
  def change
    add_column :member_locations, :latitude, :float
    add_column :member_locations, :longitude, :float
  end
end

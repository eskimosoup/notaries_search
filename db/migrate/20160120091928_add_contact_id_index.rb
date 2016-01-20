class AddContactIdIndex < ActiveRecord::Migration
  def change
    add_index :members, :contact_id, unique: true
  end
end

class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :contact_id
      t.column :status, "enum('active', 'paused', 'deleted')"
      t.column :role, "enum('USER', 'DESIGNER')"
      t.string :email, limit: 200
      t.string :title, limit: 10
      t.string :firstname, limit: 100
      t.string :lastname, limit: 100
      t.string :username
      t.string :password, limit: 200
      t.text :notes
      t.string :forgotten_hash, limit: 32
      t.integer :lastlogin
      t.integer :created
      t.integer :modified

      t.timestamps null: false
    end
  end
end

class CreateMemberLocations < ActiveRecord::Migration
  def change
    create_table :member_locations do |t|
      t.belongs_to :member, index: true, foreign_key: true
      t.string :dx_number, limit: 50
      t.string :contact_phone, limit: 50
      t.string :contact_mobile, limit: 50
      t.string :fax, limit: 50
      t.string :website
      t.text :address
      t.string :town, limit: 100
      t.string :county, limit: 100
      t.string :postcode, limit: 10
      t.string :email, limit: 200

      t.timestamps null: false
    end
  end
end

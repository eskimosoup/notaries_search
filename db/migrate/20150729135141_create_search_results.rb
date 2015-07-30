class CreateSearchResults < ActiveRecord::Migration
  def change
    create_table :search_results do |t|
      t.belongs_to :search, index: true, foreign_key: true
      t.belongs_to :member_location, index: true, foreign_key: true
      t.float :distance
      t.timestamps null: false
    end
  end
end

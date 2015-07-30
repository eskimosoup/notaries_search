class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :first_name
      t.string :last_name
      t.string :town
      t.string :county
      t.string :postcode
      t.integer :radius, default: 5
      t.boolean :show_all, default: false
      t.integer :search_results_count, default: 0

      t.timestamps null: false
    end
  end
end

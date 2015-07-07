class CreateNotariesSocietyUploads < ActiveRecord::Migration
  def change
    create_table :notaries_society_uploads do |t|

      t.timestamps null: false
    end
  end
end

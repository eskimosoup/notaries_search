class CreateMemberPageViews < ActiveRecord::Migration
  def change
    create_table :member_page_views do |t|
      t.belongs_to :member, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

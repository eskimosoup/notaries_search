class CreateMemberMonthlyReports < ActiveRecord::Migration
  def change
    create_table :member_monthly_reports do |t|
      t.belongs_to :member, index: true, foreign_key: true
      t.date :date, null: false
      t.integer :view_count, null: false, default: 0
      t.integer :search_results_count, null: false, default: 0

      t.timestamps null: false
    end
  end
end

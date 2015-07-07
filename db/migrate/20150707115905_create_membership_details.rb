class CreateMembershipDetails < ActiveRecord::Migration
  def change
    create_table :membership_details do |t|
      t.belongs_to :member, index: true, foreign_key: true
      t.string :country_code, limit: 5
      t.column :in_practice, "enum('Y', 'N')"
      t.column :is_admin, "enum('Y', 'N')"
      t.column :is_member, "enum('Y', 'N')"
      t.column :is_student, "enum('Y', 'N')"
      t.column :is_council_member, "enum('Y', 'N')"
      t.column :is_treasurer, "enum('Y', 'N')"
      t.column :is_secretary, "enum('Y', 'N')"
      t.column :is_education_secretary, "enum('Y', 'N')"
      t.column :vice_president, "enum('Y', 'N')"
      t.string :vice_president_date, limit: 64
      t.column :president, "enum('Y', 'N')"
      t.string :president_date, limit: 64
      t.column :past_president, "enum('Y', 'N')"
      t.string :past_president_date, limit: 64
      t.integer :date_of_election
      t.string :membership_class, limit: 128
      t.string :faculty_date, limit: 128
      t.string :date_joined, limit: 128
      t.datetime :date_subscription_paid
      t.string :date_retired, limit: 15
      t.string :date_struck_off_membership, limit: 15
      t.string :date_died, limit: 15

      t.timestamps null: false
    end
  end
end

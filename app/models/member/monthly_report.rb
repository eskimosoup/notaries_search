class Member::MonthlyReport < ActiveRecord::Base
  belongs_to :member

  scope :for_month, ->(date) { where('year(member_monthly_reports.created_at) = ? and month(member_monthly_reports.created_at) = ?', date.year, date.month) }

  validates :member, presence: true
  validates :date, presence: true, uniqueness: { scope: :member_id }
  validates :view_count, :search_results_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << ["Member Name", "Date", "View Count", "Search Results Count"]
      all.each do |monthly_report|
        csv << monthly_report.csv_row
      end
    end
  end

  def csv_row
    [member.full_name, date.strftime("%B %Y"), view_count, search_results_count]
  end
end

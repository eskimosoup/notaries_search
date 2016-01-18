class CreateMemberMonthlyReports

  attr_reader :date

  def initialize(month:, year:)
    @date = Date.new(year, month, 1)
  end

  def call
    Member.displayed.find_each do |member|
      member.monthly_reports.find_or_create_by(date: date) do |monthly_report|
        monthly_report.update(view_count: view_count(member), search_results_count: search_results_count(member))
      end
    end
  end

  def view_count(member)
    MemberPageView.where(member: member).for_month(date).count
  end

  def search_results_count(member)
    SearchResult.joins(:member_location).where(member_locations: { member_id: member.id }).for_month(date).count
  end
end

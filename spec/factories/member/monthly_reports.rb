FactoryGirl.define do
  factory :monthly_report, class: Member::MonthlyReport do
    member
    date { Date.today }
    view_count 0
    search_results_count 0
  end
end
require 'rails_helper'

RSpec.describe Member::MonthlyReport, type: :model do
  describe "validations", :validation do
    subject(:monthly_report) { create(:monthly_report) }
    it { should validate_presence_of(:member) }
    it { should validate_presence_of(:date) }
    it { should validate_uniqueness_of(:date).scoped_to(:member_id) }
    it { should validate_presence_of(:view_count) }
    it { should validate_numericality_of(:view_count).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:search_results_count) }
    it { should validate_numericality_of(:search_results_count).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe "associations", :association do
    it { should belong_to(:member) }
  end

end

require 'rails_helper'

RSpec.describe CreateMemberMonthlyReports do
  describe "sets date correctly" do
    subject(:create_member_monthly_reports) { CreateMemberMonthlyReports.new(month: Date.today.month, year: Date.today.year) }
    it "returns the date at the beginning of the month" do
      expect(create_member_monthly_reports.date).to eq(Date.today.beginning_of_month)
    end
  end

  describe "returns monthly page views for the month" do
    let!(:member) { create(:member) }
    before(:each) do
      create_list(:member_page_view, 5, member: member, created_at: Date.today)
      create_list(:member_page_view, 8, member: member, created_at: (Date.today - 1.month))
      create_list(:member_page_view, 13, member: member, created_at: (Date.today - 2.months))
    end

    it "should return 5 views for this month" do
      date = Date.today
      report_creator = CreateMemberMonthlyReports.new(month: date.month, year: date.year)
      expect(report_creator.view_count(member)).to eq(5)
    end

    it "should return 8 views for last month" do
      date = Date.today - 1.month
      report_creator = CreateMemberMonthlyReports.new(month: date.month, year: date.year)
      expect(report_creator.view_count(member)).to eq(8)
    end

    it "should return 13 views for 2 months ago" do
      date = Date.today - 2.months
      report_creator = CreateMemberMonthlyReports.new(month: date.month, year: date.year)
      expect(report_creator.view_count(member)).to eq(13)
    end

    it "should return 0 views for next month" do
      date = Date.today + 1.month
      report_creator = CreateMemberMonthlyReports.new(month: date.month, year: date.year)
      expect(report_creator.view_count(member)).to eq(0)
    end
  end

  describe "returns monthly page views for the month" do
    let!(:member_location) { create(:member_location) }
    before(:each) do
      create_list(:search_result, 5, member_location: member_location, created_at: Date.today)
      create_list(:search_result, 8, member_location: member_location, created_at: (Date.today - 1.month))
      create_list(:search_result, 13, member_location: member_location, created_at: (Date.today - 2.months))
    end

    it "should return 5 views for this month" do
      date = Date.today
      report_creator = CreateMemberMonthlyReports.new(month: date.month, year: date.year)
      expect(report_creator.search_results_count(member_location.member)).to eq(5)
    end

    it "should return 8 views for last month" do
      date = Date.today - 1.month
      report_creator = CreateMemberMonthlyReports.new(month: date.month, year: date.year)
      expect(report_creator.search_results_count(member_location.member)).to eq(8)
    end

    it "should return 13 views for 2 months ago" do
      date = Date.today - 2.months
      report_creator = CreateMemberMonthlyReports.new(month: date.month, year: date.year)
      expect(report_creator.search_results_count(member_location.member)).to eq(13)
    end

    it "should return 0 views for next month" do
      date = Date.today + 1.month
      report_creator = CreateMemberMonthlyReports.new(month: date.month, year: date.year)
      expect(report_creator.search_results_count(member_location.member)).to eq(0)
    end
  end
end
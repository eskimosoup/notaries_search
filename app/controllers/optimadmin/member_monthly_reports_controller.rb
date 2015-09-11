module Optimadmin
  class MemberMonthlyReportsController < ApplicationController

    def index
      @monthly_report_dates = Member::MonthlyReport.group(:date).order(date: :desc).pluck(:date)
    end

    def csv
      date = Date.new(params[:year].to_i, params[:month].to_i, 1)
      @monthly_reports = Member::MonthlyReport.for_month(date)
      send_data @monthly_reports.to_csv, filename: "member-report-#{ date }.csv"
    end
  end
end

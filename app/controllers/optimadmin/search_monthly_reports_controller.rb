module Optimadmin
  class SearchMonthlyReportsController < ApplicationController

    def index
      @monthly_report_dates = Search.group("year(created_at)").group("month(created_at)").order(created_at: :desc).pluck(:created_at)
    end

    def csv
      date = Date.new(params[:year].to_i, params[:month].to_i, 1)
      @search_results = Search.for_month(date)
      send_data @search_results.to_csv, filename: "search-result-report-#{ date }.csv"
    end
  end
end

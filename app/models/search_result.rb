class SearchResult < ActiveRecord::Base
  belongs_to :search, counter_cache: true
  belongs_to :member_location

  scope :for_month, ->(date) { where('year(search_results.created_at) = ? and month(search_results.created_at) = ?', date.year, date.month) }

end

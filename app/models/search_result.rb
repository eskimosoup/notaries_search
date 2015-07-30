class SearchResult < ActiveRecord::Base
  belongs_to :search, counter_cache: true
  belongs_to :member_location
end

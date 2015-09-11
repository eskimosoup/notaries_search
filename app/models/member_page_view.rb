class MemberPageView < ActiveRecord::Base
  belongs_to :member, counter_cache: true
  scope :for_month, ->(date) { where('year(member_page_views.created_at) = ? and month(member_page_views.created_at) = ?', date.year, date.month) }
end

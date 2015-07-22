class Member < ActiveRecord::Base
  has_many :member_locations, dependent: :destroy
  has_many :member_page_views, dependent: :destroy
  has_one :membership_detail, dependent: :destroy
end

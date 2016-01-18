class Member < ActiveRecord::Base
  default_scope { where updated: true } 

  has_many :member_locations, -> { displayed }, dependent: :destroy
  has_many :member_page_views, dependent: :destroy
  has_many :monthly_reports, dependent: :destroy
  has_one :membership_detail, dependent: :destroy

  scope :displayed, -> { where updated: true }

  def full_name
    [firstname, lastname].compact.join(" ")
  end
end

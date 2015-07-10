class Member < ActiveRecord::Base
  has_many :member_locations, dependent: :destroy
  has_one :membership_detail, dependent: :destroy

  def self.name_search(name, show_all)
    if name.match(/\s/)
      first = name.split(' ').first
      last = name.split(' ').last
      search_type = 'AND'
    else
      first = last = name
      search_type = 'OR'
    end
    if show_all.present?
      where(" firstname LIKE :first #{search_type} lastname LIKE :last ", first: "#{first}%", last: "#{last}%").order(:firstname, :lastname)
    else
      where(" firstname LIKE :first #{search_type} lastname LIKE :last ", first: "#{first}%", last: "#{last}%").in_practice.order(:firstname, :lastname)
    end
  end

  def self.in_practice(limit = nil)
    joins(:membership_detail).where(membership_details: { in_practice: 'Y', is_admin: 'N' }).limit(limit)
  end
end

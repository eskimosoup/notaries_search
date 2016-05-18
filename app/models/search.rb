class Search < ActiveRecord::Base
  has_many :search_results
  has_many :member_locations, through: :search_results

  scope :for_month, ->(date) { where('year(searches.created_at) = ? and month(searches.created_at) = ?', date.year, date.month) }

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << ["Date", "Search Type", "Number of Results"]
      all.each do |search|
        csv << search.csv_row
      end
    end
  end

  def csv_row
    [created_at.strftime("%b %d %Y"), type_of_search, search_results_count]
  end

  before_save :set_member_locations

  def name
    return nil if first_name.nil? && last_name.nil?
    [first_name, last_name].uniq.join(" ")
  end

  def result_information
    [number_of_notaries_found, radius_and_postcode_infomation, town_information, name_infomation].compact.join(" ")
  end

  def name_search_type
    if first_name == last_name
      'OR'
    else
      'AND'
    end
  end

  def type_of_search
    return "Name" if name
    return "Town" if town && !postcode
    return "Location" if postcode
    "Blank Search"
  end

  private

  def set_member_locations
    results = search_by_type
    results = results.joins(:membership_detail).where("membership_details.in_practice = ? AND membership_details.is_admin = ? AND membership_details.membership_class <> ''", 'Y', 'N') unless show_all
    results = results.joins(:membership_detail).where("membership_details.membership_class <> ''") if show_all
    results = results.group(:member_id).limit(50)
    results.map{|x| { member_location_id: x.id, distance: x.try(:distance) } }.each do |search_result_hash|
      search_results.build(search_result_hash)
    end
  end

  def search_by_type
    if postcode
      find_location_members
    else
      standard_search
    end
  end

  def find_location_members
    results = MemberLocation.near("#{postcode}+united+kingdom", radius)
    if results.length < 1 && radius < 50
      self.radius += 5
      find_location_members
    else
      results
    end
  end

  def standard_search
    results = MemberLocation.where(nil)
    if first_name.present? && last_name.present?
      results = results.joins(:member).where("members.firstname LIKE :first #{name_search_type} members.lastname LIKE :last ", first: "#{first_name}%", last: "#{last_name}%")
    elsif first_name.present?
      results = results.joins(:member).where("members.firstname LIKE :search OR members.lastname LIKE :search", search: "#{first_name}%") 
    end
    results = results.where(town: town) if town
    results = results.where(county: county) if county
    results
  end

  def number_of_notaries_found
    "We found #{ ActionController::Base.helpers.pluralize(search_results_count, "notary", "notaries") }"
  end

  def radius_and_postcode_infomation
    "within #{ radius } miles of #{ postcode }" if postcode
  end

  def town_information
    "in #{ town }" if town && !postcode
  end

  def name_infomation
    "matching #{ name }" if name
  end

end

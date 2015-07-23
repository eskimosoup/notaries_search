class MemberLocationSearch

  MAX_RADIUS = 20

  attr_reader :town, :county, :name, :show_all, :name_search_type, :first_name, :last_name, :postcode
  attr_accessor :radius
  # search params: name, town, county, postcode, radius
  def initialize(search_params, show_all)
    search_params = search_params.reject{|k,v| v.blank? }
    @town, @county = split_town_and_county(search_params[:town])
    @name = search_params[:name]
    @postcode = search_params[:postcode]
    @first_name, @last_name, @name_search_type = split_name if @name
    @radius = search_params[:radius].to_i || 5 if search_params[:radius]
    @show_all = show_all
  end

  def call
    results = get_results
    [ results, radius, results_information(results.length) ]
  end

  private

  def get_results
    results = search_by_type
    results = results.joins(:membership_detail).where(membership_details: { in_practice: 'Y', is_admin: 'N' }) unless show_all
    results = results.group(:member_id).limit(50)
    results
  end

  def search_by_type
    if radius
      find_location_members
    else
      standard_search
    end
  end

  def find_location_members
    results = MemberLocation.near("#{postcode}", radius)
    if results.length < 1 && radius < 50
      @radius += 5
      find_location_members
    else
      results
    end
  end

  def standard_search
    results = MemberLocation.where(nil)
    results = results.joins(:member).where("members.firstname LIKE :first #{name_search_type} members.lastname LIKE :last ", first: "#{first_name}%", last: "#{last_name}%") if name
    results = results.where(town: town) if town
    results = results.where(county: county) if county
    results
  end

  def split_name
    split = name.split(' ')
    first_name = split.first
    last_name = split.last
    search_type = search_type(first_name, last_name)
    [first_name, last_name, search_type]
  end

  def search_type(first_name, last_name)
    if first_name == last_name
      'OR'
    else
      'AND'
    end
  end

  def results_information(number)
    str = "We found #{ number } notaries"
    str << " within #{ radius } miles of #{ postcode }" if radius
    str << " in #{ town }" if town && !radius
    str << " matching #{ name }" if name
    str
  end

  def split_town_and_county(town_and_county)
    dirty_town, dirty_county = town_and_county.split("(")
    town = dirty_town.rstrip
    county = dirty_county.chop #remove closing space
    [town, county]
  end
end

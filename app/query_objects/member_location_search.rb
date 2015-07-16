class MemberLocationSearch

  MAX_RADIUS = 20

  attr_reader :town, :county, :name, :show_all, :name_search_type, :first_name, :last_name
  attr_accessor :radius
  # search params: name, town, county, postcode, radius
  def initialize(search_params, show_all)
    search_params = search_params.reject{|k,v| v.blank? }
    @town = search_params[:town]
    @name = search_params[:name]
    @first_name, @last_name, @name_search_type = split_name if @name
    @radius = search_params[:radius].to_i || 5 if search_params[:radius]
    @show_all = show_all
  end

  def call
    if radius
      results = location_search
    else
      results = standard_search
    end
    [ results.uniq.limit(50), radius, results_information(results.size) ]
  end

  private

  def location_search
    results = find_location_members
    #results = MemberLocation.near(postcode, radius)
    #while results.size < 1
    #  results = MemberLocation.near("#{postcode}+United+Kingdom", radius)
    #end
    results = results.joins(:member).where("members.firstname LIKE :first #{name_search_type} members.lastname LIKE :last ", first: "#{first_name}%", last: "#{last_name}%") if name
    results = results.joins(:membership_detail).where(membership_details: { in_practice: 'Y', is_admin: 'N' }) if show_all
    results
  end

  def find_location_members
    results = MemberLocation.near("#{town}", radius)
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

  def results_information(size)
    str = "We found #{ size } notaries"
    str << " within #{ radius } miles of #{ town }" if radius
    str << " in #{ town }" if town && !radius
    str << " matching #{ name }" if name
    str
  end
end
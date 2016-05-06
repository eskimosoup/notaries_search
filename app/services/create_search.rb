class CreateSearch
  attr_reader :params, :show_all
  def initialize(params, show_all)
    @params = params.reject { |_k, v| v.blank? }
    @show_all = show_all
  end

  def save
    Search.create(search_hash)
  end

  def search_hash
    hash = split_name
    hash.merge(split_town_and_county).merge(postcode_and_radius).merge(show_all: show_all)
  end

  def split_name
    return {} if params[:name].nil?
    # first_name, *middle_names, last_name = params[:name].split(' ')
    # last_name ||= first_name
    # { first_name: first_name, last_name: last_name }

    split_name = params[:name].split(' ')
    first = split_name.first
    split = params[:name].split(' ')
    first, *last = split
    last = last.join(' ')

    { first_name: first, last_name: last }
  end

  def split_town_and_county
    return {} if params[:town].nil?
    dirty_town, dirty_county = params[:town].split('(')
    town = dirty_town.rstrip
    county = dirty_county.chop # remove closing space
    { town: town, county: county }
  end

  def postcode_and_radius
    return {} if params[:postcode].nil? || params[:radius].nil?
    {
      postcode: params[:postcode],
      radius: params[:radius]
    }
  end
end

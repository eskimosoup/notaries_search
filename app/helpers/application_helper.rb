module ApplicationHelper
  def find_location_members(search_term, radius, show_all)
    results = MemberLocation.location_search("#{search_term}+United+Kingdom", radius, show_all)
    if results.length < 1
      find_location_members(search_term, radius + 2, show_all)
    else
      [results, radius]
    end
  end
end

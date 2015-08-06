module ApplicationHelper
  # http://stackoverflow.com/a/7908693
  def smart_add_url_protocol(url)
    "http://#{url}" unless url[/^http:\/\//] || url[/^https:\/\//]
  end
end

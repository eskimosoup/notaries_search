class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper

  before_action :global_site_settings

  def index
    # Yes, this is horrible. Yes, I want to fix it. No, I don't know how to implement componentRestrictions with Geocoder gem.
    if params[:search_term].present?
      member_locations = find_location_members("#{params[:search_term]}+United+Kingdom", params[:radius].to_i, cookies[:allowed])
      @member_locations = member_locations.first.limit(10)
      @radius = member_locations.last
      @member_locations_count = member_locations.first
    end
    @members = Member.name_search(params[:name], cookies[:allowed]) if params[:name].present?
  end

  private

  def global_site_settings
    @global_site_settings ||= Optimadmin::SiteSetting.current_environment
  end
  helper_method :global_site_settings
end

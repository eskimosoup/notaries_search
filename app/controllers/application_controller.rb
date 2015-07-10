class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :global_site_settings

  def index
    # Yes, this is horrible. Yes, I want to fix it. No, I don't know how to implement componentRestrictions with Geocoder gem. 
    @member_locations = MemberLocation.location_search("#{params[:search_term]}+United+Kingdom", params[:radius], cookies[:allowed]) if params[:search_term].present?
    @members = Member.name_search(params[:name], cookies[:allowed]) if params[:name].present?
  end

  private

  def global_site_settings
    @global_site_settings ||= Optimadmin::SiteSetting.current_environment
  end
  helper_method :global_site_settings
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :global_site_settings

  def index
    #@member_locations = MemberLocation.near(params[:location], params[:radius] || 5).joins(:membership_detail).where(membership_details: { in_practice: 'Y' }) if params[:location].present?
    @member_locations = MemberLocation.location_search(params[:location], params[:radius], cookies[:allowed])
  end
  
  private

  def global_site_settings
    @global_site_settings ||= Optimadmin::SiteSetting.current_environment
  end
  helper_method :global_site_settings
end

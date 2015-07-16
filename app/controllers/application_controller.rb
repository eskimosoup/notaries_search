class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper

  before_action :global_site_settings

  def index
    unless params.slice(:name, :town, :postcode, :radius).blank?
      @member_locations, @radius, @result_information = MemberLocationSearch.new(params.slice(:name, :town, :radius), cookies[:allowed]).call
    end
  end

  private

  def global_site_settings
    @global_site_settings ||= Optimadmin::SiteSetting.current_environment
  end
  helper_method :global_site_settings
end

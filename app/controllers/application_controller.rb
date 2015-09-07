class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper

  before_action :global_site_settings

  def index
    unless params.slice(:name, :town, :postcode, :radius).blank?
      @search = CreateSearch.new(params.slice(:name, :town, :postcode, :radius), cookies[:allowed]).save
      @search_results = @search.search_results.includes(member_location: { member: :member_locations })
    end
  end

  private

  def global_site_settings
    @global_site_settings ||= Optimadmin::SiteSetting.current_environment
  end
  helper_method :global_site_settings
end

module Optimadmin
  class MemberLocationsController < Optimadmin::ApplicationController
    before_action :set_member_location, only: [:show, :edit, :update, :destroy]

    def index
      @member_locations = Optimadmin::BaseCollectionPresenter.new(collection: MemberLocation.search(params[:search]).page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::MemberLocationPresenter)
    end

    def show
    end

    def new
      @member_location = MemberLocation.new
    end

    def edit
    end

    def create
      @member_location = MemberLocation.new(member_location_params)
      if @member_location.save
        redirect_to member_locations_url, notice: 'Member location was successfully created.'
      else
        render :new
      end
    end

    def update
      if @member_location.update(member_location_params)
        redirect_to member_locations_url, notice: 'Member location was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @member_location.destroy
      redirect_to member_locations_url, notice: 'Member location was successfully destroyed.'
    end

  private


    def set_member_location
      @member_location = MemberLocation.find(params[:id])
    end

    def member_location_params
      params.require(:member_location).permit(:member_id, :dx_number, :contact_phone, :contact_mobile, :fax, :website, :address, :town, :county, :postcode, :email, :latitude, :longitude)
    end
  end
end

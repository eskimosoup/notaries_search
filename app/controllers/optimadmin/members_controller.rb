module Optimadmin
  class MembersController < Optimadmin::ApplicationController
    before_action :set_member, only: [:show, :edit, :update, :destroy]

    def index
      @members = Optimadmin::BaseCollectionPresenter.new(collection: Member.where('firstname LIKE :search OR lastname LIKE :search', search: "#{params[:search]}%").page(params[:page]).per(params[:per_page] || 15).order(updated_at: :desc), view_template: view_context, presenter: Optimadmin::MemberPresenter)
    end

    def reimport
      NotariesSocietyUpload.update
      redirect_to members_url, notice: 'Reimport now being processed in the background'
    end

    def show
    end

    def new
      @member = Member.new
    end

    def edit
    end

    def create
      @member = Member.new(member_params)
      if @member.save
        redirect_to members_url, notice: 'Member was successfully created.'
      else
        render :new
      end
    end

    def update
      if @member.update(member_params)
        redirect_to members_url, notice: 'Member was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @member.destroy
      redirect_to members_url, notice: 'Member was successfully destroyed.'
    end

  private


    def set_member
      @member = Member.find(params[:id])
    end

    def member_params
      params.require(:member).permit(:firstname, :lastname, :updated_at)
    end
  end
end

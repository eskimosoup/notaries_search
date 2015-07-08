class MembersController < ApplicationController
  def show
    @member = Member.find(params[:notary])
  end
end

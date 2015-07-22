class MembersController < ApplicationController
  def show
    if params[:notary].blank?
      redirect_to root_url
    else
      @member = Member.find(params[:notary])
      @member.member_page_views.create
    end
  end
end

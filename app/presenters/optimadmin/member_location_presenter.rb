module Optimadmin
  class MemberLocationPresenter < Optimadmin::BasePresenter
    presents :member_location

    def id
      member_location.id
    end

    def title
      member_location.address
    end

    def toggle_title
      inline_detail_toggle_link(title)
    end

    def optimadmin_summary
      "#{member_location.member.firstname} #{member_location.member.lastname}"
    end
  end
end

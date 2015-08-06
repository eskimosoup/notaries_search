module Optimadmin
  class MemberPresenter < Optimadmin::BasePresenter
    presents :member

    def id
      member.id
    end

    def title
      "#{member.firstname} #{member.lastname}"
    end

    def updated_at
      h.l member.updated_at
    end
  end
end

class MemberPageView < ActiveRecord::Base
  belongs_to :member, counter_cache: true
end

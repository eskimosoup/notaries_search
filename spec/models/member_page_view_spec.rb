require 'rails_helper'

RSpec.describe MemberPageView, type: :model do
  describe "associations", :association do
    it { should belong_to(:member).counter_cache(true) }
  end
end

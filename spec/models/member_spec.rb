require 'rails_helper'

RSpec.describe Member, type: :model do

  describe "associations", :association do
    it { should have_many(:member_locations).dependent(:destroy) }
    it { should have_many(:member_page_views).dependent(:destroy) }
    it { should have_one(:membership_detail).dependent(:destroy) }
  end
end

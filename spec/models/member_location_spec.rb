require 'rails_helper'

RSpec.describe MemberLocation, type: :model do
  describe "associations", :association do
    it { should belong_to(:member) }
    it { should have_one(:membership_detail).through(:member) }
  end
end

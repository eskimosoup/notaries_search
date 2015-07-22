require 'rails_helper'

RSpec.describe MembershipDetail, type: :model do
  describe "associations", :association do
    it { should belong_to(:member) }
  end
end

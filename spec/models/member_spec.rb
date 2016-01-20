require 'rails_helper'

RSpec.describe Member, type: :model do

  describe "associations", :association do
    it { should have_many(:member_locations).dependent(:destroy) }
    it { should have_many(:member_page_views).dependent(:destroy) }
    it { should have_one(:membership_detail).dependent(:destroy) }
  end
  
  describe 'validations', :validation do
    it { should validate_uniqueness_of(:contact_id) }
  end

  describe "full name" do
    it "should return the full name" do
      member = build(:member)
      expect(member.full_name).to eq("#{member.firstname} #{ member.lastname }")
    end

    it "should return the first name if no last name" do
      member = build(:member, lastname: nil)
      expect(member.full_name).to eq(member.firstname)
    end

    it "should return the last name if no first name" do
      member = build(:member, firstname: nil)
      expect(member.full_name).to eq(member.lastname)
    end
  end

end

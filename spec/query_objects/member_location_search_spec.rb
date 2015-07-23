require 'rails_helper'

RSpec.describe MemberLocationSearch do
  describe "town and county are one word each" do
    subject(:member_location) { MemberLocationSearch.new({ town: "Crickhowell (Powys)" }, false) }

    it "should set town correctly string input" do
      expect(member_location.town).to eq("Crickhowell")
    end

    it "should set county correctly string input" do
      expect(member_location.county).to eq("Powys")
    end
  end

  describe "multiple word town string input" do
    subject(:member_location) { MemberLocationSearch.new({ town: "Lytham St Annes (Lancashire)" }, false) }

    it "should set town correctly string input" do
      expect(member_location.town).to eq("Lytham St Annes")
    end

    it "should set county correctly string input" do
      expect(member_location.county).to eq("Lancashire")
    end
  end

  describe "multiple word county string input" do
    subject(:member_location) { MemberLocationSearch.new({ town: "Bristol (City of Bristol)" }, false) }

    it "should set town correctly string input" do
      expect(member_location.town).to eq("Bristol")
    end

    it "should set county correctly string input" do
      expect(member_location.county).to eq("City of Bristol")
    end
  end
end

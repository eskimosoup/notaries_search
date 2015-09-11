require 'rails_helper'

RSpec.describe Search, type: :model do
  before(:all) do
    Geocoder.configure(:lookup => :test)

    Geocoder::Lookup::Test.add_stub(
      "HU1 1NQ+united+kingdom", [
        {
          'latitude'     => 53.743316,
          'longitude'    => -0.331004,
          'address'      => 'Hull, Hull, Kingston upon Hull HU1 1NQ, UK',
          'country'      => 'United Kingdom',
          'country_code' => 'GB'
        }
      ]
    )

    Geocoder::Lookup::Test.set_default_stub(
      [
        {
          'latitude'     => 53.743316,
          'longitude'    => -0.331004,
          'address'      => 'Hull, Hull, Kingston upon Hull HU1 1NQ, UK',
          'country'      => 'United Kingdom',
          'country_code' => 'GB'
        }
      ]
    )
  end

  describe "associations", :association do
    it { should have_many(:search_results) }
    it { should have_many(:member_locations).through(:search_results) }
  end

  describe "setting correct search type for name" do
    subject(:search) { build(:search_by_name) }
    it "should use or condition if first name and last name are the same" do
      search.last_name = search.first_name
      expect(search.name_search_type).to eq("OR")
    end

    it "should use or condition if first name and last name are the same" do
      expect(search.name_search_type).to eq("AND")
    end
  end

  describe "name returns the full name of the search" do
    subject(:search) { build(:search_by_name) }
    it "should return only one name if both names are the same" do
      search.last_name = search.first_name
      expect(search.name).to eq(search.first_name)
    end

    it "should return both names if they are different" do
      expect(search.name).to eq("#{ search.first_name } #{ search.last_name }")
    end
  end

  describe "results information is applicable" do
    it "should say the number of notaries found" do
      search = build(:search, search_results_count: 1)
      expect(search.result_information).to eq("We found 1 notary")
    end

    it "should pluralize the number of notaries found" do
      search = build(:search, search_results_count: 2)
      expect(search.result_information).to eq("We found 2 notaries")
    end

    it "has radius information if radius and postcode are set" do
      search = build(:search_by_postcode, search_results_count: 2)
      expect(search.result_information).to eq("We found 2 notaries within #{ search.radius } miles of #{ search.postcode }")
    end

    it "has town information if town is set" do
      search = build(:search_by_town, search_results_count: 2)
      expect(search.result_information).to eq("We found 2 notaries in #{ search.town }")
    end

    it "has name information if name is set" do
      search = build(:search_by_name, search_results_count: 2)
      expect(search.result_information).to eq("We found 2 notaries matching #{ search.name }")
    end
  end

  describe "type of search" do
    it "is a name search" do
      search = build(:search_by_name, search_results_count: 2)
      expect(search.type_of_search).to eq("Name")
    end

    it "is a location search" do
      search = build(:search_by_postcode, search_results_count: 2)
      expect(search.type_of_search).to eq("Location")
    end

    it "is a town search" do
      search = build(:search_by_postcode, search_results_count: 2)
      expect(search.type_of_search).to eq("Location")
    end
  end

end

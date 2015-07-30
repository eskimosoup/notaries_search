require 'rails_helper'

RSpec.describe CreateSearch do
  describe "splitting town and county" do
    it "returns nil if town not set" do
      search_creator = CreateSearch.new({ }, false)
      expect(search_creator.split_town_and_county).to eq({})
    end

    it "works when town and county are one word each" do
      search_creator = CreateSearch.new({ town: "Crickhowell (Powys)" }, false)
      expect(search_creator.split_town_and_county).to eq({ town: "Crickhowell", county: "Powys" })
    end

    it "works when town is multiple words" do
      search_creator = CreateSearch.new({ town: "Lytham St Annes (Lancashire)" }, false)
      expect(search_creator.split_town_and_county).to eq({ town: "Lytham St Annes", county: "Lancashire" })
    end

    it "works when county is multiple words" do
      search_creator = CreateSearch.new({ town: "Bristol (City of Bristol)" }, false)
      expect(search_creator.split_town_and_county).to eq({ town: "Bristol", county: "City of Bristol" })
    end
  end

  describe "splitting the name" do
    it "returns nil if name not set" do
      search_creator = CreateSearch.new({ }, false)
      expect(search_creator.split_name).to eq({})
    end

    it "returns first name and last name as the same when name is one word" do
      search_creator = CreateSearch.new({ name: "Robert" }, false)
      expect(search_creator.split_name).to eq({ first_name: "Robert", last_name: "Robert" })
    end

    it "should work when name is two words" do
      search_creator = CreateSearch.new({ name: "Joe Bloggs" }, false)
      expect(search_creator.split_name).to eq({ first_name: "Joe", last_name: "Bloggs" })
    end

    it "should ignore the middle names when name is more than two words" do
      search_creator = CreateSearch.new({ name: "Joe Robert Bloggs" }, false)
      expect(search_creator.split_name).to eq({ first_name: "Joe", last_name: "Bloggs" })
    end
  end

  describe "postcode and radius hash" do
    it "returns and empty hash if not set" do
      search_creator = CreateSearch.new({ }, false)
      expect(search_creator.postcode_and_radius).to eq({})
    end

    it "correctly returns the hash when set" do
      search_creator = CreateSearch.new({ postcode: "HU1 1NQ", radius: 10 }, false)
      expect(search_creator.postcode_and_radius).to eq({ postcode: "HU1 1NQ", radius: 10 })
    end
  end


  describe "building hash for search" do
    it "merges the hashes" do
      search_creator = CreateSearch.new({ name: "Joe Robert Bloggs", town: "Crickhowell (Powys)", postcode: "HU1 1NQ", radius: 10 }, false)
      expect(search_creator.search_hash).to eq({ first_name: "Joe", last_name: "Bloggs", town: "Crickhowell", county: "Powys", postcode: "HU1 1NQ", radius: 10, show_all: false})
    end

    it "adds show all to be true" do
      search_creator = CreateSearch.new({ name: "Joe Robert Bloggs", town: "Crickhowell (Powys)", postcode: "HU1 1NQ", radius: 10 }, true)
      expect(search_creator.search_hash).to eq({ first_name: "Joe", last_name: "Bloggs", town: "Crickhowell", county: "Powys", postcode: "HU1 1NQ", radius: 10, show_all: true})
    end
  end
end
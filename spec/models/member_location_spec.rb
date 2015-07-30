require 'rails_helper'

RSpec.describe MemberLocation, type: :model do

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
    it { should belong_to(:member) }
    it { should have_one(:membership_detail).through(:member) }
  end
end

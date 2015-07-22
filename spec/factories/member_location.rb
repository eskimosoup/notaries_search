FactoryGirl.define do
  factory :member_location do
    member
    contact_phone "47"
    contact_mobile "47"
    fax "47"
    website "http://www.google.co.uk"
    address "Some street"
    town "Hull"
    county "Yorkshire"
    postcode "HU1 1NQ"
    email { "#{member.username}@example.com" }
    latitude 53.743316
    longitude -0.331004
  end
end
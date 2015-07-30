FactoryGirl.define do
  factory :member do
    sequence(:username) {|n| "member#{n}" }
    email { "#{username}@example.com" }
    firstname "James"
    lastname "Paul"

    factory :member_with_locations do
      transient do
        member_locations_count 1
      end

      after(:create) do |member, evaluator|
        create_list(:member_location, evaluator.member_locations_count, member: member)
      end
    end
  end
end
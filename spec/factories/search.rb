FactoryGirl.define do
  factory :search do

    trait :showing_all do
      show_all true
    end

    trait :not_showing_all do
      show_all false
    end

    trait :name do
      first_name "James"
      last_name "Paul"
    end

    trait :town_and_county do
      town "Hull"
      county "Yorkshire"
    end

    trait :postcode do
      postcode "HU1 1NQ"
    end

    factory :search_by_name, traits: [:name]
    factory :search_by_town, traits: [:town_and_county]
    factory :search_by_postcode, traits: [:postcode]

  end
end
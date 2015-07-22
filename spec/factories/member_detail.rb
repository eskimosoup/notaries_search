FactoryGirl.define do
  factory :membership_detail do
    member

    trait :in_practice do
      in_practice "Y"
    end

    trait :out_of_practice do
      in_practice "N"
    end

    factory :practising_membership_detail, traits: [:in_practice]
    factory :not_practising_membership_detail, traits: [:out_of_practice]
  end
end

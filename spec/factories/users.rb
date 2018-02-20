FactoryBot.define do

  factory :user do
    first_name "Example"
    last_name "Example"
    email "example@gmail.com"

    trait :name_valid do
      first_name "Example"
    end

    trait :name_invalid do
      first_name nil
    end
  end

  factory :other_user, parent: :user do; end
end

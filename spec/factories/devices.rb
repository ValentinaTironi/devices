FactoryBot.define do

  factory :device do
    id 1
    mac_address 1234
    association :user, factory: :user

    trait :name_valid do
      name "Example"
    end

    trait :name_invalid do
      nil
    end
  end
end

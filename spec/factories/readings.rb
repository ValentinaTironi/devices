FactoryBot.define do

  factory :reading do
    date '2018-02-27'
    association :device, factory: :device

    trait :value_valid do
      value 'Example'
    end

    trait :value_invalid do
      value nil
    end
  end
end

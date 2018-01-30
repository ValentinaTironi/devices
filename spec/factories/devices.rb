FactoryBot.define do

  factory :device do
    id 1
    name 'Example'
    mac_address 1234
  end

  factory :invalid_device, parent: :device do
    name ''
    mac_address nil
  end

end
